// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_members_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$familyMembersHash() => r'17a512549dd80d6ed11d724854b94e7aef87de9d';

/// Provides the list of members in the active family.
///
/// Copied from [familyMembers].
@ProviderFor(familyMembers)
final familyMembersProvider =
    AutoDisposeFutureProvider<List<FamilyMemberEntity>>.internal(
  familyMembers,
  name: r'familyMembersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$familyMembersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FamilyMembersRef
    = AutoDisposeFutureProviderRef<List<FamilyMemberEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
