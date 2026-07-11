import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/session/domain/entities/session.dart';
import 'package:lifecircle_mobile/src/features/session/domain/entities/session_audit.dart';
import 'package:lifecircle_mobile/src/features/authorization/application/policy_engine.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

enum SessionTrigger {
  startLogin,
  loginSuccess,
  loginFailed,
  tokenExpiry,
  refreshSuccess,
  refreshFailedPolicy,
  refreshTokenReuse,
  idleTimeout,
  appReopened,
  highRiskAction,
  mfaSuccess,
  mfaFailed,
  bindingMutated,
  userLogout,
  absoluteTimeout,
}

class SessionStateMachine {
  const SessionStateMachine(this._policyEngine);

  final PolicyEngine _policyEngine;

  /// Pure function mapping (Current State + Trigger) -> (Next State)
  SessionState _getNextState(SessionState current, SessionTrigger trigger) {
    switch (current) {
      case SessionState.anonymous:
        if (trigger == SessionTrigger.startLogin) return SessionState.authenticating;
        break;
      case SessionState.authenticating:
        if (trigger == SessionTrigger.loginSuccess) return SessionState.authenticated;
        if (trigger == SessionTrigger.loginFailed) return SessionState.anonymous;
        break;
      case SessionState.authenticated:
        if (trigger == SessionTrigger.tokenExpiry) return SessionState.refreshing;
        if (trigger == SessionTrigger.highRiskAction) return SessionState.reAttesting;
        if (trigger == SessionTrigger.bindingMutated) return SessionState.suspended;
        if (trigger == SessionTrigger.idleTimeout) return SessionState.suspended;
        if (trigger == SessionTrigger.absoluteTimeout) return SessionState.expired;
        if (trigger == SessionTrigger.userLogout) return SessionState.destroyed;
        break;
      case SessionState.refreshing:
        if (trigger == SessionTrigger.refreshSuccess) return SessionState.authenticated;
        if (trigger == SessionTrigger.refreshFailedPolicy) return SessionState.suspended;
        if (trigger == SessionTrigger.refreshTokenReuse) return SessionState.revoked;
        break;
      case SessionState.reAttesting:
        if (trigger == SessionTrigger.mfaSuccess) return SessionState.authenticated;
        if (trigger == SessionTrigger.mfaFailed) return SessionState.suspended;
        break;
      case SessionState.suspended:
        if (trigger == SessionTrigger.appReopened) return SessionState.authenticating;
        break;
      case SessionState.revoked:
      case SessionState.expired:
      case SessionState.destroyed:
        if (trigger == SessionTrigger.userLogout) return SessionState.destroyed;
        break;
    }
    // Default fallback: remain in current state if transition invalid
    return current;
  }

  /// Evaluates a trigger and mutates the SessionRuntime safely, returning the Audit Event.
  SessionTransitionResult transition({
    required SessionRuntime runtime,
    required SessionIdentity identity,
    required SessionTrigger trigger,
    required String reason,
    required String actor,
    required TrustEvidence currentEvidence,
  }) {
    final oldState = runtime.state;
    final newState = _getNextState(oldState, trigger);

    if (oldState == newState) {
      return SessionTransitionResult(runtime: runtime, audit: null);
    }

    // Guard: Refresh requests must pass PolicyEngine and Trust limits
    if (trigger == SessionTrigger.refreshSuccess) {
      if (!currentEvidence.isTrusted) {
        // Policy rejection forces suspension
        return transition(
          runtime: runtime,
          identity: identity,
          trigger: SessionTrigger.refreshFailedPolicy,
          reason: 'Trust Evidence invalidated during refresh',
          actor: 'System',
          currentEvidence: currentEvidence,
        );
      }
    }

    final auditId = const Uuid().v4();
    final updatedRuntime = runtime.copyWith(
      state: newState,
      trustEvidence: currentEvidence,
      lastActivity: DateTime.now().toUtc(),
    );

    final transitionEvent = SessionTransition(
      fromState: oldState,
      toState: newState,
      reason: reason,
      actor: actor,
      timestamp: DateTime.now().toUtc(),
      policyVersion: currentEvidence.policyVersion,
      auditId: auditId,
    );

    final auditEvent = SessionAuditEvent(
      auditId: auditId,
      sessionId: identity.sessionId,
      transition: trigger.name,
      oldState: oldState.name,
      newState: newState.name,
      reason: reason,
      deviceId: identity.deviceId,
      trustLevel: currentEvidence.deviceTrustLevel,
      riskScore: currentEvidence.riskScore,
      ipHash: 'TODO_INJECT_IP_HASH',
      timestamp: transitionEvent.timestamp,
      policyVersion: transitionEvent.policyVersion,
    );

    return SessionTransitionResult(
      runtime: updatedRuntime,
      audit: auditEvent,
      transitionEvent: transitionEvent,
    );
  }
}

class SessionTransitionResult {
  const SessionTransitionResult({
    required this.runtime,
    required this.audit,
    this.transitionEvent,
  });

  final SessionRuntime runtime;
  final SessionAuditEvent? audit;
  final SessionTransition? transitionEvent;
}
