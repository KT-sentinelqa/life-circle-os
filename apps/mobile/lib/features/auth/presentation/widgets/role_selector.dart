/// LifeCircle OS — RoleSelector widget.
///
/// Presents Guardian / Helper / Dependent as a segmented button with:
///   - Minimum 52dp touch target height (WCAG 2.2 AA, SC 2.5.8)
///   - Semantics label on each option
///   - Haptic feedback on selection change
///
/// Governed by: docs/accessibility.md | LC-S1-009
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/auth/user_role.dart';

/// Accessible role selector widget using Material 3 SegmentedButton.
class RoleSelector extends StatelessWidget {
  const RoleSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final UserRole selected;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Select your role. Currently selected: ${selected.displayLabel}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your role',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            // Enforce minimum 52dp touch target height
            height: 52,
            child: SegmentedButton<UserRole>(
              segments: UserRole.values.map((role) {
                return ButtonSegment<UserRole>(
                  value: role,
                  label: Semantics(
                    label: role.displayLabel,
                    excludeSemantics: true,
                    child: Text(role.displayLabel),
                  ),
                );
              }).toList(),
              selected: {selected},
              onSelectionChanged: (Set<UserRole> newSelection) {
                HapticFeedback.lightImpact();
                onChanged(newSelection.first);
              },
              showSelectedIcon: false,
            ),
          ),
          const SizedBox(height: 4),
          ExcludeSemantics(
            child: Text(
              switch (selected) {
                UserRole.guardian  => 'Full family management access.',
                UserRole.helper    => 'Caregiver with delegated access.',
                UserRole.dependent => 'Family member receiving care.',
              },
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
