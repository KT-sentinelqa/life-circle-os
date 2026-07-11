import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/core/navigation/fade_page_route.dart';
import 'package:lifecircle_mobile/src/core/navigation/shared_axis_page_route.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/auth_stage.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/auth_success_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/biometric_setup_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/create_account_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/device_trust_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/invite_members_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/otp_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/recovery_codes_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/two_factor_setup_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/welcome_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/wizard/create_family_wizard_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/wizard/join_family_screen.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/wizard/wizard_choice_screen.dart';
import 'package:lifecircle_mobile/src/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/screens/medicine_dashboard_screen.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/screens/medicine_form_screen.dart';

/// Provides the global [GoRouter] configuration for the application.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final user = authState.valueOrNull;

  return GoRouter(
    initialLocation: '/auth/welcome',
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthRoute = path.startsWith('/auth');

      // 1. If user is completely null, they can only access basic auth routes
      if (user == null) {
        if (isAuthRoute && (path == '/auth/welcome' || path == '/auth/create' || path == '/auth/sign_in')) {
          return null;
        }
        return '/auth/welcome';
      }

      // 2. Strict pipeline for users currently authenticating
      if (user.authStage != AuthStage.completed) {
        switch (user.authStage) {
          case AuthStage.awaitingOtp:
            if (path != '/auth/otp') return '/auth/otp';
          case AuthStage.awaitingTwoFactor:
            if (path != '/auth/2fa') return '/auth/2fa';
          case AuthStage.awaitingDeviceTrust:
            if (path != '/auth/device') return '/auth/device';
          case AuthStage.awaitingBiometrics:
            if (path != '/auth/biometric') return '/auth/biometric';
          case AuthStage.awaitingRecoveryCodes:
            if (path != '/auth/recovery') return '/auth/recovery';
          case AuthStage.completed:
             // Handled below
        }
        return null;
      }

      // 3. Auth is completed. Show success screen once if needed
      if (path == '/auth/success') return null;

      // 4. Force authenticated users out of auth flows
      if (isAuthRoute) {
        return '/dashboard'; // Or /wizard if family check happens here
      }

      // 5. Family wizard logic
      if (user.familyId == null) {
        if (!path.startsWith('/wizard')) return '/wizard';
        return null;
      }

      if (path.startsWith('/wizard')) return '/dashboard';

      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        redirect: (_, __) => '/auth/welcome',
        routes: [
          GoRoute(
            path: 'welcome',
            pageBuilder: (context, state) => FadePageRoute(
              key: state.pageKey,
              child: const WelcomeScreen(),
            ),
          ),
          GoRoute(
            path: 'create',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const CreateAccountScreen(),
            ),
          ),
          GoRoute(
            path: 'sign_in',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const WelcomeScreen(), // Mock placeholder
            ),
          ),
          GoRoute(
            path: 'otp',
            pageBuilder: (context, state) {
              final identifier = state.extra as String? ?? '';
              return SharedAxisPageRoute(
                key: state.pageKey,
                child: OtpScreen(identifier: identifier),
              );
            },
          ),
          GoRoute(
            path: '2fa',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const TwoFactorSetupScreen(),
            ),
          ),
          GoRoute(
            path: 'device',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const DeviceTrustScreen(),
            ),
          ),
          GoRoute(
            path: 'biometric',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const BiometricSetupScreen(),
            ),
          ),
          GoRoute(
            path: 'recovery',
            pageBuilder: (context, state) => SharedAxisPageRoute(
              key: state.pageKey,
              child: const RecoveryCodesScreen(),
            ),
          ),
          GoRoute(
            path: 'success',
            pageBuilder: (context, state) => FadePageRoute(
              key: state.pageKey,
              child: const AuthSuccessScreen(),
            ),
          ),
        ],
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
          child: DashboardScreen(currentUserId: user?.id ?? 'demo_user'),
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
