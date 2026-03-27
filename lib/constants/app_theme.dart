import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_font.dart';

class AppTheme {
  // Theme Palette from DESIGN.md
  static const Color surface = Color(0xFFF5F6F7);
  static const Color surfaceContainerLow = Color(0xFFEFF1F2);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF006289);
  static const Color primaryContainer = Color(0xFF00BAFF);
  static const Color onSurface = Color(0xFF2C2F30);

  // Accents & Buddy
  static const Color tertiaryContainer = Color(0xFFFEB700);
  static const Color secondaryContainer = Color(0xFFE0F2F1); // Mint
  static const Color errorContainer = Color(0xFFFFCCBC); // Coral
  static const Color lavenderPurple = Color(0xFFE1BEE7);

  // Gradient Constant
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryContainer],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primary,
            surface: surface,
            onSurface: onSurface,
            primary: primary,
            primaryContainer: primaryContainer,
            secondaryContainer: secondaryContainer,
            tertiaryContainer: tertiaryContainer,
            errorContainer: errorContainer,
          ).copyWith(
            surfaceContainerLow: surfaceContainerLow,
            surfaceContainerLowest: surfaceContainerLowest,
          ),

      // Typography
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: AppFonts.displayLarge.copyWith(color: onSurface),
        headlineMedium: AppFonts.headlineMedium.copyWith(color: onSurface),
        bodyLarge: AppFonts.bodyLarge.copyWith(color: onSurface),
        bodyMedium: AppFonts.bodyMedium.copyWith(color: onSurface),
        labelLarge: AppFonts.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
      ),

      // Roundness Principles
      cardTheme: CardThemeData(
        color: surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48), // xl: 3rem
        ),
      ),

      buttonTheme: const ButtonThemeData(shape: StadiumBorder()),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          elevation: 0,
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: tertiaryContainer,
        shape: StadiumBorder(),
        elevation: 8, // Soft ambient shadow
      ),

      dividerTheme: const DividerThemeData(
        color: Colors.transparent, // "No-Line" Rule
      ),
    );
  }

  // Shadow Spec: Blur: 24px, Y-Offset: 8px, Color: on-surface at 6% opacity
  static List<BoxShadow> get ambientShadow => [
    BoxShadow(
      blurRadius: 24,
      offset: const Offset(0, 8),
      color: onSurface.withValues(alpha: 0.06),
    ),
  ];
}
