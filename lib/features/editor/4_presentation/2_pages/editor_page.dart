import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../3_application/3_notifiers/pdf_controller_notifier.dart';
import '../1_widgets/pdf_preview_grid.dart';

class EditorPage extends HookConsumerWidget {
  const EditorPage({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfState = ref.watch(pdfControllerProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(pdfControllerProvider.notifier).loadPdf(filePath);
      });
      return null;
    }, [filePath]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _saveAndSharePdf(context, ref),
          ),
        ],
      ),
      body: pdfState.when(
        data: (pdf) {
          if (pdf == null) return const Center(child: CircularProgressIndicator());
          if (pdf.pageOrder.isEmpty) {
             return const Center(child: Text('No pages left.'));
          }
          return PdfPreviewGrid(pdf: pdf);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _saveAndSharePdf(BuildContext context, WidgetRef ref) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final outputPath = '${dir.path}/edited_${DateTime.now().millisecondsSinceEpoch}.pdf';
      
      await ref.read(pdfControllerProvider.notifier).savePdf(outputPath);
      
      if (context.mounted) {
        await Share.shareXFiles([XFile(outputPath)], text: 'Here is your edited PDF');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving/sharing: $e')),
        );
      }
    }
  }
}
