import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samriddhi_algo_trade_app/core/storage/auth_storage.dart';
import 'secure_storage_provider.dart';
part 'auth_storage_provider.g.dart';

@riverpod
AuthStorage authStorage(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthStorage(storage: storage);
}
