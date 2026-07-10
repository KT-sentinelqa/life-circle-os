import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../design_system/tokens.dart';
import '../../design_system/motion.dart';
import '../../design_system/widgets/lc_sync_status_bar.dart';
import '../dashboard/presentation/screens/dashboard_screen.dart';
import '../responsibilities/presentation/screens/responsibilities_screen.dart';
import '../emergency/presentation/screens/emergency_screen.dart';

/// AppShell — the production root navigator.
/// 4 tabs. Emergency fixed at Tab 4. No hamburger menus.
/// Authentication state is resolved before this widget is shown.
class AppShell extends ConsumerStatefulWidget {
  final String currentUserId;
  const AppShell({super.key, required this.currentUserId});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(currentUserId: widget.currentUserId),
      const ResponsibilitiesScreen(),
      const _FamilyScreen(),
      EmergencyScreen(
        contacts: const [],   // Phase 6.7 M4: wire to EmergencyContactRepository
        onAddContact: () {},
      ),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: LCMotion.pageTransition,
        switchInCurve: LCMotion.pageTransitionCurve,
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: screens[_selectedIndex],
        ),
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

class _FamilyScreen extends StatelessWidget {
  const _FamilyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            LCSpacing.md, LCSpacing.lg, LCSpacing.md, 0),
          child: Text('Family',
            style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
    );
  }
}
