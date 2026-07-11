import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/application/responsibility_providers.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/widgets/responsibility_card.dart';

class ResponsibilityDashboardScreen extends ConsumerWidget {
  const ResponsibilityDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsibilitiesAsyncValue =
        ref.watch(familyResponsibilitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Responsibilities'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to Create Responsibility Screen
            },
          ),
        ],
      ),
      body: responsibilitiesAsyncValue.when(
        data: (responsibilities) {
          if (responsibilities.isEmpty) {
            return const Center(child: Text('All caught up. Peace of mind.'));
          }

          return ListView.builder(
            itemCount: responsibilities.length,
            itemBuilder: (context, index) {
              final resp = responsibilities[index];
              return ResponsibilityCard(
                responsibility: resp,
                onMarkComplete: () async {
                  await ref
                      .read(responsibilityServiceProvider)
                      .markAsCompleted(resp.uuid, resp.primaryOwnerId);
                  ref.invalidate(familyResponsibilitiesProvider);
                },
                onSkip: () {
                  // Handle skip logic
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
