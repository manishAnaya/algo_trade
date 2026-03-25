import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:samriddhi_algo_trade_app/core/models/broker_model.dart';
import '../models/user_model.dart';

class AuthStorage {
  final FlutterSecureStorage _storage;

  AuthStorage({required FlutterSecureStorage storage}) : _storage = storage;

  static const _keyAccessToken = 'access_token';
  static const _keyUserId = 'user_id';
  static const _keyUserName = 'user_name';
  static const _keyEmail = 'email';
  static const _keyPhone = 'phone';
  static const _keyLoginTime = 'login_time';
  static const _keyCreatedDate = 'created_date';
  static const _keyIsActive = 'is_active';
  static const _keyIsUserPause = 'is_user_pause';
  static const _keyApiId = 'api_id';
  static const _keyStrategyLimits = 'strategy_limits';
  static const _keyAllBroker = 'all_broker';
  static const _keyUserBrokerId = 'user_broker_id';

  Future<void> saveSession({
    required String accessToken,
    required String userId,
    required String userName,
    required String email,
    required String phone,
    required String createdDate,
    required bool isActive,
    required bool isUserPause,
    required int apiId,
    required int strategyLimits,
    required List<BrokerModel> allBroker,
    required int userBrokerId,
  }) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyUserId, value: userId);
    await _storage.write(key: _keyUserName, value: userName);
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPhone, value: phone);
    await _storage.write(key: _keyCreatedDate, value: createdDate);
    await _storage.write(key: _keyIsActive, value: isActive.toString());
    await _storage.write(key: _keyIsUserPause, value: isUserPause.toString());
    await _storage.write(key: _keyApiId, value: apiId.toString());
    await _storage.write(
      key: _keyStrategyLimits,
      value: strategyLimits.toString(),
    );
    await _storage.write(
      key: _keyAllBroker,
      value: jsonEncode(allBroker.map((b) => b.toJson()).toList()),
    );
    await _storage.write(key: _keyUserBrokerId, value: userBrokerId.toString());
    await _storage.write(
      key: _keyLoginTime,
      value: DateTime.now().toIso8601String(),
    );
  }

  Future<String?> getAccessToken() => _storage.read(key: _keyAccessToken);

  Future<void> clearSession() => _storage.deleteAll();

  Future<UserModel?> getUser() async {
    final userId = await _storage.read(key: _keyUserId);
    final name = await _storage.read(key: _keyUserName);
    final email = await _storage.read(key: _keyEmail);
    final phone = await _storage.read(key: _keyPhone);
    final createdDate = await _storage.read(key: _keyCreatedDate);
    final isActive = await _storage.read(key: _keyCreatedDate);
    final isUserPause = await _storage.read(key: _keyCreatedDate);
    final apiId = await _storage.read(key: _keyCreatedDate);
    final strategyLimits = await _storage.read(key: _keyCreatedDate);
    if (userId == null || name == null) return null;

    return UserModel(
      userId: int.parse(userId),
      name: name,
      email: email ?? '',
      mobile: phone ?? '',
      isActive: isActive == 'true',
      createdDate: createdDate ?? '',
      isUserPause: isUserPause == 'true',
      apiId: int.parse(apiId ?? '0'),
      strategyLimits: int.parse(strategyLimits ?? '0'),
    );
  }

  Future<List<BrokerModel>> getAllBrokers() async {
    final brokerJson = await _storage.read(key: _keyAllBroker);
    if (brokerJson == null) return [];

    final List<dynamic> decoded = jsonDecode(brokerJson);
    return decoded.map((e) => BrokerModel.fromJson(e)).toList();
  }

  Future<int?> getUserBrokerId() async {
    final id = await _storage.read(key: _keyUserBrokerId);
    return id != null ? int.parse(id) : null;
  }

  // Future<bool> hasValidSession() async {
  // final token = await getAccessToken();
  // if (token == null) return false;

  // final loginTimeStr = await _storage.read(key: _keyLoginTime);
  // if (loginTimeStr == null) return false;

  // const istOffset = Duration(hours: 5, minutes: 30);
  // final istNow = DateTime.now().toUtc().add(istOffset);
  // final istLogin = DateTime.parse(loginTimeStr).toUtc().add(istOffset);
  // final expiry = DateTime(istLogin.year, istLogin.month, istLogin.day + 1);

  // return istNow.isBefore(expiry);
  // }
}
