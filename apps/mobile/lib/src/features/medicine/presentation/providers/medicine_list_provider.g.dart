// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicineListStateHash() => r'0efbbfe1b2f87a0c4e37d037edcf9bd55d6ae54e';

/// Provider for the list of medicines for the current user.
///
/// Copied from [MedicineListState].
@ProviderFor(MedicineListState)
final medicineListStateProvider = AutoDisposeAsyncNotifierProvider<
    MedicineListState, List<MedicineEntity>>.internal(
  MedicineListState.new,
  name: r'medicineListStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicineListStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MedicineListState = AutoDisposeAsyncNotifier<List<MedicineEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
