import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samriddhi_algo_trade_app/core/exceptions/auth_exception.dart';
import 'package:samriddhi_algo_trade_app/features/auth/data/auth_repository.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_repository_provider.dart';
import '../../../core/models/auth_response_model.dart';
import 'auth_state.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthRepository _repository;

  AuthResponseModel? _authResponse;

  @override
  Future<AuthState> build() async {
    _repository = await ref.watch(authRepositoryProvider.future);

    final savedUser = await _repository.getSavedUser();
    final isLoggedIn = savedUser != null;
    final allBroker = await _repository.getAllBrokers();
    final userBrokerId = await _repository.getUserBrokerId();
    return AuthState(
      isLoggedIn: isLoggedIn,
      isOnboarded: true,
      user: savedUser,
      allBroker: allBroker,
      userBrokerId: userBrokerId,
    );
  }

  Future<bool> sendOtp(String phoneNo) async {
    final current = state.asData?.value ?? AuthState.initial();
    state = const AsyncLoading();
    try {
      final response = await _repository.getOtp(phoneNo);
      _authResponse = response;
      GlobalVariable.serverOtp = response.user.otp!.toString();

      state = AsyncData(current.copyWith(isLoading: false));
      return true;
    } on AuthException catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> verifyOtp({required String enteredOtp}) async {
    final current = state.asData?.value ?? AuthState.initial();
    state = const AsyncLoading();
    if (_authResponse == null) return false;
    try {
      final serverOtp = _authResponse!.user.otp?.toString();

      if (serverOtp == null || enteredOtp.trim() != serverOtp) {
        throw AuthException.invalidOtp();
      }

      final otpCreatedAt = _authResponse!.user.otpCreatedAt;
      if (otpCreatedAt != null) {
        final expiresAt = otpCreatedAt.add(const Duration(minutes: 5));
        if (DateTime.now().isAfter(expiresAt)) {
          throw AuthException.otpExpired();
        }
      }
      await _repository.saveSession(_authResponse!);
      debugPrint('🔑 refreshExpiry: ${_authResponse!.refreshExpiry}');
      debugPrint('👤 user name: ${_authResponse!.user.name}');
      state = AsyncData(
        current.copyWith(
          isLoggedIn: true,
          user: _authResponse!.user,
          allBroker: _authResponse!.allBroker,
          userBrokerId: _authResponse!.userBrokerId,
        ),
      );
      return true;
    } on AuthException catch (e) {
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
  }) async {
    state = const AsyncLoading();
    try {
      final current = state.asData?.value ?? AuthState.initial();
      final response = await _repository.registerUser(
        name: name,
        email: email,
        mobile: phone,
      );
      _authResponse = response;

      state = AsyncData(current.copyWith(isLoading: false));
      return true;
    } on AuthException catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  void clearError() {
    final current = state.asData?.value ?? AuthState.initial();
    state = AsyncData(current);
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AsyncData(AuthState.initial());
  }
}

class GlobalVariable {
  static String serverOtp = '';
}
