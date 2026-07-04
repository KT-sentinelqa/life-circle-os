import 'package:flutter/material.dart';

/// Standardized border radius constants for LifeCircle OS.
class AppRadius {
  const AppRadius._();

  /// Small border radius (4.0)
  static const BorderRadius sm = BorderRadius.all(Radius.circular(4));
  
  /// Medium border radius (8.0) - Standard for cards and buttons
  static const BorderRadius md = BorderRadius.all(Radius.circular(8));
  
  /// Large border radius (16.0) - Standard for dialogs or large surfaces
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  
  /// Extra large border radius (24.0)
  static const BorderRadius xl = BorderRadius.all(Radius.circular(24));

  /// Fully rounded border radius
  static const BorderRadius pill = BorderRadius.all(Radius.circular(9999));
}
