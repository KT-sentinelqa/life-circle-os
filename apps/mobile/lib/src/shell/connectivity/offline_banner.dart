import 'package:flutter/material.dart';
import 'connectivity_service.dart';
import '../../design_system/design_system.dart';

/// OfflineBanner — Persistent offline state indicator
///
/// UX Constitution Law 2: Offline Is Normal.
/// UX Constitution Law 9: Sync status is always visible.
///
/// Design principle: inform without alarming.
/// The banner is calm and reassuring — not a red warning.
/// It tells the user: "You're offline. Your data is safe. We'll sync when ready."
///
/// The banner animates in/out with a smooth slide-down transition.
/// It never blocks content — it sits above the page body, always accessible.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    required this.connectivityService,
    required this.child,
    super.key,
  });

  final ConnectivityService connectivityService;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LcConnectivityStatus>(
      valueListenable: connectivityService.statusListenable,
      builder: (context, status, _) {
        final isOffline = status == LcConnectivityStatus.offline;
        return Column(
          children: [
            AnimatedSize(
              duration: LcAnimation.standard,
              curve: LcAnimation.enter,
              child: isOffline ? _OfflineBannerContent() : const SizedBox.shrink(),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

class _OfflineBannerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: 'You are offline. Your changes are saved locally and will sync when reconnected.',
      child: Container(
        width: double.infinity,
        color: LcColors.neutral800,
        padding: const EdgeInsets.symmetric(
          horizontal: LcSpacing.md,
          vertical: LcSpacing.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 14,
              color: LcColors.neutral300,
            ),
            const SizedBox(width: LcSpacing.xs),
            Text(
              'Offline — changes are saved locally',
              style: LcTypography.labelSmall.copyWith(
                color: LcColors.neutral300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
