import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/home/4_presentation/2_pages/home_page.dart';
import '../../features/editor/4_presentation/2_pages/editor_page.dart';

part 'app_routes.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/editor',
        builder: (context, state) {
          final filePath = state.extra as String;
          return EditorPage(filePath: filePath);
        },
      ),
    ],
  );
}
