import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_form_provider.dart';

/// Screen for adding or editing a medicine.
class MedicineFormScreen extends ConsumerStatefulWidget {
  /// Creates a [MedicineFormScreen].
  const MedicineFormScreen({
    this.medicine,
    super.key,
  });

  /// The medicine to edit, or null to create a new one.
  final MedicineEntity? medicine;

  @override
  ConsumerState<MedicineFormScreen> createState() => _MedicineFormScreenState();
}

class _MedicineFormScreenState extends ConsumerState<MedicineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _dosageController;
  late final TextEditingController _formController;
  late final TextEditingController _instructionsController;
  late final TextEditingController _frequencyController;

  bool get _isEditing => widget.medicine != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicine?.name);
    _dosageController = TextEditingController(text: widget.medicine?.dosage);
    _formController = TextEditingController(text: widget.medicine?.form);
    _instructionsController = TextEditingController(
      text: widget.medicine?.instructions,
    );
    _frequencyController = TextEditingController(text: '1'); // Default to 1

    if (_isEditing) {
      _loadSchedule();
    }
  }

  Future<void> _loadSchedule() async {
    final schedule = await ref.read(
      dosageScheduleProvider(widget.medicine!.id).future,
    );
    if (schedule != null && mounted) {
      _frequencyController.text = schedule.frequencyPerDay.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _formController.dispose();
    _instructionsController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final router = GoRouter.of(context);
      await ref.read(medicineFormProvider.notifier).saveMedicine(
        id: widget.medicine?.id,
        name: _nameController.text.trim(),
        dosage: _dosageController.text.trim(),
        form: _formController.text.trim(),
        instructions: _instructionsController.text.trim(),
        frequencyPerDay: int.tryParse(_frequencyController.text) ?? 1,
      );
      if (!mounted) return;
      router.pop();
    }
  }

  void _confirmDelete() {
    final router = GoRouter.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Medicine'),
        content: const Text('Are you sure you want to delete this medicine?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(medicineFormProvider.notifier).deleteMedicine(
                widget.medicine!.id,
              );
              if (!mounted) return;
              router.pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(medicineFormProvider);

    return LcScaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Medicine' : 'Add Medicine'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: formState.isLoading ? null : _confirmDelete,
            ),
        ],
      ),
      body: formState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LcTextField(
                      label: 'Medicine Name',
                      controller: _nameController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    LcTextField(
                      label: 'Dosage (e.g., 100mg)',
                      controller: _dosageController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    LcTextField(
                      label: 'Form (e.g., Pill, Syrup)',
                      controller: _formController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    LcTextField(
                      label: 'Instructions',
                      controller: _instructionsController,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    LcTextField(
                      label: 'Frequency (times per day)',
                      controller: _frequencyController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (int.tryParse(v) == null) return 'Must be a number';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    LcButton(
                      text: 'Save',
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
