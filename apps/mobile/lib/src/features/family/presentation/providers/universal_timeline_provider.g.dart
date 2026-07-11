// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'universal_timeline_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$universalTimelineHash() => r'447c849a36267ecd07f7df457db5c29e9d4f0255';

/// Provides a unified, chronologically sorted list of all family events
/// (Medicines, EMIs, Insurances, Duties).
///
/// Copied from [universalTimeline].
@ProviderFor(universalTimeline)
final universalTimelineProvider =
    AutoDisposeFutureProvider<List<TimelineEvent>>.internal(
  universalTimeline,
  name: r'universalTimelineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$universalTimelineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UniversalTimelineRef
    = AutoDisposeFutureProviderRef<List<TimelineEvent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
