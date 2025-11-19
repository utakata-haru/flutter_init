import 'dart:typed_data';
import '../1_entities/edited_pdf.dart';

abstract interface class PdfRepository {
  Future<EditedPdf> loadPdf(String path);
  Future<String> savePdf(EditedPdf pdf, String outputPath);
  Future<Uint8List> generatePreview(EditedPdf pdf);
}
