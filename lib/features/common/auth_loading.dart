import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.bgDark,
          ),
        ),
      ),
    );
  }
}
