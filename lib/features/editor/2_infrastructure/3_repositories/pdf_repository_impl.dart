import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:uuid/uuid.dart';
import '../../1_domain/1_entities/edited_pdf.dart';
import '../../1_domain/2_repositories/pdf_repository.dart';

class PdfRepositoryImpl implements PdfRepository {
  @override
  Future<EditedPdf> loadPdf(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();

    final pageImages = <Uint8List>[];

    // Rasterize all pages to images
    await for (final page in Printing.raster(bytes, dpi: 144.0)) {
      final imageBytes = await page.toPng();
      pageImages.add(imageBytes);
    }

    final pageOrder = List.generate(pageImages.length, (index) => index);
    final pageRotations = {for (var i in pageOrder) i: 0};

    return EditedPdf(
      id: const Uuid().v4(),
      originalPath: path,
      pageImages: pageImages,
      pageOrder: pageOrder,
      pageRotations: pageRotations,
      pageCrops: {},
    );
  }

  @override
  Future<String> savePdf(EditedPdf pdf, String outputPath) async {
    final doc = pw.Document();

    // 元PDFから各ページのオリジナルサイズ（pt）とラスタ画像のピクセルサイズを取得
    final originalFile = File(pdf.originalPath);
    final originalBytes = await originalFile.readAsBytes();
    const dpi = 144.0; // ラスタ化に利用するDPI（pt=72なのでptへの換算に利用）
    final originalFormats = <PdfPageFormat>[]; // ページサイズ（pt）
    final pixelSizes = <List<double>>[]; // [widthPx, heightPx]
    await for (final page in Printing.raster(originalBytes, dpi: dpi)) {
      final widthPt = page.width * 72.0 / dpi;
      final heightPt = page.height * 72.0 / dpi;
      originalFormats.add(PdfPageFormat(widthPt, heightPt));
      pixelSizes.add([page.width.toDouble(), page.height.toDouble()]);
    }

    for (final index in pdf.pageOrder) {
      final imageBytes = pdf.pageImages[index];
      final rotation = pdf.pageRotations[index] ?? 0;
      final crop =
          pdf.pageCrops[index]; // List<double> [left, top, width, height]

      final image = pw.MemoryImage(imageBytes);

      doc.addPage(
        pw.Page(
          pageFormat: originalFormats[index],
          build: (pw.Context context) {
            final pageWidth = originalFormats[index].width;
            final pageHeight = originalFormats[index].height;

            // 画像のアスペクト（ラスタのピクセル寸法から算出）
            final imgW = pixelSizes[index][0];
            final imgH = pixelSizes[index][1];
            final aspect = imgW / imgH;
            final pageAspect = pageWidth / pageHeight;

            double renderWidth;
            double renderHeight;
            double offsetX;
            double offsetY;
            if (aspect > pageAspect) {
              // 横がはみ出る → 幅合わせ
              renderWidth = pageWidth;
              renderHeight = pageWidth / aspect;
              offsetX = 0;
              offsetY = (pageHeight - renderHeight) / 2;
            } else {
              // 縦がはみ出る → 高さ合わせ
              renderHeight = pageHeight;
              renderWidth = pageHeight * aspect;
              offsetX = (pageWidth - renderWidth) / 2;
              offsetY = 0;
            }

            // 画像描画と白いマスクを同一座標系でまとめて回転
            return pw.Center(
              child: pw.Transform.rotate(
                angle: rotation * 3.14159 / 180,
                child: pw.SizedBox(
                  width: pageWidth,
                  height: pageHeight,
                  child: pw.Stack(
                    children: [
                      // 背景を白で塗りつぶし
                      pw.Positioned.fill(
                        child: pw.Container(color: PdfColors.white),
                      ),
                      // 画像をアスペクト維持でページ内に配置（contain）
                      pw.Positioned(
                        left: offsetX,
                        top: offsetY,
                        child: pw.Image(
                          image,
                          width: renderWidth,
                          height: renderHeight,
                        ),
                      ),
                      if (crop != null) ...() {
                        // cropは正規化値 [left, top, width, height]（画像座標系）
                        final left = (offsetX + crop[0] * renderWidth)
                            .clamp(0.0, pageWidth)
                            .toDouble();
                        final top = (offsetY + crop[1] * renderHeight)
                            .clamp(0.0, pageHeight)
                            .toDouble();
                        final cw = (crop[2] * renderWidth)
                            .clamp(0.0, pageWidth)
                            .toDouble();
                        final ch = (crop[3] * renderHeight)
                            .clamp(0.0, pageHeight)
                            .toDouble();
                        final right = (left + cw)
                            .clamp(0.0, pageWidth)
                            .toDouble();
                        final bottom = (top + ch)
                            .clamp(0.0, pageHeight)
                            .toDouble();

                        return [
                          // 上側マスク
                          pw.Positioned(
                            left: 0,
                            top: 0,
                            child: pw.SizedBox(
                              width: pageWidth,
                              height: top,
                              child: pw.Container(color: PdfColors.white),
                            ),
                          ),
                          // 下側マスク
                          pw.Positioned(
                            left: 0,
                            top: bottom,
                            child: pw.SizedBox(
                              width: pageWidth,
                              height: pageHeight - bottom,
                              child: pw.Container(color: PdfColors.white),
                            ),
                          ),
                          // 左側マスク（クロップ縦範囲内）
                          pw.Positioned(
                            left: 0,
                            top: top,
                            child: pw.SizedBox(
                              width: left,
                              height: ch,
                              child: pw.Container(color: PdfColors.white),
                            ),
                          ),
                          // 右側マスク（クロップ縦範囲内）
                          pw.Positioned(
                            left: right,
                            top: top,
                            child: pw.SizedBox(
                              width: pageWidth - right,
                              height: ch,
                              child: pw.Container(color: PdfColors.white),
                            ),
                          ),
                        ];
                      }(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    final file = File(outputPath);
    await file.writeAsBytes(await doc.save());
    return outputPath;
  }

  @override
  Future<Uint8List> generatePreview(EditedPdf pdf) async {
    // For now, just return the first page's image
    if (pdf.pageImages.isNotEmpty) {
      return pdf.pageImages[pdf.pageOrder.first];
    }
    return Uint8List(0);
  }
}
