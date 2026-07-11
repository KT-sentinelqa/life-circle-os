import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import 'app_destination.dart';
import '../app_shell.dart';
import '../placeholders/placeholder_screen.dart';

/// AppRouter — Declarative Router for LifeCircle OS
///
/// Uses go_router with a ShellRoute to maintain the persistent App Shell
/// (bottom navigation bar, offline banner, sync indicator) across all
/// primary destinations.
///
/// Design principle: the router knows about destinations, not business logic.
/// Feature module screens are imported here but remain completely unaware
/// of routing. Navigation is always initiated via `context.go(AppRoutes.x)`.
///
/// Adding a new primary destination:
///   1. Add a constant to [AppRoutes].
///   2. Add a [GoRoute] inside the [ShellRoute].
///   3. Register an [AppDestination] via [LcDestinations.registerDefaults].
///   No shell code changes required.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: false, // Enable in debug builds only
    routes: [
      // ── SHELL (persistent bottom nav + global UI) ──────────────
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => _fade(
              state,
              const PlaceholderScreen(
                title: 'Home',
                icon: Icons.home_rounded,
                description: 'Your family dashboard will appear here.',
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.timeline,
            pageBuilder: (context, state) => _fade(
              state,
              const PlaceholderScreen(
                title: 'Timeline',
                icon: Icons.timeline_rounded,
                description: 'Your family\'s shared timeline lives here.',
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.planning,
            pageBuilder: (context, state) => _fade(
              state,
              const PlaceholderScreen(
                title: 'Planning',
                icon: Icons.check_circle_rounded,
                description: 'Family tasks and schedules will appear here.',
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.family,
            pageBuilder: (context, state) => _fade(
              state,
              const PlaceholderScreen(
                title: 'Family',
                icon: Icons.group_rounded,
                description: 'Manage your family members here.',
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.more,
            pageBuilder: (context, state) => _fade(
              state,
              const PlaceholderScreen(
                title: 'All Features',
                icon: Icons.grid_view_rounded,
                description: 'Access Medicines, Finance, Documents, Vehicles, and more.',
              ),
            ),
          ),
        ],
      ),
    ],
  );

  /// Shared fade transition for all shell routes — avoids jarring jumps
  /// between tabs while preserving the spatial model for nested navigation.
  static CustomTransitionPage<void> _fade(GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 180),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
