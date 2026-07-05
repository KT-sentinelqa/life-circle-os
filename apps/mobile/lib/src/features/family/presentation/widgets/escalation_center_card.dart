import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_empty_state.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_skeleton.dart';

/// Displays actionable alerts and escalation tasks for caregivers.
class EscalationCenterCard extends ConsumerWidget {
  /// Creates an [EscalationCenterCard].
  const EscalationCenterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthScoreAsync = ref.watch(familyHealthScoreProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escalation Center',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        healthScoreAsync.when(
          data: (score) {
            if (score == null || score.membersAtRisk == 0) {
              return const Card(
                elevation: 0,
                color: AppColors.backgroundLight,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: LcEmptyState(
                    icon: Icons.shield_moon,
                    title: 'Everything looks good today',
                    subtitle: 'No family members need attention.',
                    accentColor: AppColors.success,
                    iconColor: AppColors.success,
                  ),
                ),
              );
            }

            return Card(
              elevation: 0,
              color: AppColors.error.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning, color: AppColors.error),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _EscalationBounce(
                            count: score.membersAtRisk,
                            child: Text(
                              'Critical Alerts (${score.membersAtRisk})',
                              style: AppTypography.bodyLarge.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Resolve'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.medication),
                      title: Text('Missed Doses Detected'),
                      subtitle: Text('Please check on assigned members.'),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const LcSkeletonCard(height: 120),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }
}

class _EscalationBounce extends StatefulWidget {
  const _EscalationBounce({required this.count, required this.child});

  final int count;
  final Widget child;

  @override
  State<_EscalationBounce> createState() => _EscalationBounceState();
}

class _EscalationBounceState extends State<_EscalationBounce>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late int _oldCount;

  @override
  void initState() {
    super.initState();
    _oldCount = widget.count;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // elasticOut naturally overshoots the target value,
    // creating the 1.15 bounce
    _animation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _EscalationBounce oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count > _oldCount) {
      _controller.forward(from: 0);
    }
    _oldCount = widget.count;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
