// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$insuranceListHash() => r'278ebbbdf8a6318fa2a0c35a9174e842d020d137';

/// Provides the current list of active insurance policies for the family.
///
/// Copied from [insuranceList].
@ProviderFor(insuranceList)
final insuranceListProvider =
    AutoDisposeFutureProvider<List<InsuranceEntity>>.internal(
  insuranceList,
  name: r'insuranceListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$insuranceListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InsuranceListRef = AutoDisposeFutureProviderRef<List<InsuranceEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
