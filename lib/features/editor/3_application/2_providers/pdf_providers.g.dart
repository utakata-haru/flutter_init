// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pdfRepository)
const pdfRepositoryProvider = PdfRepositoryProvider._();

final class PdfRepositoryProvider
    extends $FunctionalProvider<PdfRepository, PdfRepository, PdfRepository>
    with $Provider<PdfRepository> {
  const PdfRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pdfRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pdfRepositoryHash();

  @$internal
  @override
  $ProviderElement<PdfRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PdfRepository create(Ref ref) {
    return pdfRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PdfRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PdfRepository>(value),
    );
  }
}

String _$pdfRepositoryHash() => r'feb35afb27e340ac733589596a9ffd83c85fe93c';
