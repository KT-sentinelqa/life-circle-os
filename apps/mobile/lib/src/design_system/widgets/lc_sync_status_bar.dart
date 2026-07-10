import 'package:flutter/material.dart';
import '../tokens.dart';

/// Displays the current sync state of the device.
/// Philosophy: Offline mode should feel calm and capable, not broken.
/// The user should never feel panic when they lose connectivity.
class LCSyncStatusBar extends StatelessWidget {
  final SyncStatus status;
  const LCSyncStatusBar({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: switch (status) {
        SyncStatus.synced   => const SizedBox.shrink(), // Invisible when healthy
        SyncStatus.syncing  => _SyncBanner(
          key: const ValueKey('syncing'),
          icon: Icons.sync,
          label: 'Syncing family data…',
          color: LCColors.watchAmber,
          animate: true,
        ),
        SyncStatus.offline  => _SyncBanner(
          key: const ValueKey('offline'),
          icon: Icons.cloud_off_outlined,
          label: 'You\'re offline. Changes will sync when connected.',
          color: LCColors.inkSecondary,
        ),
        SyncStatus.error    => _SyncBanner(
          key: const ValueKey('error'),
          icon: Icons.warning_amber_outlined,
          label: 'Sync paused. Will retry automatically.',
          color: LCColors.escalationRose,
        ),
      },
    );
  }
}

class _SyncBanner extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool animate;

  const _SyncBanner({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: label,
      child: Container(
        width: double.infinity,
        color: color.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(
          horizontal: LCSpacing.md, vertical: LCSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animate
              ? _SpinningIcon(icon: icon, color: color)
              : Icon(icon, color: color, size: 16),
            const SizedBox(width: LCSpacing.sm),
            Text(label,
              style: LCTextStyles.caption.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpinningIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  const _SpinningIcon({required this.icon, required this.color});

  @override
  State<_SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<_SpinningIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(widget.icon, color: widget.color, size: 16),
    );
  }
}

enum SyncStatus { synced, syncing, offline, error }
