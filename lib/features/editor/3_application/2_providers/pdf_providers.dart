import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../1_domain/2_repositories/pdf_repository.dart';
import '../../2_infrastructure/3_repositories/pdf_repository_impl.dart';

part 'pdf_providers.g.dart';

@riverpod
PdfRepository pdfRepository(Ref ref) {
  return PdfRepositoryImpl();
}
