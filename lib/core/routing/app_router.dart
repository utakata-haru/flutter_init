import 'package:go_router/go_router.dart';

import '../../features/user/map/4_presentation/2_pages/map_page.dart';
import '../../features/user/onboarding/4_presentation/2_pages/splash_page.dart';
import 'path/app_paths.dart';

/// App router configuration
class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppPaths.splash,
      routes: [
        // Onboarding
        GoRoute(
          path: AppPaths.splash,
          builder: (context, state) => const SplashPage(),
        ),

        // Main
        GoRoute(
          path: AppPaths.home,
          builder: (context, state) => const MapPage(),
        ),

        // TODO: Add other routes
      ],
    );
  }
}
