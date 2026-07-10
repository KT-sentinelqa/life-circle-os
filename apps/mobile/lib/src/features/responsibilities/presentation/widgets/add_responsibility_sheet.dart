import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design_system/tokens.dart';
import '../../application/responsibility_providers.dart';
import '../../domain/models/responsibility_category.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Milestone 2: Add Responsibility bottom sheet.
// Design principles:
//  - 3-tap completion rule (USER_STORIES.md — Arjun the Teenager)
//  - No "save" button until required fields are filled (inline validation)
//  - Form state persists if the sheet is dismissed mid-way (INTERACTION_GUIDELINES)
// ─────────────────────────────────────────────────────────────────────────────
class AddResponsibilitySheet extends ConsumerStatefulWidget {
  const AddResponsibilitySheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(LCRadius.xl)),
      ),
      builder: (_) => const AddResponsibilitySheet(),
    );
  }

  @override
  ConsumerState<AddResponsibilitySheet> createState() =>
      _AddResponsibilitySheetState();
}

class _AddResponsibilitySheetState
    extends ConsumerState<AddResponsibilitySheet> {
  final _nameController = TextEditingController();
  ResponsibilityCategory _category = ResponsibilityCategory.household;
  DateTime? _dueDate;
  bool _isSaving = false;
  String? _nameError;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _nameController.text.trim().isNotEmpty && _dueDate != null;

  Future<void> _save(BuildContext context) async {
    if (!_canSave) return;
    setState(() => _isSaving = true);

    try {
      await ref.read(responsibilityServiceProvider).createResponsibility(
        name: _nameController.text.trim(),
        category: _category,
        primaryOwnerId: 'current-user', // Phase 6.7 M3: inject from auth provider
        dueDate: _dueDate!,
      );
      // Invalidate the list so Dashboard and Responsibilities both refresh
      ref.invalidate(familyResponsibilitiesProvider);
      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _isSaving = false;
        _nameError = 'Something went wrong on our end. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Adjusts for soft keyboard — no content hidden behind keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        LCSpacing.md, LCSpacing.md, LCSpacing.md,
        LCSpacing.md + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: LCColors.borderSubtle,
                borderRadius: BorderRadius.circular(LCRadius.full),
              ),
            ),
          ),
          const SizedBox(height: LCSpacing.lg),

          Text('Add Responsibility',
            style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: LCSpacing.lg),

          // Name field
          TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'What needs to be done?',
              hintText: 'e.g. Papa\'s morning blood pressure medicine',
              errorText: _nameError,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LCRadius.md)),
            ),
            onChanged: (_) => setState(() => _nameError = null),
          ),
          const SizedBox(height: LCSpacing.md),

          // Category picker
          DropdownButtonFormField<ResponsibilityCategory>(
            value: _category,
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LCRadius.md)),
            ),
            items: ResponsibilityCategory.values.map((c) =>
              DropdownMenuItem(
                value: c,
                child: Text(_categoryLabel(c)),
              ),
            ).toList(),
            onChanged: (v) => setState(() => _category = v!),
          ),
          const SizedBox(height: LCSpacing.md),

          // Due date picker
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _dueDate = picked);
            },
            icon: const Icon(Icons.calendar_today_outlined),
            label: Text(_dueDate != null
              ? 'Due: ${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'
              : 'Set due date'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LCRadius.md)),
            ),
          ),
          const SizedBox(height: LCSpacing.lg),

          // Save button — disabled until required fields are filled
          FilledButton(
            onPressed: _canSave && !_isSaving ? () => _save(context) : null,
            child: _isSaving
              ? const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
              : const Text('Add Responsibility'),
          ),
        ],
      ),
    );
  }

  String _categoryLabel(ResponsibilityCategory c) => switch (c) {
    ResponsibilityCategory.health    => '🏥  Health',
    ResponsibilityCategory.finance   => '💳  Finance',
    ResponsibilityCategory.household => '🏠  Household',
    ResponsibilityCategory.documents => '📄  Documents',
    _ => c.name,
  };
}
