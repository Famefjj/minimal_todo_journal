import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_todo_journal/app/app_shell.dart';
import 'package:minimal_todo_journal/app/router/app_routes.dart';
import 'package:minimal_todo_journal/features/progress/presentations/screens/progress_screen.dart';
import 'package:minimal_todo_journal/features/settings/presentations/screens/settings_screen.dart';
import 'package:minimal_todo_journal/features/today/presentations/screens/today_screen.dart';
import 'package:minimal_todo_journal/features/todos/presentations/screens/todos_screen.dart';

class AppRouter {
  const AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigationKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigationKey,
    initialLocation: AppRoutes.today,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.today,
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.todos,
                builder: (context, state) => const TodosScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
