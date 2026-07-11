import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_status.dart';

class ResponsibilityCard extends StatelessWidget {
  const ResponsibilityCard({
    required this.responsibility,
    required this.onMarkComplete,
    required this.onSkip,
    super.key,
  });
  final FamilyResponsibility responsibility;
  final VoidCallback onMarkComplete;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final isEscalated = responsibility.status == ResponsibilityStatus.escalated;
    final theme = Theme.of(context);

    return Card(
      elevation: isEscalated ? 4 : 1,
      color: isEscalated
          ? theme.colorScheme.errorContainer
          : theme.colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    responsibility.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isEscalated
                          ? theme.colorScheme.onErrorContainer
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (isEscalated)
                  Icon(Icons.warning_rounded, color: theme.colorScheme.error),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Due: ${responsibility.dueDate.toLocal().toString().split('.')[0]}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isEscalated
                    ? theme.colorScheme.onErrorContainer
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            if (responsibility.status == ResponsibilityStatus.pending ||
                responsibility.status == ResponsibilityStatus.dueSoon ||
                responsibility.status == ResponsibilityStatus.escalated)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: isEscalated ? theme.colorScheme.error : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: onMarkComplete,
                    style: isEscalated
                        ? FilledButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                          )
                        : null,
                    child: const Text('Mark Complete'),
                  ),
                ],
              )
            else if (responsibility.status == ResponsibilityStatus.completed)
              Row(
                children: [
                  Icon(Icons.check_circle, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Completed',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
