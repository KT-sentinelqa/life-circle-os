// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_duties_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$householdDutiesListHash() =>
    r'491a2749d904a5e65822e175295ce00923811970';

/// Provides the current list of delegated household responsibilities.
///
/// Copied from [householdDutiesList].
@ProviderFor(householdDutiesList)
final householdDutiesListProvider =
    AutoDisposeFutureProvider<List<HouseholdDutyEntity>>.internal(
  householdDutiesList,
  name: r'householdDutiesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$householdDutiesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HouseholdDutiesListRef
    = AutoDisposeFutureProviderRef<List<HouseholdDutyEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
