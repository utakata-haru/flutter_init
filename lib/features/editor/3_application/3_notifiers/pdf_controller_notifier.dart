import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../1_domain/1_entities/edited_pdf.dart';
import '../2_providers/pdf_providers.dart';

part 'pdf_controller_notifier.g.dart';

@riverpod
class PdfControllerNotifier extends _$PdfControllerNotifier {
  @override
  Future<EditedPdf?> build() async {
    return null; // Initially no PDF loaded
  }

  Future<void> loadPdf(String path) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(pdfRepositoryProvider);
      final pdf = await repository.loadPdf(path);
      state = AsyncValue.data(pdf);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void rotatePage(int index) {
    final currentPdf = state.value;
    if (currentPdf == null) return;

    final currentRotation = currentPdf.pageRotations[index] ?? 0;
    final newRotation = (currentRotation + 90) % 360;

    final newRotations = Map<int, int>.from(currentPdf.pageRotations);
    newRotations[index] = newRotation;

    state = AsyncValue.data(currentPdf.copyWith(pageRotations: newRotations));
  }

  void deletePage(int index) {
    final currentPdf = state.value;
    if (currentPdf == null) return;

    final newOrder = List<int>.from(currentPdf.pageOrder);
    newOrder.removeAt(index);

    state = AsyncValue.data(currentPdf.copyWith(pageOrder: newOrder));
  }

  void reorderPage(int oldIndex, int newIndex) {
    final currentPdf = state.value;
    if (currentPdf == null) return;

    final newOrder = List<int>.from(currentPdf.pageOrder);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = newOrder.removeAt(oldIndex);
    newOrder.insert(newIndex, item);

    state = AsyncValue.data(currentPdf.copyWith(pageOrder: newOrder));
  }

  void cropPage(int originalPageIndex, List<double> cropRect) {
    final currentPdf = state.value;
    if (currentPdf == null) return;

    final newCrops = Map<int, List<double>>.from(currentPdf.pageCrops);
    newCrops[originalPageIndex] = cropRect;

    state = AsyncValue.data(currentPdf.copyWith(pageCrops: newCrops));
  }

  Future<void> savePdf(String outputPath) async {
    final currentPdf = state.value;
    if (currentPdf == null) return;

    final repository = ref.read(pdfRepositoryProvider);
    await repository.savePdf(currentPdf, outputPath);
  }
}
