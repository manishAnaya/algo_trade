// lib/features/auth/screens/otp_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samriddhi_algo_trade_app/core/exceptions/auth_exception.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_notifier.dart';
import 'package:samriddhi_algo_trade_app/features/common/auth_loading.dart';
import 'package:samriddhi_algo_trade_app/features/common/error_card.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_colors.dart';

class OtpScreen extends ConsumerStatefulWidget {
  /// Passed via GoRouter extra:
  /// { 'phone': String}
  final Map<String, dynamic> args;

  const OtpScreen({super.key, required this.args});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  static const int _otpLength = 6;
  static const int _resendCooldown = 30;

  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  int _secondsLeft = _resendCooldown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Auto-focus first box
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _secondsLeft = _resendCooldown;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    // Handle paste — spread across boxes
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < _otpLength && i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      final next = digits.length < _otpLength ? digits.length : _otpLength - 1;
      _focusNodes[next].requestFocus();
      setState(() {});
      return;
    }
    setState(() {});
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    if (_otp.length < _otpLength) return;

    final success = await ref
        .read(authProvider.notifier)
        .verifyOtp(enteredOtp: _otp);

    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  Future<void> _resendOtp() async {
    if (_secondsLeft > 0) return;
    final phone = widget.args['phone'] as String;
    await ref.read(authProvider.notifier).sendOtp(phone);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;
    final error = authState.asError?.error;
    final errorMessage = error is AuthException ? error.message : null;
    final phone = widget.args['phone'] as String? ?? '';
    final isOtpFilled = _otp.length == _otpLength;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appLogo,
              width: 140,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Text(
              'Verify Your Number',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We sent a 6-digit code to',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),
            Text(
              '+91 $phone',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(GlobalVariable.serverOtp),
            const SizedBox(height: 40),

            // Error banner
            if (errorMessage != null) ...[
              ErrorCard(errorMessage: errorMessage),
              const SizedBox(height: 24),
            ],

            // OTP boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_otpLength, (index) {
                // final isFocused = _focusNodes[index].hasFocus;
                final isFilled = _controllers[index].text.isNotEmpty;
                return SizedBox(
                  width: 48,
                  height: 56,
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) => _onKeyEvent(event, index),
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: isFilled
                            ? AppColors.primary.withValues(alpha: 0.12)
                            : AppColors.bgSurface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isFilled
                                ? AppColors.primary.withValues(alpha: 0.6)
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (v) => _onChanged(v, index),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),

            // Verify button
            isLoading
                ? AuthLoading()
                : ElevatedButton(
                    onPressed: isOtpFilled ? _verifyOtp : null,
                    child: const Text('Verify OTP'),
                  ),
            const SizedBox(height: 28),

            // Resend
            Center(
              child: _secondsLeft > 0
                  ? RichText(
                      text: TextSpan(
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(text: 'Resend OTP in '),
                          TextSpan(
                            text: '${_secondsLeft}s',
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: _resendOtp,
                      child: Text(
                        'Resend OTP',
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 24),

            // Info notice
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.sms_outlined,
                    color: AppColors.info,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'The OTP is valid for 10 minutes. Do not share it with anyone.',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.info,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
