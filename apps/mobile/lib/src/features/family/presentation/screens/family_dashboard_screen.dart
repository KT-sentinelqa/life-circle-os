import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen displaying the main family dashboard.
class FamilyDashboardScreen extends ConsumerWidget {
  /// Creates a [FamilyDashboardScreen].
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LcScaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to your LifeCircle'),
      ),
    );
  }
}
