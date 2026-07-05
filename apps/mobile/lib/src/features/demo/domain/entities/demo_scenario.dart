/// Represents the type of demographic scenario to generate for the demo.
enum DemoScenario {
  /// A standard 4-member Indian family with varying adherence levels.
  standardIndianFamily,

  /// Focuses heavily on an elder parent requiring complex care.
  elderCareFamily,

  /// Focuses on managing chronic conditions (diabetes, BP).
  chronicCareFamily,

  /// A single parent managing their own and their child's health.
  singleParentFamily,

  /// A large joint family with multiple caregivers and parents.
  jointFamily,
}
