import 'package:lifecircle_mobile/src/features/session/domain/entities/session_binding.dart';
import 'package:lifecircle_mobile/src/features/device_trust/application/risk_engine.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

class SessionValidator {
  const SessionValidator({
    required this.riskEngine,
  });

  final RiskEngine riskEngine;

  /// Validates if the active session binding matches the current hardware reality.
  Future<bool> validateBinding({
    required SessionBinding binding,
    required String sessionId,
    required String deviceId,
  }) async {
    // Re-evaluate current trust evidence (simulates real-time Attestation check)
    final currentEvidence = await riskEngine.evaluateTrust();

    // Reconstruct the raw components
    final currentAttestationId = currentEvidence.attestationStatus.name;
    
    // We bind against the specific cryptographic identifier stored during auth
    final expectedBinding = SessionBinding(
      deviceId: deviceId,
      attestationId: currentAttestationId,
      keyIdentifier: binding.keyIdentifier,
      trustEvidenceId: currentEvidence.deviceId, // Using deviceId as proxy
      bindingHash: binding.bindingHash, // Will be ignored in reconstruction validation
    );

    // Validate using the SessionBinding's native SHA-256 method
    return expectedBinding.isValid(sessionId);
  }
}
