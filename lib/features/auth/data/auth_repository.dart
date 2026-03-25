import 'package:samriddhi_algo_trade_app/core/models/auth_response_model.dart';
import 'package:samriddhi_algo_trade_app/features/auth/data/auth_api_service.dart';
import '../../../core/models/broker_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/storage/auth_storage.dart';

class AuthRepository {
  final AuthApiService _apiService;
  final AuthStorage _storage;

  AuthRepository({
    required AuthApiService apiService,
    required AuthStorage storage,
  }) : _apiService = apiService,
       _storage = storage;

  Future<AuthResponseModel> getOtp(String mobileNo) async {
    return _apiService.sendOtp(mobileNo);
  }

  Future<AuthResponseModel> registerUser({
    required String name,
    required String email,
    required String mobile,
  }) async {
    return _apiService.registerUser(name: name, email: email, mobile: mobile);
  }

  Future<void> saveSession(AuthResponseModel response) async {
    await _storage.saveSession(
      accessToken: response.refreshExpiry,
      userId: response.user.userId.toString(),
      userName: response.user.name,
      email: response.user.email,
      phone: response.user.mobile,
      createdDate: response.user.createdDate,
      isActive: response.user.isActive,
      isUserPause: response.user.isUserPause,
      apiId: response.user.apiId,
      strategyLimits: response.user.strategyLimits,
      allBroker: response.allBroker,
      userBrokerId: response.userBrokerId,
    );
  }

  Future<UserModel?> getSavedUser() async {
    return _storage.getUser();
  }

  Future<List<BrokerModel>> getAllBrokers() async {
    return _storage.getAllBrokers();
  }

  Future<int?> getUserBrokerId() async {
    return _storage.getUserBrokerId();
  }

  // Future<bool> hasActiveSession() {
  //   return _storage.hasValidSession();
  // }

  Future<void> logout() {
    return _storage.clearSession();
  }
}
