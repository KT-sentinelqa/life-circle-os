import 'package:lifecircle_mobile/src/sdk/v1/domains/family_sdk.dart';
import 'package:lifecircle_mobile/src/sdk/v1/domains/timeline_sdk.dart';
import 'package:lifecircle_mobile/src/sdk/v1/domains/preferences_sdk.dart';

/// The absolute entry point for all LifeCircle OS business operations.
/// UI Clients MUST NOT bypass this class to reach internal application services or repositories.
abstract class LifeCircleSDK {
  FamilySDK get family;
  TimelineSDK get timeline;
  PreferencesSDK get preferences;
}
