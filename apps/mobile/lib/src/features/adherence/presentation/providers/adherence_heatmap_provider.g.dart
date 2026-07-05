// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adherence_heatmap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adherenceHeatmapHash() => r'24a4fe5e1c0c8f7aa3728b12c854c190e17e6aa4';

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

/// Provides historical adherence records (e.g., last 90 days) for rendering
/// the heatmap.
///
/// Copied from [adherenceHeatmap].
@ProviderFor(adherenceHeatmap)
const adherenceHeatmapProvider = AdherenceHeatmapFamily();

/// Provides historical adherence records (e.g., last 90 days) for rendering
/// the heatmap.
///
/// Copied from [adherenceHeatmap].
class AdherenceHeatmapFamily extends Family<AsyncValue<List<AdherenceRecord>>> {
  /// Provides historical adherence records (e.g., last 90 days) for rendering
  /// the heatmap.
  ///
  /// Copied from [adherenceHeatmap].
  const AdherenceHeatmapFamily();

  /// Provides historical adherence records (e.g., last 90 days) for rendering
  /// the heatmap.
  ///
  /// Copied from [adherenceHeatmap].
  AdherenceHeatmapProvider call({
    String? medicineId,
  }) {
    return AdherenceHeatmapProvider(
      medicineId: medicineId,
    );
  }

  @override
  AdherenceHeatmapProvider getProviderOverride(
    covariant AdherenceHeatmapProvider provider,
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
  String? get name => r'adherenceHeatmapProvider';
}

/// Provides historical adherence records (e.g., last 90 days) for rendering
/// the heatmap.
///
/// Copied from [adherenceHeatmap].
class AdherenceHeatmapProvider
    extends AutoDisposeFutureProvider<List<AdherenceRecord>> {
  /// Provides historical adherence records (e.g., last 90 days) for rendering
  /// the heatmap.
  ///
  /// Copied from [adherenceHeatmap].
  AdherenceHeatmapProvider({
    String? medicineId,
  }) : this._internal(
          (ref) => adherenceHeatmap(
            ref as AdherenceHeatmapRef,
            medicineId: medicineId,
          ),
          from: adherenceHeatmapProvider,
          name: r'adherenceHeatmapProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adherenceHeatmapHash,
          dependencies: AdherenceHeatmapFamily._dependencies,
          allTransitiveDependencies:
              AdherenceHeatmapFamily._allTransitiveDependencies,
          medicineId: medicineId,
        );

  AdherenceHeatmapProvider._internal(
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
    FutureOr<List<AdherenceRecord>> Function(AdherenceHeatmapRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdherenceHeatmapProvider._internal(
        (ref) => create(ref as AdherenceHeatmapRef),
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
  AutoDisposeFutureProviderElement<List<AdherenceRecord>> createElement() {
    return _AdherenceHeatmapProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdherenceHeatmapProvider && other.medicineId == medicineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, medicineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AdherenceHeatmapRef
    on AutoDisposeFutureProviderRef<List<AdherenceRecord>> {
  /// The parameter `medicineId` of this provider.
  String? get medicineId;
}

class _AdherenceHeatmapProviderElement
    extends AutoDisposeFutureProviderElement<List<AdherenceRecord>>
    with AdherenceHeatmapRef {
  _AdherenceHeatmapProviderElement(super.provider);

  @override
  String? get medicineId => (origin as AdherenceHeatmapProvider).medicineId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
