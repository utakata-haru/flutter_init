// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_controller_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PdfControllerNotifier)
const pdfControllerProvider = PdfControllerNotifierProvider._();

final class PdfControllerNotifierProvider
    extends $AsyncNotifierProvider<PdfControllerNotifier, EditedPdf?> {
  const PdfControllerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pdfControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pdfControllerNotifierHash();

  @$internal
  @override
  PdfControllerNotifier create() => PdfControllerNotifier();
}

String _$pdfControllerNotifierHash() =>
    r'8d3dc3b108752fd16912e16da31dcd935681dbd9';

abstract class _$PdfControllerNotifier extends $AsyncNotifier<EditedPdf?> {
  FutureOr<EditedPdf?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<EditedPdf?>, EditedPdf?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EditedPdf?>, EditedPdf?>,
              AsyncValue<EditedPdf?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
