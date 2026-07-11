import 'package:flutter/material.dart';

class ConfidenceIndicator extends StatelessWidget {
  const ConfidenceIndicator({required this.score, super.key});
  final int score;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Accessibility: Do not rely solely on color.
    IconData statusIcon;
    Color statusColor;
    String semanticLabel;

    if (score >= 90) {
      statusIcon = Icons.shield_rounded;
      statusColor = theme.colorScheme.primary;
      semanticLabel = 'High family confidence. Score is $score.';
    } else if (score >= 70) {
      statusIcon = Icons.info_outline_rounded;
      statusColor = theme.colorScheme.secondary;
      semanticLabel =
          'Moderate family confidence. Score is $score. Some tasks require attention.';
    } else {
      statusIcon = Icons.warning_amber_rounded;
      statusColor = theme.colorScheme.error;
      semanticLabel =
          'Low family confidence. Score is $score. Escalated tasks need immediate review.';
    }

    return Semantics(
      label: semanticLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 64, color: statusColor),
          const SizedBox(height: 8),
          Text(
            score.toString(),
            style: theme.textTheme.displayLarge?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Family Peace Index',
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
