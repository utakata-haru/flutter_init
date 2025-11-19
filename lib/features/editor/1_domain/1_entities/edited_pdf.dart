import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';

part 'edited_pdf.freezed.dart';

@freezed
abstract class EditedPdf with _$EditedPdf {
  const factory EditedPdf({
    required String id,
    required String originalPath,
    required List<Uint8List> pageImages, // Thumbnails for grid
    required List<int> pageOrder, // Indices of original pages
    required Map<int, int>
    pageRotations, // Rotation in degrees (0, 90, 180, 270) per current page index
    required Map<int, List<double>>
    pageCrops, // Normalized crop rect (left, top, width, height) per current page index
  }) = _EditedPdf;
}
