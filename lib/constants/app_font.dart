import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const String headlineFont = 'PlusJakartaSans';
  static const String bodyFont = 'BeVietnamPro';

  static TextStyle displayLarge = GoogleFonts.plusJakartaSans(
    fontSize: 56, // 3.5rem as per DESIGN.md
    fontWeight: FontWeight.bold,
    letterSpacing: -0.02 * 56,
  );

  static TextStyle headlineMedium = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.bold,
    letterSpacing: -0.02,
  );

  static TextStyle bodyLarge = GoogleFonts.beVietnamPro(fontSize: 16);
  static TextStyle bodyMedium = GoogleFonts.beVietnamPro(fontSize: 14);
}
