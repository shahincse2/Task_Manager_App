// import 'package:flutter/material.dart';
//
// class AppColors {
//   static const Color primary = Color(0xFF4CAF50);       // Green
//   static const Color secondary = Color(0xFFFF9800);     // Orange
//   static const Color background = Color(0xFFFFFFFF);    // White
//   static const Color textPrimary = Color(0xFF000000);   // Black
//   static Color splashBackgroundColor = Color(0xff3D692D).withValues(alpha: 0.26);   // splashBackgroundColor
//
//
// }
//
//

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  //static const Color primary = Color(0xFF4CAF50); // Green
  static const Color primaryDark = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFFA5D6A7);
  static const Color welcomeTitle = Color(0xff2D6936);


  // Background Colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color screenBackground = Color(0xFFD9D9D9);
  static const Color cardBackground = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // Black
  //static const Color textSecondary = Color(0xFF4F4F4F);
  static const Color textLight = Color(0xFFFFFFFF);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF2D6936);
  static const Color buttonText = Color(0xFFFFFFFF);

  // Border & Divider
  //static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFBDBDBD);

  // Status Colors
  //static const Color success = Color(0xFF4CAF50);
  //static const Color error = Color(0xFFF44336);
  //static const Color warning = Color(0xFFFFC107);
  //static const Color info = Colors.blue;

  // Splash / Overlay
  // static Color splashBackgroundColor = const Color(
  //   0xFF3D692D,
  // ).withValues(alpha: 0.26);
  // AppColors ক্লাসের ভেতরে
  static const Color splashBackgroundColor = Color(0xFF3D692D);

  // Gradient (optional)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
//---------------------------------------------------------------------------------------------------------
  static const primary = Color(0xff397899);
  static const secondary = Color(0xff20333D);

  static const white = Colors.white;

  static const border = Colors.white24;

  static const disableText = Colors.white70;
  static const activeText = Colors.white;

  static const glass = Color(0x26FFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Colors.blue;
}