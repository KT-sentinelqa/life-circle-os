import 'package:flutter/material.dart';
import '../../design_system/tokens.dart';
import '../../design_system/motion.dart';
import '../dashboard/presentation/screens/dashboard_screen.dart';
import '../responsibilities/presentation/screens/responsibilities_screen.dart';
import '../emergency/presentation/screens/emergency_screen.dart';

/// The Root Navigation Shell — assembles the 4-tab app structure.
///
/// Navigation rules (FAMILY_OPERATING_MODEL.md):
///   - 4 tabs maximum. Everything reachable in 2 taps.
///   - Emergency is always Tab 4. Immovable.
///   - No hamburger menus.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  // Mock data — will be replaced by Riverpod providers
  final _screens = [
    DashboardScreen(
      peaceScore: 91,
      exceptions: [],
      syncStatus: SyncStatus.synced,
    ),
    ResponsibilitiesScreen(
      responsibilities: [
        const ResponsibilityItem(
          title: 'Papa\'s blood pressure medicine',
          primaryOwner: 'Priya',
          backupOwner: 'Rajesh',
          isCompleted: true,
          confidenceScore: 100,
        ),
        const ResponsibilityItem(
          title: 'Electricity bill',
          primaryOwner: 'Rajesh',
          isCompleted: false,
          confidenceScore: 55,
        ),
      ],
      onAddNew: () {},
    ),
    const _FamilyPlaceholder(),
    EmergencyScreen(
      contacts: [
        const EmergencyContact(
          name: 'Dr. Mehta',
          role: 'Family Doctor',
          phone: '+91 98765 43210',
        ),
      ],
      onAddContact: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: LCMotion.pageTransition,
        switchInCurve: LCMotion.pageTransitionCurve,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Responsibilities',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Family',
          ),
          NavigationDestination(
            icon: Icon(Icons.emergency_outlined),
            selectedIcon: Icon(Icons.emergency),
            label: 'Emergency',
          ),
        ],
      ),
    );
  }
}

/// Placeholder for the Family screen (Phase 6.4 continuation)
class _FamilyPlaceholder extends StatelessWidget {
  const _FamilyPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LCSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: LCSpacing.lg),
              Text('Family',
                style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
      ),
    );
  }
}
