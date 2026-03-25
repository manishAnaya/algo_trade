import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samriddhi_algo_trade_app/core/network/http_client_provider.dart';
import 'package:samriddhi_algo_trade_app/features/auth/data/auth_api_service.dart';
part 'auth_api_service_provider.g.dart';

@riverpod
AuthApiService authApiService(Ref ref) {
  final client = ref.watch(httpClientProvider);
  return AuthApiService(client: client);
}
