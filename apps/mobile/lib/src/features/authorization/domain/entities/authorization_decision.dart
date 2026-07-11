enum AuthorizationDecisionStatus {
  allow,
  allowWithAudit,
  allowTemporarily,
  deny,
  denyDeviceUntrusted,
  denySessionExpired,
  denyPermission,
  denyBreakGlassRequired,
}

class AuthorizationDecision {
  const AuthorizationDecision({
    required this.status,
    this.reason,
  });

  final AuthorizationDecisionStatus status;
  final String? reason;

  bool get isGranted => 
      status == AuthorizationDecisionStatus.allow ||
      status == AuthorizationDecisionStatus.allowWithAudit ||
      status == AuthorizationDecisionStatus.allowTemporarily;

  @override
  String toString() => 'AuthorizationDecision($status, reason: $reason)';
}
