import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/src/features/family/presentation/screens/family_dashboard_screen.dart';

/// Provides the global [GoRouter] configuration for the application.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const FamilyDashboardScreen(),
      ),
    ],
  );
});
