import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_init_3/core/routing/path/routine_dashboard_path.dart';
import 'package:flutter_init_3/core/routing/path/routine_settings_path.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/2_pages/routine_dashboard_page.dart';
import 'package:flutter_init_3/features/user/routine_status/4_presentation/2_pages/routine_settings_page.dart';

final List<RouteBase> routineStatusRoutes = <RouteBase>[
  GoRoute(
    path: routineDashboardPath,
    name: routineDashboardRouteName,
    pageBuilder: (context, state) =>
        const NoTransitionPage<void>(child: RoutineDashboardPage()),
    routes: <RouteBase>[
      GoRoute(
        path: routineSettingsPathSegment,
        name: routineSettingsRouteName,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: RoutineSettingsPage()),
      ),
    ],
  ),
];

GoRouter createAppRouter() => GoRouter(
  routes: routineStatusRoutes,
  initialLocation: routineDashboardLocation(),
  debugLogDiagnostics: false,
  observers: const <NavigatorObserver>[],
);
