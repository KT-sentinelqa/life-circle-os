/// LifeCircle OS — Password strength indicator widget.
///
/// Displays a segmented bar reflecting the strength of the current password.
/// Uses colours that meet WCAG 2.2 AA contrast ratio requirements (≥4.5:1).
///
/// Accessibility:
///   - Wrapped in Semantics with a live-region label read by screen readers.
///   - Decorative segments are excluded from accessibility tree.
///
/// Governed by: docs/accessibility.md | docs/design-system.md | LC-S1-009
library;

import 'package:flutter/material.dart';

import '../bloc/register_state.dart';

/// Animated password strength segmented bar.
class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    required this.strength,
    super.key,
  });

  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    if (strength == PasswordStrength.empty) return const SizedBox.shrink();

    final (label, color) = switch (strength) {
      PasswordStrength.weak   => ('Weak',   const Color(0xFFD32F2F)),   // Red — AA contrast on white
      PasswordStrength.fair   => ('Fair',   const Color(0xFFE65100)),   // Deep orange — AA on white
      PasswordStrength.strong => ('Strong', const Color(0xFF2E7D32)),   // Green — AA on white
      PasswordStrength.empty  => ('',       Colors.transparent),
    };

    final filledSegments = switch (strength) {
      PasswordStrength.weak   => 1,
      PasswordStrength.fair   => 2,
      PasswordStrength.strong => 3,
      PasswordStrength.empty  => 0,
    };

    return Semantics(
      // Announce strength changes to screen reader as a live region
      liveRegion: true,
      label: 'Password strength: $label',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: List.generate(3, (index) {
              final isFilled = index < filledSegments;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < 2 ? 4.0 : 0),
                  child: ExcludeSemantics(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 4,
                      decoration: BoxDecoration(
                        color: isFilled ? color : const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 4),
          ExcludeSemantics(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
