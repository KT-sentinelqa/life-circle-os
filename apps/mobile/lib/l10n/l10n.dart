import 'package:flutter/widgets.dart';
import 'package:mobile/l10n/gen/app_localizations.dart';

export 'package:mobile/l10n/gen/app_localizations.dart';

/// Extension on [BuildContext] to simplify access to localized strings.
extension AppLocalizationsX on BuildContext {
  /// Returns the [AppLocalizations] instance for the current context.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
