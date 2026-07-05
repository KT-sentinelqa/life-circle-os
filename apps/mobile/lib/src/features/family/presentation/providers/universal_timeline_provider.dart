import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/timeline_event.dart';
import 'package:lifecircle_mobile/src/features/finance/presentation/providers/emi_provider.dart';
import 'package:lifecircle_mobile/src/features/protection/presentation/providers/insurance_provider.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/providers/household_duties_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'universal_timeline_provider.g.dart';

/// Provides a unified, chronologically sorted list of all family events
/// (Medicines, EMIs, Insurances, Duties).
@riverpod
Future<List<TimelineEvent>> universalTimeline(UniversalTimelineRef ref) async {
  final user = ref.watch(authProvider).valueOrNull;
  if (user == null || user.familyId == null) return [];

  final now = DateTime.now();
  final events = <TimelineEvent>[];

  // 1. Add EMIs
  final emis = await ref.watch(emiListProvider.future);
  for (final emi in emis) {
    events.add(
      TimelineEvent(
        id: emi.id,
        title: '${emi.name} EMI',
        time: emi.dueDate,
        icon: Icons.credit_card,
        color: AppColors.warning,
        isCompleted: false,
        isCritical: emi.dueDate.difference(now).inDays <= 3,
      ),
    );
  }

  // 2. Add Insurances
  final insurances = await ref.watch(insuranceListProvider.future);
  for (final ins in insurances) {
    events.add(
      TimelineEvent(
        id: ins.id,
        title: '${ins.name} Renewal',
        time: ins.renewalDate,
        icon: Icons.shield,
        color: AppColors.error,
        isCompleted: false,
        isCritical: ins.renewalDate.difference(now).inDays <= 7,
      ),
    );
  }

  // 3. Add Duties
  final duties = await ref.watch(householdDutiesListProvider.future);
  for (final duty in duties) {
    events.add(
      TimelineEvent(
        id: duty.id,
        title: duty.taskName,
        time: now,
        icon: Icons.task_alt,
        color: AppColors.primary,
        isCompleted: duty.isCompleted,
      ),
    );
  }

  // 4. (Simulated) Add deterministic adherence records for the showcase
  events
    ..add(
      TimelineEvent(
        id: 'med-1',
        title: 'Rajesh — Amlodipine',
        time: DateTime(now.year, now.month, now.day, 7),
        icon: Icons.medication,
        color: AppColors.success,
        isCompleted: true,
      ),
    )
    ..add(
      TimelineEvent(
        id: 'med-2',
        title: 'Sunita — Calcium',
        time: DateTime(now.year, now.month, now.day, 8, 30),
        icon: Icons.medication,
        color: AppColors.success,
        isCompleted: true,
      ),
    )
    ..sort((a, b) => a.time.compareTo(b.time));

  return events;
}
