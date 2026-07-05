// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adherence_metrics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adherenceMetricsHash() => r'67ed4c45a5244223807ea075f56e626d2cdbfea9';

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

/// Provides adherence metrics for the last 30 days.
///
/// Copied from [adherenceMetrics].
@ProviderFor(adherenceMetrics)
const adherenceMetricsProvider = AdherenceMetricsFamily();

/// Provides adherence metrics for the last 30 days.
///
/// Copied from [adherenceMetrics].
class AdherenceMetricsFamily extends Family<AsyncValue<AdherenceMetrics?>> {
  /// Provides adherence metrics for the last 30 days.
  ///
  /// Copied from [adherenceMetrics].
  const AdherenceMetricsFamily();

  /// Provides adherence metrics for the last 30 days.
  ///
  /// Copied from [adherenceMetrics].
  AdherenceMetricsProvider call({
    String? medicineId,
  }) {
    return AdherenceMetricsProvider(
      medicineId: medicineId,
    );
  }

  @override
  AdherenceMetricsProvider getProviderOverride(
    covariant AdherenceMetricsProvider provider,
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
  String? get name => r'adherenceMetricsProvider';
}

/// Provides adherence metrics for the last 30 days.
///
/// Copied from [adherenceMetrics].
class AdherenceMetricsProvider
    extends AutoDisposeFutureProvider<AdherenceMetrics?> {
  /// Provides adherence metrics for the last 30 days.
  ///
  /// Copied from [adherenceMetrics].
  AdherenceMetricsProvider({
    String? medicineId,
  }) : this._internal(
          (ref) => adherenceMetrics(
            ref as AdherenceMetricsRef,
            medicineId: medicineId,
          ),
          from: adherenceMetricsProvider,
          name: r'adherenceMetricsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adherenceMetricsHash,
          dependencies: AdherenceMetricsFamily._dependencies,
          allTransitiveDependencies:
              AdherenceMetricsFamily._allTransitiveDependencies,
          medicineId: medicineId,
        );

  AdherenceMetricsProvider._internal(
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
    FutureOr<AdherenceMetrics?> Function(AdherenceMetricsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdherenceMetricsProvider._internal(
        (ref) => create(ref as AdherenceMetricsRef),
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
  AutoDisposeFutureProviderElement<AdherenceMetrics?> createElement() {
    return _AdherenceMetricsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdherenceMetricsProvider && other.medicineId == medicineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, medicineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AdherenceMetricsRef on AutoDisposeFutureProviderRef<AdherenceMetrics?> {
  /// The parameter `medicineId` of this provider.
  String? get medicineId;
}

class _AdherenceMetricsProviderElement
    extends AutoDisposeFutureProviderElement<AdherenceMetrics?>
    with AdherenceMetricsRef {
  _AdherenceMetricsProviderElement(super.provider);

  @override
  String? get medicineId => (origin as AdherenceMetricsProvider).medicineId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
