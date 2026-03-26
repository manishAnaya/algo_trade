import 'package:samriddhi_algo_trade_app/core/models/user_model.dart';
import '../../../core/models/broker_model.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isOnboarded;
  final UserModel? user;
  final List<BrokerModel>? allBroker;
  final int? userBrokerId;

  AuthState({
    required this.isLoggedIn,
    required this.isOnboarded,
    this.user,
    this.allBroker,
    this.userBrokerId,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isOnboarded,

    UserModel? user,
    List<BrokerModel>? allBroker,
    int? userBrokerId,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      user: user ?? this.user,
      allBroker: allBroker ?? this.allBroker,
      userBrokerId: userBrokerId ?? this.userBrokerId,
    );
  }

  factory AuthState.initial() {
    return AuthState(
      isLoggedIn: false,
      isOnboarded: false,
      user: null,
      allBroker: null,
      userBrokerId: null,
    );
  }
}
