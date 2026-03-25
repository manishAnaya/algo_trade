import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samriddhi_algo_trade_app/core/constants/app_constants.dart';
import 'package:samriddhi_algo_trade_app/core/constants/app_images.dart';
import 'package:samriddhi_algo_trade_app/core/themes/app_colors.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_notifier.dart';
import 'package:samriddhi_algo_trade_app/features/common/auth_loading.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/routes/app_routes.dart';
import '../../common/error_card.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    final phone = _phoneCtrl.text.trim();

    final notifier = ref.read(authProvider.notifier);
    final success = await notifier.sendOtp(phone);

    if (success && mounted) {
      context.push(AppRoutes.otp, extra: {'phone': phone});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;
    final error = authState.asError?.error;
    final errorMessage = error is AuthException ? error.message : null;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 64),
                    // Logo
                    Image.asset(
                      AppImages.appLogo,
                      width: 140,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Welcome back 👋',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your mobile number to continue',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Error
                    if (errorMessage != null) ...[
                      ErrorCard(errorMessage: errorMessage),
                      const SizedBox(height: 20),
                    ],
                    AppTextField(
                      label: 'Mobile Number',
                      hint: '+91 99999 99999',
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Enter your mobile number';
                        }
                        if (v.replaceAll(RegExp(r'\D'), '').length < 10) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    isLoading
                        ? AuthLoading()
                        : ElevatedButton(
                            onPressed: _sendOtp,
                            child: const Text('Login with OTP'),
                          ),
                    const SizedBox(height: 32),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.read(authProvider.notifier).clearError();
                              context.push(AppRoutes.signup);
                            },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.spaceGrotesk(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'By continuing, you agree to our Terms & Privacy Policy',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Powered by : ",
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.push(AppRoutes.signup),
                            child: Text(
                              AppConstants.companyName,
                              style: GoogleFonts.spaceGrotesk(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
