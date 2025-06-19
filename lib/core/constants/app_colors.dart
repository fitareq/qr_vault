import 'package:flutter/material.dart';

class AppColors {
  // Brand / Primary Colors
  static const Color primary = Color(0xFF1E88E5); // Tech blue
  static const Color primaryVariant = Color(0xFF1565C0); // Darker variant
  static const Color secondary = Color(0xFF00C853); // Green accent

  // Light Mode Neutrals
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF5F5F5); // Light grey
  static const Color textPrimary = Color(0xFF212121); // Almost black
  static const Color textSecondary = Color(0xFF616161); // Medium grey

  // Dark Mode Neutrals
  static const Color backgroundDark = Color(0xFF121212); // Dark background
  static const Color surfaceDark = Color(
    0xFF2E2E2E,
  ); // Slightly lighter surface
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // White text
  static const Color textSecondaryDark = Color(0xFFBDBDBD); // Light grey text

  // Utility Colors
  static const Color error = Color(0xFFD32F2F); // Error red
  static const Color success = Color(0xFF388E3C); // Success green
  static const Color warning = Color(0xFFFBC02D); // Warning yellow
  static const Color disabled = Color(0xFFBDBDBD); // Disabled state
  static const Color divider = Color(0xFFBDBDBD); // Divider lines
}
