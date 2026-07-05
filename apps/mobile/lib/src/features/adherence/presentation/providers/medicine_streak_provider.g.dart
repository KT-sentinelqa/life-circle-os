// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_streak_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicineStreakHash() => r'08abfdadb3e70a6e70501c51df73b2fa37899e5e';

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

/// Provides the current streak for a medicine, or global streak if null.
///
/// Copied from [medicineStreak].
@ProviderFor(medicineStreak)
const medicineStreakProvider = MedicineStreakFamily();

/// Provides the current streak for a medicine, or global streak if null.
///
/// Copied from [medicineStreak].
class MedicineStreakFamily extends Family<AsyncValue<MedicineStreak?>> {
  /// Provides the current streak for a medicine, or global streak if null.
  ///
  /// Copied from [medicineStreak].
  const MedicineStreakFamily();

  /// Provides the current streak for a medicine, or global streak if null.
  ///
  /// Copied from [medicineStreak].
  MedicineStreakProvider call({
    String? medicineId,
  }) {
    return MedicineStreakProvider(
      medicineId: medicineId,
    );
  }

  @override
  MedicineStreakProvider getProviderOverride(
    covariant MedicineStreakProvider provider,
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
  String? get name => r'medicineStreakProvider';
}

/// Provides the current streak for a medicine, or global streak if null.
///
/// Copied from [medicineStreak].
class MedicineStreakProvider
    extends AutoDisposeFutureProvider<MedicineStreak?> {
  /// Provides the current streak for a medicine, or global streak if null.
  ///
  /// Copied from [medicineStreak].
  MedicineStreakProvider({
    String? medicineId,
  }) : this._internal(
          (ref) => medicineStreak(
            ref as MedicineStreakRef,
            medicineId: medicineId,
          ),
          from: medicineStreakProvider,
          name: r'medicineStreakProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$medicineStreakHash,
          dependencies: MedicineStreakFamily._dependencies,
          allTransitiveDependencies:
              MedicineStreakFamily._allTransitiveDependencies,
          medicineId: medicineId,
        );

  MedicineStreakProvider._internal(
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
    FutureOr<MedicineStreak?> Function(MedicineStreakRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MedicineStreakProvider._internal(
        (ref) => create(ref as MedicineStreakRef),
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
  AutoDisposeFutureProviderElement<MedicineStreak?> createElement() {
    return _MedicineStreakProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MedicineStreakProvider && other.medicineId == medicineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, medicineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MedicineStreakRef on AutoDisposeFutureProviderRef<MedicineStreak?> {
  /// The parameter `medicineId` of this provider.
  String? get medicineId;
}

class _MedicineStreakProviderElement
    extends AutoDisposeFutureProviderElement<MedicineStreak?>
    with MedicineStreakRef {
  _MedicineStreakProviderElement(super.provider);

  @override
  String? get medicineId => (origin as MedicineStreakProvider).medicineId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
