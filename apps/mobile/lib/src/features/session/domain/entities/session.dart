import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

@immutable
class SessionIdentity {
  const SessionIdentity({
    required this.sessionId,
    required this.userId,
    required this.familyId,
    required this.deviceId,
    required this.createdAt,
    required this.absoluteExpiry,
    required this.refreshExpiry,
  });

  final String sessionId;
  final String userId;
  final String familyId;
  final String deviceId;
  final DateTime createdAt;
  final DateTime absoluteExpiry; // Max 90 days
  final DateTime refreshExpiry;  // Max 72 hours chain limit
}

enum SessionState {
  anonymous,
  authenticating,
  authenticated,
  refreshing,
  reAttesting,
  suspended,
  revoked,
  expired,
  destroyed,
}

class SessionRuntime {
  SessionRuntime({
    required this.state,
    required this.trustEvidence,
    required this.riskScore,
    required this.lastActivity,
    required this.lastRefresh,
    required this.reauthRequired,
    required this.currentKeyId,
  });

  SessionState state;
  TrustEvidence trustEvidence;
  double riskScore;
  DateTime lastActivity;
  DateTime lastRefresh;
  bool reauthRequired;
  String currentKeyId;

  SessionRuntime copyWith({
    SessionState? state,
    TrustEvidence? trustEvidence,
    double? riskScore,
    DateTime? lastActivity,
    DateTime? lastRefresh,
    bool? reauthRequired,
    String? currentKeyId,
  }) {
    return SessionRuntime(
      state: state ?? this.state,
      trustEvidence: trustEvidence ?? this.trustEvidence,
      riskScore: riskScore ?? this.riskScore,
      lastActivity: lastActivity ?? this.lastActivity,
      lastRefresh: lastRefresh ?? this.lastRefresh,
      reauthRequired: reauthRequired ?? this.reauthRequired,
      currentKeyId: currentKeyId ?? this.currentKeyId,
    );
  }
}
