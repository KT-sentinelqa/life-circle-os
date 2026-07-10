import 'package:flutter/material.dart';
import '../../design_system/tokens.dart';

/// The Emergency Screen — Tab 4. Always visible. One tap from anywhere.
///
/// FAMILY_OPERATING_MODEL.md rule:
///   "Emergency is always Tab 4. Immovable.
///    Muscle memory is a safety feature."
///
/// Offline: Fully available. Emergency contacts are the last thing that can be lost.
class EmergencyScreen extends StatelessWidget {
  final List<EmergencyContact> contacts;
  final VoidCallback onAddContact;

  const EmergencyScreen({
    super.key,
    required this.contacts,
    required this.onAddContact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.sm),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Emergency',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: LCSpacing.xs),
                    Text('One tap to reach anyone in your family.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            if (contacts.isEmpty)
              SliverFillRemaining(
                child: _EmptyEmergency(onAdd: onAddContact),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => _EmergencyContactTile(contact: contacts[i]),
                  childCount: contacts.length,
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddContact,
        backgroundColor: LCColors.escalationRose,
        icon: const Icon(Icons.person_add_outlined, color: Colors.white),
        label: const Text('Add Contact',
          style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _EmergencyContactTile extends StatelessWidget {
  final EmergencyContact contact;
  const _EmergencyContactTile({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${contact.name}, ${contact.role}, ${contact.phone}',
      button: true,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: LCSpacing.md, vertical: LCSpacing.xs),
        padding: const EdgeInsets.all(LCSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(LCRadius.lg),
          boxShadow: LCShadows.cardSubtle,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: LCColors.calmSky,
              child: Text(contact.name[0],
                style: LCTextStyles.titleMedium.copyWith(
                  color: LCColors.peacefulTeal),
              ),
            ),
            const SizedBox(width: LCSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name,
                    style: Theme.of(context).textTheme.titleMedium),
                  Text(contact.role,
                    style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            // One-tap call button
            IconButton(
              icon: const Icon(Icons.call_outlined,
                color: LCColors.confidenceGreen, size: 28),
              tooltip: 'Call ${contact.name}',
              onPressed: () {/* Launch phone dialer */},
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyEmergency extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyEmergency({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LCSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emergency_outlined,
            size: 64, color: LCColors.inkDisabled),
          const SizedBox(height: LCSpacing.md),
          Text('No emergency contacts yet.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: LCSpacing.sm),
          Text('Add doctors, neighbours, or family members anyone in the family can reach instantly.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: LCSpacing.lg),
          FilledButton(
            onPressed: onAdd,
            style: FilledButton.styleFrom(
              backgroundColor: LCColors.escalationRose),
            child: const Text('Add Emergency Contact'),
          ),
        ],
      ),
    );
  }
}

class EmergencyContact {
  final String name;
  final String role;
  final String phone;
  const EmergencyContact({
    required this.name,
    required this.role,
    required this.phone,
  });
}
