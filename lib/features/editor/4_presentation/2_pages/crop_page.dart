import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CropPage extends HookWidget {
  const CropPage({
    super.key,
    required this.imageBytes,
    required this.initialCrop,
    required this.onSave,
  });

  final Uint8List imageBytes;
  final List<double>? initialCrop; // [left, top, width, height] 0.0-1.0
  final ValueChanged<List<double>> onSave;

  @override
  Widget build(BuildContext context) {
    // Crop rect state: normalized coordinates
    final cropRect = useState<List<double>>(
      initialCrop ?? [0.0, 0.0, 1.0, 1.0],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              onSave(cropRect.value);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image
                Image.memory(
                  imageBytes,
                  fit: BoxFit.contain,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                // Overlay
                _CropOverlay(
                  constraints: constraints,
                  imageBytes: imageBytes,
                  cropRect: cropRect,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CropOverlay extends HookWidget {
  const _CropOverlay({
    required this.constraints,
    required this.imageBytes,
    required this.cropRect,
  });

  final BoxConstraints constraints;
  final Uint8List imageBytes;
  final ValueNotifier<List<double>> cropRect;

  @override
  Widget build(BuildContext context) {
    // We need to know the actual rendered size of the image to map touch points to normalized coordinates.
    // Since Image.memory with BoxFit.contain preserves aspect ratio, we need to calculate the rendered rect.

    final imageInfo = useFuture(
      useMemoized(() async {
        // Simple way to get image dimensions
        final decodedImage = await decodeImageFromList(imageBytes);
        return Size(
          decodedImage.width.toDouble(),
          decodedImage.height.toDouble(),
        );
      }),
    );

    if (!imageInfo.hasData) {
      return const SizedBox.shrink();
    }

    final imgSize = imageInfo.data!;
    final aspect = imgSize.width / imgSize.height;
    final containerAspect = constraints.maxWidth / constraints.maxHeight;

    double renderWidth;
    double renderHeight;
    double offsetX;
    double offsetY;

    if (aspect > containerAspect) {
      // Limited by width
      renderWidth = constraints.maxWidth;
      renderHeight = constraints.maxWidth / aspect;
      offsetX = 0;
      offsetY = (constraints.maxHeight - renderHeight) / 2;
    } else {
      // Limited by height
      renderHeight = constraints.maxHeight;
      renderWidth = constraints.maxHeight * aspect;
      offsetX = (constraints.maxWidth - renderWidth) / 2;
      offsetY = 0;
    }

    // Helper to convert normalized to local pixels
    Rect getPixelRect(List<double> norm) {
      return Rect.fromLTWH(
        offsetX + norm[0] * renderWidth,
        offsetY + norm[1] * renderHeight,
        norm[2] * renderWidth,
        norm[3] * renderHeight,
      );
    }

    // Helper to convert local pixels to normalized
    List<double> getNormRect(Rect pixelRect) {
      double l = (pixelRect.left - offsetX) / renderWidth;
      double t = (pixelRect.top - offsetY) / renderHeight;
      double w = pixelRect.width / renderWidth;
      double h = pixelRect.height / renderHeight;
      return [
        l.clamp(0.0, 1.0),
        t.clamp(0.0, 1.0),
        w.clamp(0.0, 1.0 - l), // Ensure width doesn't exceed bounds
        h.clamp(0.0, 1.0 - t), // Ensure height doesn't exceed bounds
      ];
    }

    final rect = getPixelRect(cropRect.value);

    return Stack(
      children: [
        // Darken outside area
        Positioned.fill(
          child: CustomPaint(
            painter: _OverlayPainter(
              cropRect: rect,
              fullRect: Rect.fromLTWH(
                offsetX,
                offsetY,
                renderWidth,
                renderHeight,
              ),
            ),
          ),
        ),
        // Draggable corners/sides could be implemented here.
        // For MVP, let's just implement a simple pan/resize gesture detector on the rect itself?
        // Or a simple "drag to create rect" if we want to reset.
        // Let's implement a simple 8-handle resizer.

        // Top-Left
        Positioned(
          left: rect.left - 10,
          top: rect.top - 10,
          child: GestureDetector(
            onPanUpdate: (details) {
              final newLeft = (rect.left + details.delta.dx).clamp(
                offsetX,
                rect.right - 20,
              );
              final newTop = (rect.top + details.delta.dy).clamp(
                offsetY,
                rect.bottom - 20,
              );
              cropRect.value = getNormRect(
                Rect.fromLTRB(newLeft, newTop, rect.right, rect.bottom),
              );
            },
            child: const Icon(Icons.crop_free, color: Colors.white),
          ),
        ),

        // Bottom-Right
        Positioned(
          left: rect.right - 10,
          top: rect.bottom - 10,
          child: GestureDetector(
            onPanUpdate: (details) {
              final newRight = (rect.right + details.delta.dx).clamp(
                rect.left + 20,
                offsetX + renderWidth,
              );
              final newBottom = (rect.bottom + details.delta.dy).clamp(
                rect.top + 20,
                offsetY + renderHeight,
              );
              cropRect.value = getNormRect(
                Rect.fromLTRB(rect.left, rect.top, newRight, newBottom),
              );
            },
            child: const Icon(Icons.crop_free, color: Colors.white),
          ),
        ),

        // Center (Move)
        Positioned.fromRect(
          rect: rect.deflate(10),
          child: GestureDetector(
            onPanUpdate: (details) {
              double dx = details.delta.dx;
              double dy = details.delta.dy;

              if (rect.left + dx < offsetX) dx = offsetX - rect.left;
              if (rect.right + dx > offsetX + renderWidth)
                dx = offsetX + renderWidth - rect.right;
              if (rect.top + dy < offsetY) dy = offsetY - rect.top;
              if (rect.bottom + dy > offsetY + renderHeight)
                dy = offsetY + renderHeight - rect.bottom;

              cropRect.value = getNormRect(rect.shift(Offset(dx, dy)));
            },
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}

class _OverlayPainter extends CustomPainter {
  _OverlayPainter({required this.cropRect, required this.fullRect});
  final Rect cropRect;
  final Rect fullRect;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;

    // Draw 4 rectangles around the crop rect
    // Top
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, cropRect.top), paint);
    // Bottom
    canvas.drawRect(
      Rect.fromLTRB(0, cropRect.bottom, size.width, size.height),
      paint,
    );
    // Left
    canvas.drawRect(
      Rect.fromLTRB(0, cropRect.top, cropRect.left, cropRect.bottom),
      paint,
    );
    // Right
    canvas.drawRect(
      Rect.fromLTRB(cropRect.right, cropRect.top, size.width, cropRect.bottom),
      paint,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(cropRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
