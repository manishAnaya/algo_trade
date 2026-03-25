// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_selectors.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends $FunctionalProvider<UserModel?, UserModel?, UserModel?>
    with $Provider<UserModel?> {
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<UserModel?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserModel? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserModel?>(value),
    );
  }
}

String _$currentUserHash() => r'4a3a5af1bfc058365489f8864d011b9120542f22';

@ProviderFor(allBroker)
final allBrokerProvider = AllBrokerProvider._();

final class AllBrokerProvider
    extends
        $FunctionalProvider<
          List<BrokerModel>?,
          List<BrokerModel>?,
          List<BrokerModel>?
        >
    with $Provider<List<BrokerModel>?> {
  AllBrokerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allBrokerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allBrokerHash();

  @$internal
  @override
  $ProviderElement<List<BrokerModel>?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<BrokerModel>? create(Ref ref) {
    return allBroker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<BrokerModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<BrokerModel>?>(value),
    );
  }
}

String _$allBrokerHash() => r'b0065bfb6a21f0bdf718b444fc89713c34ab6061';

@ProviderFor(currentBroker)
final currentBrokerProvider = CurrentBrokerProvider._();

final class CurrentBrokerProvider
    extends $FunctionalProvider<BrokerModel?, BrokerModel?, BrokerModel?>
    with $Provider<BrokerModel?> {
  CurrentBrokerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBrokerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBrokerHash();

  @$internal
  @override
  $ProviderElement<BrokerModel?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BrokerModel? create(Ref ref) {
    return currentBroker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BrokerModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BrokerModel?>(value),
    );
  }
}

String _$currentBrokerHash() => r'd3d4c33c8770f167962887a349712229e2e6303f';
