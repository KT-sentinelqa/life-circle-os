import 'package:flutter/material.dart';

/// LifeCircle OS — Color Token System
///
/// The LifeCircle palette communicates: calm, trust, family, reliability.
///
/// RULES:
/// - Never use raw hex values in widgets. Always reference LcColors tokens.
/// - Color meaning must never be conveyed by color alone (pair with icon/label).
/// - All color pairs must meet WCAG AA contrast ratio (4.5:1 minimum).
abstract final class LcColors {
  LcColors._();

  // ──────────────────────────────────────────────────────────────
  // BRAND — Deep Teal (calm, trusted, reliable)
  // ──────────────────────────────────────────────────────────────
  static const Color brand900 = Color(0xFF0A3D3D);
  static const Color brand800 = Color(0xFF0D5252);
  static const Color brand700 = Color(0xFF0F6B6B); // Primary action
  static const Color brand600 = Color(0xFF138080);
  static const Color brand500 = Color(0xFF1A9595);
  static const Color brand400 = Color(0xFF3AAFAF);
  static const Color brand300 = Color(0xFF6ECECE);
  static const Color brand200 = Color(0xFFA8E8E8);
  static const Color brand100 = Color(0xFFD4F4F4);
  static const Color brand50  = Color(0xFFEEFBFB);

  // ──────────────────────────────────────────────────────────────
  // ACCENT — Warm Amber (warmth, family, connection)
  // ──────────────────────────────────────────────────────────────
  static const Color accent700 = Color(0xFFD4620A);
  static const Color accent600 = Color(0xFFE8730D);
  static const Color accent500 = Color(0xFFF4A261); // Primary accent
  static const Color accent400 = Color(0xFFF7BA8A);
  static const Color accent100 = Color(0xFFFEF3E9);

  // ──────────────────────────────────────────────────────────────
  // SEMANTIC — Functional communication
  // ──────────────────────────────────────────────────────────────
  static const Color success700 = Color(0xFF1A7A4A);
  static const Color success500 = Color(0xFF27AE60);
  static const Color success100 = Color(0xFFD5F5E3);

  static const Color warning700 = Color(0xFFB8860B);
  static const Color warning500 = Color(0xFFF39C12);
  static const Color warning100 = Color(0xFFFEF9E7);

  static const Color error700   = Color(0xFFC0392B);
  static const Color error500   = Color(0xFFE74C3C);
  static const Color error100   = Color(0xFFFDEDEC);

  static const Color info700    = Color(0xFF1A5276);
  static const Color info500    = Color(0xFF2980B9);
  static const Color info100    = Color(0xFFD6EAF8);

  // ──────────────────────────────────────────────────────────────
  // NEUTRAL — Surfaces, backgrounds, text
  // ──────────────────────────────────────────────────────────────
  static const Color neutral950 = Color(0xFF0D0D0D);
  static const Color neutral900 = Color(0xFF1A1A1A);
  static const Color neutral800 = Color(0xFF2C2C2C);
  static const Color neutral700 = Color(0xFF3D3D3D);
  static const Color neutral600 = Color(0xFF5A5A5A);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral400 = Color(0xFF9E9E9E);
  static const Color neutral300 = Color(0xFFBDBDBD);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral100 = Color(0xFFF2F2F2);
  static const Color neutral50  = Color(0xFFF8F9FA);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ──────────────────────────────────────────────────────────────
  // OFFLINE & SYNC — The UX Constitution requires these be visible
  // ──────────────────────────────────────────────────────────────
  static const Color syncPending  = Color(0xFFF39C12); // Warning amber
  static const Color syncComplete = Color(0xFF27AE60); // Success green
  static const Color syncFailed   = Color(0xFFE74C3C); // Error red
  static const Color offline      = Color(0xFF9E9E9E); // Muted neutral

  // ──────────────────────────────────────────────────────────────
  // OVERLAY
  // ──────────────────────────────────────────────────────────────
  static const Color scrim        = Color(0x99000000); // 60% black
  static const Color shimmerBase  = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}
