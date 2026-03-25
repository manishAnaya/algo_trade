import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Palette
  static const Color primary = Color(0xFF00D4AA);
  static const Color primaryDark = Color(0xFF00A882);
  static const Color primaryLight = Color(0xFF33DDBB);
  static const Color accent = Color(0xFFFFB830);
  static const Color accentRed = Color(0xFFFF4757);

  // Background
  static const Color bgDark = Color(0xFF080E1A);
  static const Color bgCard = Color(0xFF0F1923);
  static const Color bgSurface = Color(0xFF152032);
  static const Color bgElevated = Color(0xFF1A2840);

  // Text
  static const Color textPrimary = Color(0xFFF0F4F8);
  static const Color textSecondary = Color(0xFF8BA3BE);
  static const Color textMuted = Color(0xFF4A6280);
  static const Color textOnPrimary = Color(0xFF080E1A);

  // Status
  static const Color success = Color(0xFF00D4AA);
  static const Color danger = Color(0xFFFF4757);
  static const Color warning = Color(0xFFFFB830);
  static const Color info = Color(0xFF3D9EFF);

  // Borders
  static const Color border = Color(0xFF1E3050);
  static const Color borderLight = Color(0xFF253F5E);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF00D4AA),
    Color(0xFF00A882),
  ];
  static const List<Color> cardGradient = [
    Color(0xFF0F1923),
    Color(0xFF152032),
  ];
  static const List<Color> bgGradient = [Color(0xFF080E1A), Color(0xFF0C1520)];
}
