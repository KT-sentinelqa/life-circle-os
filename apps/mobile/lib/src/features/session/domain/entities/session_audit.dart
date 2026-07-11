import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/session/domain/entities/session.dart';

@immutable
class SessionTransition {
  const SessionTransition({
    required this.fromState,
    required this.toState,
    required this.reason,
    required this.actor,
    required this.timestamp,
    required this.policyVersion,
    required this.auditId,
  });

  final SessionState fromState;
  final SessionState toState;
  final String reason;
  final String actor; // e.g., 'system', 'user', 'backend'
  final DateTime timestamp;
  final String policyVersion;
  final String auditId;
}

@immutable
class SessionAuditEvent {
  const SessionAuditEvent({
    required this.auditId,
    required this.sessionId,
    required this.transition,
    required this.oldState,
    required this.newState,
    required this.reason,
    required this.deviceId,
    required this.trustLevel,
    required this.riskScore,
    required this.ipHash,
    required this.timestamp,
    required this.policyVersion,
  });

  final String auditId;
  final String sessionId;
  final String transition;
  final String oldState;
  final String newState;
  final String reason;
  final String deviceId;
  final String trustLevel;
  final double riskScore;
  final String ipHash; // Masked for privacy
  final DateTime timestamp;
  final String policyVersion;
}
