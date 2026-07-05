import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/core/navigation/fade_page_route.dart';
import 'package:lifecircle_mobile/src/core/navigation/shared_axis_page_route.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/auth_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/invite_members_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/onboarding_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/splash_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/wizard/create_family_wizard_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/wizard/join_family_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/wizard/wizard_choice_screen.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/screens/family_dashboard_screen.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/screens/medicine_dashboard_screen.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/screens/medicine_form_screen.dart';

/// Provides the global [GoRouter] configuration for the application.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      if (authState.isLoading) return '/splash';

      final user = authState.valueOrNull;
      final isGoingToSplash = state.uri.path == '/splash';
      final isGoingToOnboarding = state.uri.path == '/onboarding';
      final isGoingToAuth = state.uri.path == '/auth';

      final isUnauthenticatedRoute =
          isGoingToSplash || isGoingToOnboarding || isGoingToAuth;

      if (user == null) {
        if (isGoingToSplash) return '/onboarding';
        if (isUnauthenticatedRoute) return null;
        return '/onboarding';
      }

      if (user.familyId == null) {
        if (!state.uri.path.startsWith('/wizard')) {
          return '/wizard';
        }
        return null;
      }

      if (isUnauthenticatedRoute || state.uri.path.startsWith('/wizard')) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => FadePageRoute(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => FadePageRoute(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/wizard',
        pageBuilder: (context, state) => SharedAxisPageRoute(
          key: state.pageKey,
          child: const WizardChoiceScreen(),
        ),
        routes: [
          GoRoute(
            path: 'create',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const CreateFamilyWizardScreen(),
            ),
          ),
          GoRoute(
            path: 'join',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const JoinFamilyScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/invite_members',
        builder: (context, state) => const InviteMembersScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        pageBuilder: (context, state) => SharedAxisPageRoute(
          key: state.pageKey,
          child: const FamilyDashboardScreen(),
        ),
      ),
      GoRoute(
        path: '/medicine',
        pageBuilder: (context, state) => SharedAxisPageRoute(
          key: state.pageKey,
          child: const MedicineDashboardScreen(),
        ),
      ),
      GoRoute(
        path: '/medicine/form',
        pageBuilder: (context, state) {
          final medicine = state.extra as MedicineEntity?;
          return FadePageRoute(
            key: state.pageKey,
            child: MedicineFormScreen(medicine: medicine),
          );
        },
      ),
    ],
  );
});
