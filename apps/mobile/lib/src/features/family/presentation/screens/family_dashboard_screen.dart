import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile/src/features/family/presentation/providers/family_provider.dart';

/// The main dashboard screen for the family feature.
///
/// Displays the family name and acts as the root for family management.
class FamilyDashboardScreen extends ConsumerWidget {
  /// Creates a family dashboard screen.
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsyncValue = ref.watch(familyDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Dashboard'),
      ),
      body: familyAsyncValue.when(
        data: (familyName) => Center(
          child: Text(
            'Welcome to $familyName!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
