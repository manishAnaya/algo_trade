enum AuthErrorType {
  network,
  server,
  unauthorized,
  invalidOtp,
  otpExpired,
  newUser,
  userExists,
  unknown,
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;
  final AuthErrorType type;

  AuthException({
    required this.message,
    this.statusCode,
    this.type = AuthErrorType.unknown,
  });

  factory AuthException.fromResponse({
    required int statusCode,
    String? message,
  }) {
    switch (statusCode) {
      case 400:
        return AuthException(
          message: message ?? 'Invalid request.',
          statusCode: statusCode,
          type: AuthErrorType.userExists,
        );

      case 401:
        return AuthException(
          message: message ?? 'Unauthorized access.',
          statusCode: statusCode,
          type: AuthErrorType.unauthorized,
        );

      case 404:
        return AuthException(
          message: message ?? 'You are not registered yet',
          statusCode: statusCode,
          type: AuthErrorType.newUser,
        );

      case 500:
        return AuthException(
          message: message ?? 'Server error. Please try again later.',
          statusCode: statusCode,
          type: AuthErrorType.server,
        );

      default:
        return AuthException(
          message: message ?? 'Something went wrong.',
          statusCode: statusCode,
          type: AuthErrorType.unknown,
        );
    }
  }

  factory AuthException.network() {
    return AuthException(
      message: 'Please check your internet connection.',
      type: AuthErrorType.network,
    );
  }

  factory AuthException.serverError() {
    return AuthException(
      message: 'Server error. Please try again later.',
      type: AuthErrorType.server,
    );
  }

  factory AuthException.invalidOtp() {
    return AuthException(
      message: 'Invalid OTP. Please try again.',
      type: AuthErrorType.invalidOtp,
    );
  }

  factory AuthException.otpExpired() {
    return AuthException(
      message: 'OTP has expired. Request a new one.',
      type: AuthErrorType.otpExpired,
    );
  }

  @override
  String toString() {
    return 'AuthException(type: $type, message: $message, statusCode: $statusCode)';
  }
}
