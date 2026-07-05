/// Represents the type of demographic scenario to generate for the demo.
enum DemoScenario {
  /// 95-100 health score, no escalations, green adherence
  healthyFamily,

  /// Missed medicines, parent requires attention, yellow health score
  careNeeded,

  /// Multiple missed doses, emergency escalation, red health score
  criticalSituation,

  /// Single elder, remote caregiver, medication dependency
  livingAloneParent,
}
