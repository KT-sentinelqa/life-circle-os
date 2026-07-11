/// App Routes — Centralised Route Constants
///
/// All route paths are defined here as constants.
/// No route string is ever hardcoded in a widget.
///
/// Feature modules reference these constants when pushing routes.
abstract final class AppRoutes {
  AppRoutes._();

  // ── Shell routes ────────────────────────────────────────────
  static const String home     = '/home';
  static const String timeline = '/timeline';
  static const String planning = '/planning';
  static const String family   = '/family';
  static const String more     = '/more';

  // ── Feature routes (registered by their domain module) ──────
  static const String medicines = '/medicines';
  static const String finance   = '/finance';
  static const String documents = '/documents';
  static const String vehicles  = '/vehicles';
  static const String trust     = '/trust';

  // ── Family sub-routes ───────────────────────────────────────
  static const String familyMember = '/family/member/:memberId';

  // ── Auth routes ─────────────────────────────────────────────
  static const String splash     = '/splash';
  static const String onboarding = '/onboarding';
  static const String signIn     = '/sign-in';

  // ── Settings ─────────────────────────────────────────────────
  static const String settings = '/settings';
  static const String profile  = '/profile';
}
