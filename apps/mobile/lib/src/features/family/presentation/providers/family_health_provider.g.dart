// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$familyHealthScoreHash() => r'63a4ea89a3bbf360a4a00b25d627888912306fb1';

/// Provides the aggregated [FamilyHealthScore] for the current family
/// over the past 7 days.
///
/// Copied from [familyHealthScore].
@ProviderFor(familyHealthScore)
final familyHealthScoreProvider =
    AutoDisposeFutureProvider<FamilyHealthScore?>.internal(
  familyHealthScore,
  name: r'familyHealthScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$familyHealthScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FamilyHealthScoreRef = AutoDisposeFutureProviderRef<FamilyHealthScore?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
