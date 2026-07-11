import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';

/// Reusable empty state component with premium styling.
class LcEmptyState extends StatelessWidget {
  /// Creates an [LcEmptyState].
  const LcEmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.ctaText,
    this.onCtaPressed,
    this.accentColor = AppColors.primaryLight,
    this.iconColor = AppColors.primaryDark,
    super.key,
  });

  /// The icon to display.
  final IconData icon;

  /// The title text.
  final String title;

  /// The subtitle text.
  final String subtitle;

  /// Optional call to action text.
  final String? ctaText;

  /// Optional callback for the call to action.
  final VoidCallback? onCtaPressed;

  /// The accent color for the icon background.
  final Color accentColor;

  /// The color for the icon itself.
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: iconColor,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              title,
              style: AppTypography.headlineLarge.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (ctaText != null && onCtaPressed != null) ...[
              const SizedBox(height: AppSpacing.xl),
              LcButton(
                text: ctaText!,
                onPressed: onCtaPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
