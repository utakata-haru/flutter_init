import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../1_domain/1_entities/edited_pdf.dart';
import '../../3_application/3_notifiers/pdf_controller_notifier.dart';
import '../2_pages/crop_page.dart';
part 'cropped_image.dart';

class PdfPreviewGrid extends ConsumerWidget {
  const PdfPreviewGrid({super.key, required this.pdf});

  final EditedPdf pdf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(pdfControllerProvider.notifier);

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pdf.pageOrder.length,
      onReorder: (oldIndex, newIndex) {
        notifier.reorderPage(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final pageIndex = pdf.pageOrder[index];
        final imageBytes = pdf.pageImages[pageIndex];
        final rotation = pdf.pageRotations[pageIndex] ?? 0;

        return Card(
          key: ValueKey(pageIndex), // Unique key based on original page index
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey[200],
                    child: RotatedBox(
                      quarterTurns: rotation ~/ 90,
                      child: _CroppedImage(
                        imageBytes: imageBytes,
                        crop: pdf.pageCrops[pageIndex],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => notifier.deletePage(index),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Page ${pageIndex + 1}'),
                    IconButton(
                      icon: const Icon(Icons.crop),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CropPage(
                              imageBytes: imageBytes,
                              initialCrop: pdf.pageCrops[pageIndex],
                              onSave: (rect) {
                                notifier.cropPage(pageIndex, rect);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.rotate_right),
                      onPressed: () => notifier.rotatePage(pageIndex),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
