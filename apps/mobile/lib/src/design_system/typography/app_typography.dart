import 'package:flutter/material.dart';

/// Standard typography tokens.
class AppTypography {
  /// Creates [AppTypography].
  const AppTypography._();

  /// Medium display text.
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45, 
    fontWeight: FontWeight.bold,
  );
  
  /// Large headline text.
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32, 
    fontWeight: FontWeight.bold,
  );
  
  /// Large body text.
  static const TextStyle bodyLarge = TextStyle(fontSize: 16);
}
