import 'broker_model.dart';
import 'user_model.dart';

class AuthResponseModel {
  final UserModel user;
  final String refreshExpiry;
  final List<BrokerModel> allBroker;
  final int userBrokerId;
  final String message;

  const AuthResponseModel({
    required this.user,
    required this.refreshExpiry,
    required this.allBroker,
    required this.userBrokerId,
    required this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      refreshExpiry: json['refreshexpiry'] as String? ?? '',
      allBroker: (json['allbroker'] as List<dynamic>)
          .map((e) => BrokerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userBrokerId: json['userbrokerid'] as int,
      message: json['message'] as String,
    );
  }
}
