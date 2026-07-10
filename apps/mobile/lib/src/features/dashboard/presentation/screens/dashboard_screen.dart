import 'package:flutter/material.dart';
import '../../design_system/tokens.dart';
import '../../design_system/motion.dart';
import '../../design_system/widgets/lc_peace_index_card.dart';
import '../../design_system/widgets/lc_exception_alert.dart';
import '../../design_system/widgets/lc_sync_status_bar.dart';

/// The Dashboard Screen — the heart of LifeCircle OS.
///
/// Emotional contract (EMOTIONAL_JOURNEYS.md):
///   Score ≥ 80: User reads "Everything is covered." and closes in 4 seconds.
///   Score < 80: User sees the exact exception requiring attention.
///
/// Navigation (FAMILY_OPERATING_MODEL.md): Tab 1. Always the entry point.
class DashboardScreen extends StatelessWidget {
  final int peaceScore;
  final List<ExceptionData> exceptions;
  final SyncStatus syncStatus;

  const DashboardScreen({
    super.key,
    required this.peaceScore,
    required this.exceptions,
    this.syncStatus = SyncStatus.synced,
  });

  String get _statusLabel {
    if (peaceScore >= 80) return 'Everything is covered.';
    if (peaceScore >= 50) return 'A few things need attention.';
    return 'Your family needs you right now.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sync status — invisible when healthy (SyncStatus.synced)
            LCSyncStatusBar(status: syncStatus),

            // App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.sm),
              child: Text('Home',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),

            // Peace Index Card — the emotional anchor of the entire app
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LCSpacing.md),
              child: LCPeaceIndexCard(
                score: peaceScore,
                statusLabel: _statusLabel,
              ),
            ),

            const SizedBox(height: LCSpacing.lg),

            // Exception Section — only visible when score < 100
            if (exceptions.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LCSpacing.md),
                child: Text('Needs Attention',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: LCSpacing.sm),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: exceptions.length,
                  itemBuilder: (context, index) {
                    final e = exceptions[index];
                    return LCExceptionAlert(
                      title: e.title,
                      description: e.description,
                      assignedTo: e.assignedTo,
                    );
                  },
                ),
              ),
            ] else
              // The most important screen: everything is covered.
              const Expanded(child: LCAllCoveredState()),
          ],
        ),
      ),
    );
  }
}

class ExceptionData {
  final String title;
  final String description;
  final String? assignedTo;
  const ExceptionData({
    required this.title,
    required this.description,
    this.assignedTo,
  });
}
