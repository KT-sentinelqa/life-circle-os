import 'package:flutter/material.dart';
import '../tokens/lc_colors.dart';
import '../tokens/lc_animation.dart';
import '../tokens/lc_typography.dart';

/// LcSyncIndicator — LifeCircle Design System
///
/// UX Constitution Law 9: Sync status is always visible.
/// This component must be available on every data-bearing screen.
///
/// States:
///   [LcSyncStatus.synced]   — green dot, "Up to date"
///   [LcSyncStatus.syncing]  — animated amber pulse, "Syncing…"
///   [LcSyncStatus.pending]  — amber dot, "Pending sync"
///   [LcSyncStatus.offline]  — grey dot, "Offline"
///   [LcSyncStatus.failed]   — red dot, "Sync failed"
enum LcSyncStatus { synced, syncing, pending, offline, failed }

class LcSyncIndicator extends StatefulWidget {
  const LcSyncIndicator({
    required this.status,
    super.key,
    this.showLabel = true,
  });

  final LcSyncStatus status;
  final bool showLabel;

  @override
  State<LcSyncIndicator> createState() => _LcSyncIndicatorState();
}

class _LcSyncIndicatorState extends State<LcSyncIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: LcAnimation.syncPulseDuration,
    );
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _updateAnimation();
  }

  @override
  void didUpdateWidget(LcSyncIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.status == LcSyncStatus.syncing) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get _dotColor {
    switch (widget.status) {
      case LcSyncStatus.synced:   return LcColors.syncComplete;
      case LcSyncStatus.syncing:  return LcColors.syncPending;
      case LcSyncStatus.pending:  return LcColors.syncPending;
      case LcSyncStatus.offline:  return LcColors.offline;
      case LcSyncStatus.failed:   return LcColors.syncFailed;
    }
  }

  String get _label {
    switch (widget.status) {
      case LcSyncStatus.synced:   return 'Up to date';
      case LcSyncStatus.syncing:  return 'Syncing\u2026';
      case LcSyncStatus.pending:  return 'Pending sync';
      case LcSyncStatus.offline:  return 'Offline';
      case LcSyncStatus.failed:   return 'Sync failed';
    }
  }

  String get _semanticsLabel {
    switch (widget.status) {
      case LcSyncStatus.synced:   return 'Data is up to date';
      case LcSyncStatus.syncing:  return 'Data is currently syncing';
      case LcSyncStatus.pending:  return 'Data is queued and will sync when connected';
      case LcSyncStatus.offline:  return 'Device is offline. Data will sync when reconnected.';
      case LcSyncStatus.failed:   return 'Sync failed. Tap for details.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: _semanticsLabel,
      liveRegion: true,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, _) {
          return Opacity(
            opacity: widget.status == LcSyncStatus.syncing
                ? _pulseAnimation.value
                : 1.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (widget.showLabel) ...[
                  const SizedBox(width: 6),
                  Text(
                    _label,
                    style: textTheme.labelSmall?.copyWith(color: _dotColor),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
