import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samriddhi_algo_trade_app/core/storage/auth_storage_provider.dart';
import 'package:samriddhi_algo_trade_app/features/auth/data/auth_repository.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_api_service_provider.dart';
part 'auth_repository_provider.g.dart';

@riverpod
Future<AuthRepository> authRepository(Ref ref) async {
  final apiService = ref.watch(authApiServiceProvider);
  final storage = ref.watch(authStorageProvider);
  return AuthRepository(apiService: apiService, storage: storage);
}
