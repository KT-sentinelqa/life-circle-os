import 'package:flutter/material.dart';

/// AppDestination — The Navigation Contract for LifeCircle OS
///
/// This is the extensible boundary that keeps the App Shell decoupled
/// from any specific product domain. New bounded contexts register their
/// destinations here without touching the shell itself.
///
/// Architectural guarantee (from the review):
///   "Design it so new bounded contexts can register destinations through
///    a well-defined navigation contract rather than requiring changes
///    throughout the shell."
///
/// To add a new primary destination, create an [AppDestination] and add it
/// to the [AppDestinationRegistry]. The shell reads from the registry.
@immutable
class AppDestination {
  const AppDestination({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.semanticsLabel,
  });

  /// The go_router route path (e.g., '/home', '/timeline')
  final String route;

  /// Human-readable label for the navigation bar
  final String label;

  /// Unselected state icon
  final IconData icon;

  /// Selected state icon (filled variant)
  final IconData selectedIcon;

  /// Accessibility label — defaults to [label] if not provided
  final String? semanticsLabel;

  String get accessibilityLabel => semanticsLabel ?? label;
}

/// The registry that the App Shell reads to build navigation.
///
/// Feature modules that need a primary navigation entry point
/// call [AppDestinationRegistry.register] during app initialisation.
/// The shell always rebuilds from the registry — no hardcoded entries.
class AppDestinationRegistry {
  AppDestinationRegistry._();

  static final _instance = AppDestinationRegistry._();
  static AppDestinationRegistry get instance => _instance;

  final _destinations = <AppDestination>[];

  List<AppDestination> get destinations => List.unmodifiable(_destinations);

  void register(AppDestination destination) {
    if (_destinations.any((d) => d.route == destination.route)) return; // idempotent
    _destinations.add(destination);
  }

  void registerAll(List<AppDestination> destinations) {
    for (final d in destinations) { register(d); }
  }
}

/// The 5 core primary navigation destinations for v1.0.
///
/// These are registered during app startup. Future domains may add entries
/// under the 'More' sheet rather than a primary tab, maintaining a clean
/// 5-tab bottom bar.
abstract final class LcDestinations {
  LcDestinations._();

  static const home = AppDestination(
    route: '/home',
    label: 'Home',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    semanticsLabel: 'Home dashboard',
  );

  static const timeline = AppDestination(
    route: '/timeline',
    label: 'Timeline',
    icon: Icons.timeline_outlined,
    selectedIcon: Icons.timeline_rounded,
    semanticsLabel: 'Family timeline',
  );

  static const planning = AppDestination(
    route: '/planning',
    label: 'Planning',
    icon: Icons.check_circle_outline_rounded,
    selectedIcon: Icons.check_circle_rounded,
    semanticsLabel: 'Family planning and tasks',
  );

  static const family = AppDestination(
    route: '/family',
    label: 'Family',
    icon: Icons.group_outlined,
    selectedIcon: Icons.group_rounded,
    semanticsLabel: 'Family members',
  );

  static const more = AppDestination(
    route: '/more',
    label: 'More',
    icon: Icons.grid_view_outlined,
    selectedIcon: Icons.grid_view_rounded,
    semanticsLabel: 'All features',
  );

  /// Register the default v1.0 destinations during app startup.
  static void registerDefaults() {
    AppDestinationRegistry.instance.registerAll([
      home, timeline, planning, family, more,
    ]);
  }
}
