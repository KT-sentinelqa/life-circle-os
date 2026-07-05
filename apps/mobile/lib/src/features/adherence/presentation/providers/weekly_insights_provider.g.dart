// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_insights_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weeklyInsightsHash() => r'2234daa5b1baaeed6aa097ab3c0abafb1054186e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provides a weekly insight string based on recent adherence metrics.
///
/// Copied from [weeklyInsights].
@ProviderFor(weeklyInsights)
const weeklyInsightsProvider = WeeklyInsightsFamily();

/// Provides a weekly insight string based on recent adherence metrics.
///
/// Copied from [weeklyInsights].
class WeeklyInsightsFamily extends Family<AsyncValue<String?>> {
  /// Provides a weekly insight string based on recent adherence metrics.
  ///
  /// Copied from [weeklyInsights].
  const WeeklyInsightsFamily();

  /// Provides a weekly insight string based on recent adherence metrics.
  ///
  /// Copied from [weeklyInsights].
  WeeklyInsightsProvider call({
    String? medicineId,
  }) {
    return WeeklyInsightsProvider(
      medicineId: medicineId,
    );
  }

  @override
  WeeklyInsightsProvider getProviderOverride(
    covariant WeeklyInsightsProvider provider,
  ) {
    return call(
      medicineId: provider.medicineId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weeklyInsightsProvider';
}

/// Provides a weekly insight string based on recent adherence metrics.
///
/// Copied from [weeklyInsights].
class WeeklyInsightsProvider extends AutoDisposeFutureProvider<String?> {
  /// Provides a weekly insight string based on recent adherence metrics.
  ///
  /// Copied from [weeklyInsights].
  WeeklyInsightsProvider({
    String? medicineId,
  }) : this._internal(
          (ref) => weeklyInsights(
            ref as WeeklyInsightsRef,
            medicineId: medicineId,
          ),
          from: weeklyInsightsProvider,
          name: r'weeklyInsightsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weeklyInsightsHash,
          dependencies: WeeklyInsightsFamily._dependencies,
          allTransitiveDependencies:
              WeeklyInsightsFamily._allTransitiveDependencies,
          medicineId: medicineId,
        );

  WeeklyInsightsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.medicineId,
  }) : super.internal();

  final String? medicineId;

  @override
  Override overrideWith(
    FutureOr<String?> Function(WeeklyInsightsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeeklyInsightsProvider._internal(
        (ref) => create(ref as WeeklyInsightsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        medicineId: medicineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _WeeklyInsightsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklyInsightsProvider && other.medicineId == medicineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, medicineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeeklyInsightsRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `medicineId` of this provider.
  String? get medicineId;
}

class _WeeklyInsightsProviderElement
    extends AutoDisposeFutureProviderElement<String?> with WeeklyInsightsRef {
  _WeeklyInsightsProviderElement(super.provider);

  @override
  String? get medicineId => (origin as WeeklyInsightsProvider).medicineId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
