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
      switch (scenario) {
        case DemoScenario.healthyFamily:
          if (member.userId == 'user-father') {
            medicines.addAll([
              _createMedicine(
                member,
                'Amlodipine',
                '5mg',
                'Pill',
                'Take in morning',
                EscalationPolicy.standard,
                referenceTime,
              ),
              _createMedicine(
                member,
                'Metformin',
                '500mg',
                'Pill',
                'Take with meals',
                EscalationPolicy.standard,
                referenceTime,
              ),
            ]);
          } else if (member.userId == 'user-mother') {
            medicines.addAll([
              _createMedicine(
                member,
                'Methotrexate',
                '15mg',
                'Pill',
                'Once weekly',
                EscalationPolicy.standard,
                referenceTime,
              ),
              _createMedicine(
                member,
                'Physiotherapy',
                '30 mins',
                'Activity',
                'Evening routine',
                EscalationPolicy.none,
                referenceTime,
              ),
            ]);
          } else if (member.userId == 'user-son' ||
              member.userId == 'user-dil') {
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
        case DemoScenario.careNeeded:
          if (member.role == MemberRole.parent) {
            medicines.addAll([
              _createMedicine(
                member,
                'Amlodipine',
                '5mg',
                'Pill',
                'Take in morning',
                EscalationPolicy.standard,
                referenceTime,
              ),
              _createMedicine(
                member,
                'Metformin',
                '500mg',
                'Pill',
                'Take with meals',
                EscalationPolicy.standard,
                referenceTime,
              ),
            ]);
          }
        case DemoScenario.criticalSituation:
          if (member.role == MemberRole.parent) {
            medicines.addAll([
              _createMedicine(
                member,
                'Atorvastatin',
                '40mg',
                'Pill',
                'Take at night',
                EscalationPolicy.emergency,
                referenceTime,
              ),
              _createMedicine(
                member,
                'Insulin',
                '10 units',
                'Injection',
                'Before meals',
                EscalationPolicy.emergency,
                referenceTime,
              ),
              _createMedicine(
                member,
                'Blood Thinner',
                '75mg',
                'Pill',
                'Morning',
                EscalationPolicy.emergency,
                referenceTime,
              ),
            ]);
          }
        case DemoScenario.livingAloneParent:
          if (member.role == MemberRole.parent) {
            medicines.addAll([
              _createMedicine(
                member,
                'Donepezil',
                '10mg',
                'Pill',
                'Bedtime',
                EscalationPolicy.emergency,
                referenceTime,
              ),
              _createMedicine(
                member,
                'Sertraline',
                '50mg',
                'Pill',
                'Morning',
                EscalationPolicy.standard,
                referenceTime,
              ),
            ]);
          }
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
