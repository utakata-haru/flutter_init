part of 'pdf_preview_grid.dart';

class _CroppedImage extends StatelessWidget {
  const _CroppedImage({required this.imageBytes, this.crop});

  final Uint8List imageBytes;
  final List<double>? crop;

  @override
  Widget build(BuildContext context) {
    if (crop == null) {
      return Image.memory(imageBytes, fit: BoxFit.contain);
    }

    final left = crop![0];
    final top = crop![1];
    final width = crop![2];
    final height = crop![3];

    // Calculate alignment (-1.0 to 1.0)
    // If width is 1.0, alignment doesn't matter (use 0)
    // alignment = (left / (1 - width)) * 2 - 1

    double alignX = 0;
    if (width < 1.0) {
      alignX = (left / (1.0 - width)) * 2 - 1;
    }

    double alignY = 0;
    if (height < 1.0) {
      alignY = (top / (1.0 - height)) * 2 - 1;
    }

    return FittedBox(
      fit: BoxFit.contain,
      child: ClipRect(
        child: Align(
          alignment: Alignment(alignX, alignY),
          widthFactor: width,
          heightFactor: height,
          child: Image.memory(imageBytes),
        ),
      ),
    );
  }
}
