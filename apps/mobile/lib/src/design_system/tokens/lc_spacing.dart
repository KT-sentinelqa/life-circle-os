/// LifeCircle OS — Spacing Token System
///
/// All spacing values derive from a base-4 grid.
/// This ensures visual rhythm and alignment consistency across all screens.
///
/// RULES:
/// - Never use raw pixel values for margin/padding in widgets.
/// - Always reference LcSpacing tokens.
/// - Prefer multiples of the grid unit (4dp) for any custom value.
abstract final class LcSpacing {
  LcSpacing._();

  /// 4dp — grid unit
  static const double xs2 = 4;

  /// 8dp — tight grouping within elements
  static const double xs  = 8;

  /// 12dp — inner element padding
  static const double sm  = 12;

  /// 16dp — standard component padding (most common)
  static const double md  = 16;

  /// 20dp — generous component padding
  static const double lg  = 20;

  /// 24dp — section-level separation
  static const double xl  = 24;

  /// 32dp — card/section internal padding
  static const double xl2 = 32;

  /// 40dp — large section gaps
  static const double xl3 = 40;

  /// 48dp — minimum touch target height
  static const double touchTarget = 48;

  /// 56dp — FAB / prominent action height
  static const double actionHeight = 56;

  /// 64dp — hero section padding
  static const double xl4 = 64;

  /// 80dp — display-level gap
  static const double xl5 = 80;

  // ──────────────────────────────────────────────────────────────
  // SCREEN MARGINS (responsive)
  // ──────────────────────────────────────────────────────────────

  /// Horizontal screen margin for phones
  static const double screenMarginPhone  = 16;

  /// Horizontal screen margin for tablets
  static const double screenMarginTablet = 32;

  /// Maximum content width (prevents over-wide layouts on large screens)
  static const double maxContentWidth = 600;

  // ──────────────────────────────────────────────────────────────
  // GRID
  // ──────────────────────────────────────────────────────────────

  /// Number of grid columns on phone
  static const int gridColumnsPhone  = 4;

  /// Number of grid columns on tablet
  static const int gridColumnsTablet = 12;

  /// Standard gutter between grid columns
  static const double gridGutter = 16;
}
