// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authStorage)
final authStorageProvider = AuthStorageProvider._();

final class AuthStorageProvider
    extends $FunctionalProvider<AuthStorage, AuthStorage, AuthStorage>
    with $Provider<AuthStorage> {
  AuthStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStorageHash();

  @$internal
  @override
  $ProviderElement<AuthStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthStorage create(Ref ref) {
    return authStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStorage>(value),
    );
  }
}

String _$authStorageHash() => r'0dcbe93a67e93f784ff1059d0d51cb47a3dea072';
