import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/presentation/providers/demo_seed_provider.dart';

/// Introductory screen explaining the value of LifeCircle OS.
class OnboardingScreen extends ConsumerWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _BreathingGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Center(
                  child: Hero(
                    tag: 'app_logo',
                    child: Icon(
                      Icons.family_restroom_rounded,
                      size: 96,
                      color: Color(0xFF2E5BFF),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const Text(
                  'The Operating System for Indian Families.',
                  style: AppTypography.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'Manage your household, finances, health, and family all '
                  'in one secure, offline-first place.',
                  style: AppTypography.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                LcButton(
                  text: 'Get Started',
                  onPressed: () => context.go('/auth'),
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(demoSeedEngineProvider).populateDemoScenario(
                          DemoScenario.healthyFamily,
                          DateTime.now(),
                        );
                    const demoUser = User(
                      id: 'user-krishna-1',
                      name: 'Krishna Tiwari',
                      email: 'krishna@demo.com',
                      familyId: 'demo-family-123',
                    );
                    await ref
                        .read(authProvider.notifier)
                        .forceDemoLogin(demoUser);
                  },
                  child: const Text('Try Demo Family'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BreathingGradientBackground extends StatefulWidget {
  const _BreathingGradientBackground({required this.child});
  final Widget child;

  @override
  State<_BreathingGradientBackground> createState() =>
      _BreathingGradientBackgroundState();
}

class _BreathingGradientBackgroundState
    extends State<_BreathingGradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final color1Start =
        isDark ? const Color(0xFF00303E) : const Color(0xFFE8EEFF);
    final color1End =
        isDark ? const Color(0xFF001F29) : const Color(0xFFF3F6FF);
    final color2Start =
        isDark ? const Color(0xFF00222B) : const Color(0xFFF8FAFF);
    final color2End =
        isDark ? const Color(0xFF001117) : const Color(0xFFFFFFFF);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0, 1],
              colors: [
                Color.lerp(
                  color1Start,
                  color1End,
                  _controller.value,
                )!,
                Color.lerp(
                  color2Start,
                  color2End,
                  _controller.value,
                )!,
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
