import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';
import 'package:lifecircle_mobile/src/features/emergency/application/emergency_providers.dart';
import 'package:lifecircle_mobile/src/features/emergency/domain/models/emergency_contact.dart';
import 'package:uuid/uuid.dart';

class AddEmergencyContactSheet extends ConsumerStatefulWidget {
  const AddEmergencyContactSheet({required this.householdId, super.key});
  final String householdId;

  static Future<void> show(BuildContext context, String householdId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(LCRadius.xl),
        ),
      ),
      builder: (_) => AddEmergencyContactSheet(householdId: householdId),
    );
  }

  @override
  ConsumerState<AddEmergencyContactSheet> createState() =>
      _AddEmergencyContactSheetState();
}

class _AddEmergencyContactSheetState
    extends ConsumerState<AddEmergencyContactSheet> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _nameController.text.trim().isNotEmpty &&
      _roleController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty;

  Future<void> _save(BuildContext context) async {
    if (!_canSave) return;
    setState(() => _isSaving = true);

    try {
      final now =
          DateTime.now(); // Replace with TrustedClock in future iteration
      final contact = EmergencyContact()
        ..uuid = const Uuid().v4()
        ..householdId = widget.householdId
        ..name = _nameController.text.trim()
        ..role = _roleController.text.trim()
        ..phone = _phoneController.text.trim()
        ..createdAt = now
        ..updatedAt = now;

      await ref.read(emergencyContactRepositoryProvider).saveContact(contact);

      // Invalidate stream isn't strictly necessary for watchLazy(),
      // but ensures the UI is fresh if watchLazy latency occurs.
      ref.invalidate(emergencyContactsStreamProvider(widget.householdId));

      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _isSaving = false;
        _error = 'Something went wrong on our end. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        LCSpacing.md,
        LCSpacing.md,
        LCSpacing.md,
        LCSpacing.md + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: LCColors.borderSubtle,
                borderRadius: BorderRadius.circular(LCRadius.full),
              ),
            ),
          ),
          const SizedBox(height: LCSpacing.lg),
          Text(
            'Add Emergency Contact',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: LCSpacing.lg),
          TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'e.g. Dr. Sharma',
              errorText: _error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LCRadius.md),
              ),
            ),
            onChanged: (_) => setState(() => _error = null),
          ),
          const SizedBox(height: LCSpacing.md),
          TextField(
            controller: _roleController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Role or Relationship',
              hintText: 'e.g. Cardiologist or Neighbour',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LCRadius.md),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: LCSpacing.md),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'e.g. +91 98765 43210',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LCRadius.md),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: LCSpacing.lg),
          FilledButton(
            onPressed: _canSave && !_isSaving ? () => _save(context) : null,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Save Contact'),
          ),
        ],
      ),
    );
  }
}
