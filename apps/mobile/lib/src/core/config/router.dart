import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/wizard',
        builder: (context, state) => const WizardChoiceScreen(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const CreateFamilyWizardScreen(),
          ),
          GoRoute(
            path: 'join',
            builder: (context, state) => const JoinFamilyScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/invite_members',
        builder: (context, state) => const InviteMembersScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const FamilyDashboardScreen(),
      ),
      GoRoute(
        path: '/medicine',
        builder: (context, state) => const MedicineDashboardScreen(),
      ),
      GoRoute(
        path: '/medicine/form',
        builder: (context, state) {
          final medicine = state.extra as MedicineEntity?;
          return MedicineFormScreen(medicine: medicine);
        },
      ),
    ],
  );
});
