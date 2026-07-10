import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens.dart';
import '../motion.dart';

/// Exception Alert — displayed when something requires human attention.
/// Philosophy: This must feel calm, not alarming. We are not a fire alarm.
/// It should feel like a gentle tap on the shoulder, not a siren.
class LCExceptionAlert extends StatelessWidget {
  final String title;
  final String description;
  final String? assignedTo;
  final VoidCallback? onAcknowledge;
  final VoidCallback? onDelegate;

  const LCExceptionAlert({
    super.key,
    required this.title,
    required this.description,
    this.assignedTo,
    this.onAcknowledge,
    this.onDelegate,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Exception alert: $title. $description',
      liveRegion: true,
      child: AnimatedSlide(
        duration: LCMotion.alertAppear,
        curve: LCMotion.alertAppearCurve,
        offset: Offset.zero,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: LCSpacing.md, vertical: LCSpacing.sm),
          padding: const EdgeInsets.all(LCSpacing.md),
          decoration: BoxDecoration(
            color: LCColors.escalationRose.withOpacity(0.08),
            borderRadius: BorderRadius.circular(LCRadius.lg),
            border: Border.all(
              color: LCColors.escalationRose.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline,
                    color: LCColors.escalationRose, size: 20),
                  const SizedBox(width: LCSpacing.sm),
                  Expanded(
                    child: Text(title,
                      style: LCTextStyles.titleMedium.copyWith(
                        color: LCColors.escalationRose),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LCSpacing.sm),
              Text(description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (assignedTo != null) ...[
                const SizedBox(height: LCSpacing.xs),
                Text('Needs attention from: $assignedTo',
                  style: LCTextStyles.caption.copyWith(
                    color: LCColors.inkSecondary),
                ),
              ],
              const SizedBox(height: LCSpacing.md),
              Row(
                children: [
                  if (onDelegate != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          onDelegate?.call();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: LCColors.inkDisabled),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(LCRadius.md)),
                        ),
                        child: const Text('Delegate'),
                      ),
                    ),
                  if (onDelegate != null)
                    const SizedBox(width: LCSpacing.sm),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        onAcknowledge?.call();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: LCColors.escalationRose,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(LCRadius.md)),
                      ),
                      child: const Text('I\'ll handle it'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Empty state for exceptions — shows when everything is covered.
/// This is the most important screen in the app.
class LCAllCoveredState extends StatelessWidget {
  const LCAllCoveredState({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'All responsibilities are covered. No action needed.',
      child: Padding(
        padding: const EdgeInsets.all(LCSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline,
              size: 72, color: LCColors.confidenceGreen),
            const SizedBox(height: LCSpacing.md),
            Text('Everything is covered.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: LCSpacing.sm),
            Text('Your family is taking care of everything.\nYou don\'t need to do anything right now.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
