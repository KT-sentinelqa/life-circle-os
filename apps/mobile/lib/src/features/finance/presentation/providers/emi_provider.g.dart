// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emi_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emiListHash() => r'e68d37dc26a8d847b7e61c1e1b13c7bad40b4df7';

/// Provides the current list of active EMI obligations for the family.
///
/// Copied from [emiList].
@ProviderFor(emiList)
final emiListProvider = AutoDisposeFutureProvider<List<EmiEntity>>.internal(
  emiList,
  name: r'emiListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emiListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EmiListRef = AutoDisposeFutureProviderRef<List<EmiEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
