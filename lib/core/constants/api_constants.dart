class ApiConstants {
  ApiConstants._();

  // ── Base URL  ─────────────
  static const String baseUrl = 'https://4a77-106-51-76-240.ngrok-free.app/api';

  // ── Auth Endpoints ─────────────────────────────────────────
  static const String register = '/user/register'; // POST
  static const String sendOtp = '/user/send-otp'; // POST

  // ── Timeouts ───────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ── Header keys ────────────────────────────────────────────
  static const String authHeader = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String ngrokSkipBrowserWarning = 'ngrok-skip-browser-warning';
}
