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
class OnboardingScreen extends ConsumerStatefulWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BreathingGradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildScreen1(context),
                    _buildScreen2(context),
                    _buildScreen3(context, ref),
                  ],
                ),
              ),
              _buildBottomControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreen1(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'app_logo',
                  child: Icon(
                    Icons.family_restroom_rounded,
                    size: 96,
                    color: Color(0xFF2E5BFF),
                  ),
                ),
                const SizedBox(height: 64),
                const Text(
                  'Life is not just about managing yourself.',
                  style: AppTypography.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  "It's about caring for everyone you love.",
                  style: AppTypography.headlineLarge.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen2(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: const Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meet the Sharma Family.',
                  style: AppTypography.displayMedium,
                ),
                SizedBox(height: 48),
                _FamilyMemberRow(
                  emoji: '👨🏽',
                  role: 'Father',
                  tasks: 'BP + Diabetes medicines.',
                ),
                SizedBox(height: AppSpacing.md),
                _FamilyMemberRow(
                  emoji: '👩🏽',
                  role: 'Mother',
                  tasks: 'Arthritis treatment.',
                ),
                SizedBox(height: AppSpacing.md),
                _FamilyMemberRow(
                  emoji: '🧑🏽',
                  role: 'Son',
                  tasks: 'Managing EMIs and household finances.',
                ),
                SizedBox(height: AppSpacing.md),
                _FamilyMemberRow(
                  emoji: '👩🏽‍🦱',
                  role: 'Daughter-in-law',
                  tasks: 'Insurance and family coordination.',
                ),
                SizedBox(height: AppSpacing.md),
                _FamilyMemberRow(
                  emoji: '👦🏽',
                  role: 'Child',
                  tasks: 'School and future aspirations.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen3(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(
                    Icons.shield_moon_rounded,
                    size: 96,
                    color: Color(0xFF2E5BFF),
                  ),
                ),
                const SizedBox(height: 64),
                const Text(
                  'One app. One family.',
                  style: AppTypography.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'One source of peace of mind.',
                  style: AppTypography.headlineLarge.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),
                LcButton(
                  text: 'Get Started',
                  onPressed: () => context.go('/auth'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFF2E5BFF)
                      : Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          if (_currentPage < 2)
            TextButton(
              onPressed: _nextPage,
              child: const Text('Next', style: TextStyle(fontSize: 16)),
            )
          else
            const SizedBox(width: 64, height: 48),
        ],
      ),
    );
  }
}

class _FamilyMemberRow extends StatelessWidget {
  const _FamilyMemberRow({
    required this.emoji,
    required this.role,
    required this.tasks,
  });

  final String emoji;
  final String role;
  final String tasks;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tasks,
                style: AppTypography.bodyLarge,
              ),
            ],
          ),
        ),
      ],
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
