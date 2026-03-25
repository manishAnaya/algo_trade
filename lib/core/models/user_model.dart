class UserModel {
  final int userId;
  final String name;
  final String email;
  final String mobile;
  final String? password;
  final bool isActive;
  final String createdDate;
  final bool isUserPause;
  final int apiId;
  final int strategyLimits;
  final int? otp;
  final DateTime? otpCreatedAt;

  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    this.password,
    required this.isActive,
    required this.createdDate,
    required this.isUserPause,
    required this.apiId,
    required this.strategyLimits,
    this.otp,
    this.otpCreatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool,
      createdDate: json['createdDate'],
      isUserPause: json['isUserPause'] as bool,
      apiId: json['apiId'] as int,
      strategyLimits: json['strategyLimits'] as int,
      otp: json['otp'] as int?,
      otpCreatedAt: json['otpCreatedAt'] != null
          ? DateTime.parse(json['otpCreatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'isActive': isActive,
      'createdDate': createdDate,
      'isUserPause': isUserPause,
      'apiId': apiId,
      'strategyLimits': strategyLimits,
      'otp': otp,
      'otpCreatedAt': otpCreatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? mobile,
    String? password,
    bool? isActive,
    bool? isUserPause,
    int? apiId,
    int? strategyLimits,
    int? otp,
    DateTime? otpCreatedAt,
  }) {
    return UserModel(
      userId: userId,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      createdDate: createdDate,
      isUserPause: isUserPause ?? this.isUserPause,
      apiId: apiId ?? this.apiId,
      strategyLimits: strategyLimits ?? this.strategyLimits,
      otp: otp ?? this.otp,
      otpCreatedAt: otpCreatedAt ?? this.otpCreatedAt,
    );
  }
}
