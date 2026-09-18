import 'package:flutter/material.dart';

/// Palette shared by the public-facing screens.
class AppColors {
  // REEL flagship dark/aurora palette.
  static const ink = Color(0xFF06070B);
  static const surface = Color(0xFF0A0B13);
  static const surface2 = Color(0xFF11131E);
  static const line = Color(0x1AFFFFFF);
  static const lineSoft = Color(0x0FFFFFFF);
  static const parchment = Color(0xFFF1F3F8);
  static const parchmentDim = Color(0xFF8B93A6);
  static const muted = Color(0xFF687086);
  static const oxblood = Color(0xFF3D7CFF);
  static const oxbloodLt = Color(0xFF8B7BFF);
  static const brass = Color(0xFF6FA3FF);
  static const brassLt = Color(0xFFFF9466);
  static const azure = Color(0xFF3D7CFF);
  static const azureSoft = Color(0xFF6FA3FF);
  static const smoke = Color(0xFF8B93A6);
  static const mist = Color(0xFFF1F3F8);
  static const indigo = Color(0xFF8B7BFF);
  static const coral = Color(0xFFFF9466);
  static const glass = Color(0x0BFFFFFF);
  static const glassStrong = Color(0x14FFFFFF);
  static const spectrum = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [azure, indigo, coral],
    stops: [0, .55, 1],
  );
}
