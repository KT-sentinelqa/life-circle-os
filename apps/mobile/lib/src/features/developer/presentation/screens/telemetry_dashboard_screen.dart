import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';

/// Internal UX Telemetry Dashboard (SEC-030).
/// Only accessible via hidden developer gestures.
class TelemetryDashboardScreen extends StatelessWidget {
  const TelemetryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UX Telemetry'),
        backgroundColor: LCColors.escalationRose,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(LCSpacing.md),
        children: const [
          _TelemetryMetric(
            title: 'Average Cold Start',
            value: '1.2s',
            target: '< 2.0s',
            isHealthy: true,
          ),
          _TelemetryMetric(
            title: 'Dashboard Rebuilds (per min)',
            value: '4',
            target: '< 10',
            isHealthy: true,
          ),
          _TelemetryMetric(
            title: 'Offline Sync Queue',
            value: '2 events',
            target: 'n/a',
            isHealthy: true,
          ),
          _TelemetryMetric(
            title: 'Dropped Frames (last hr)',
            value: '12',
            target: '0',
            isHealthy: false, // Fails QA-002
          ),
          SizedBox(height: LCSpacing.xl),
          Text(
            'SEC-030 Enforced. No PII is collected or displayed here. '
            'This dashboard tracks Product Learning and Performance only.',
            style: TextStyle(color: LCColors.inkDisabled),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TelemetryMetric extends StatelessWidget {
  const _TelemetryMetric({
    required this.title,
    required this.value,
    required this.target,
    required this.isHealthy,
  });
  final String title;
  final String value;
  final String target;
  final bool isHealthy;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: LCSpacing.sm),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('Target: $target'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(width: LCSpacing.sm),
            Icon(
              isHealthy ? Icons.check_circle : Icons.warning,
              color: isHealthy
                  ? LCColors.confidenceGreen
                  : LCColors.escalationRose,
            ),
          ],
        ),
      ),
    );
  }
}
