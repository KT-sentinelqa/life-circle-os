import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/escalation_policy.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';

/// Pure factory for generating deterministic medicines based on a scenario.
class DemoMedicineFactory {
  /// Creates a [DemoMedicineFactory].
  const DemoMedicineFactory();

  /// Generates a list of medicines for the given family members.
  List<MedicineEntity> generateMedicines(
    List<FamilyMemberEntity> members,
    DemoScenario scenario,
    DateTime referenceTime,
  ) {
    final medicines = <MedicineEntity>[];

    for (final member in members) {
      if (member.role == MemberRole.parent &&
          member.userId.contains('grandma')) {
        // Critical member: complex regime
        medicines.addAll([
          _createMedicine(
            member,
            'Amlodipine',
            '5mg',
            'Pill',
            'Take in morning',
            EscalationPolicy.emergency,
            referenceTime,
          ),
          _createMedicine(
            member,
            'Metformin',
            '500mg',
            'Pill',
            'Take with meals',
            EscalationPolicy.emergency,
            referenceTime,
          ),
          _createMedicine(
            member,
            'Atorvastatin',
            '40mg',
            'Pill',
            'Take at night',
            EscalationPolicy.standard,
            referenceTime,
          ),
          _createMedicine(
            member,
            'Vitamin D3',
            '60000 IU',
            'Capsule',
            'Once a week',
            EscalationPolicy.none,
            referenceTime,
          ),
        ]);
      } else if (member.role == MemberRole.parent &&
          member.userId.contains('shailesh')) {
        // Father
        medicines.addAll([
          _createMedicine(
            member,
            'Telmisartan',
            '40mg',
            'Pill',
            'Take in morning',
            EscalationPolicy.standard,
            referenceTime,
          ),
          _createMedicine(
            member,
            'Aspirin',
            '75mg',
            'Pill',
            'After lunch',
            EscalationPolicy.standard,
            referenceTime,
          ),
        ]);
      } else if (member.role == MemberRole.parent &&
          member.userId.contains('sunita')) {
        // Mother
        medicines.addAll([
          _createMedicine(
            member,
            'Thyroxine',
            '50mcg',
            'Pill',
            'Empty stomach morning',
            EscalationPolicy.standard,
            referenceTime,
          ),
          _createMedicine(
            member,
            'Calcium',
            '500mg',
            'Pill',
            'After dinner',
            EscalationPolicy.none,
            referenceTime,
          ),
        ]);
      } else if (member.role == MemberRole.owner) {
        // Owner
        medicines.addAll([
          _createMedicine(
            member,
            'Multivitamin',
            '1 tab',
            'Pill',
            'After breakfast',
            EscalationPolicy.none,
            referenceTime,
          ),
        ]);
      }
    }

    return medicines;
  }

  MedicineEntity _createMedicine(
    FamilyMemberEntity member,
    String name,
    String dosage,
    String form,
    String instructions,
    EscalationPolicy escalation,
    DateTime refTime,
  ) {
    return MedicineEntity(
      id: 'demo-med-${member.userId}-'
          '${name.toLowerCase().replaceAll(' ', '-')}',
      familyId: member.familyId,
      memberId: member.userId,
      name: name,
      dosage: dosage,
      form: form,
      instructions: instructions,
      createdAtUtc: refTime.subtract(const Duration(days: 100)),
      updatedAtUtc: refTime,
      ownerUserId: member.userId,
      escalationPolicy: escalation,
    );
  }
}
