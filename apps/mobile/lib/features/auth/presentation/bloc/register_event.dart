/// LifeCircle OS — RegisterBloc events.
///
/// Events represent user interactions on the registration screen.
/// Governed by: docs/golden-path/mobile-feature.md | LC-S1-009
library;

import 'package:equatable/equatable.dart';

import '../../../../domain/auth/user_role.dart';

/// Base class for all registration events.
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

/// Emitted when the email field value changes.
final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);
  final String email;
  @override List<Object?> get props => [email];
}

/// Emitted when the password field value changes.
final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);
  final String password;
  @override List<Object?> get props => [password];
}

/// Emitted when the full name field value changes.
final class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);
  final String name;
  @override List<Object?> get props => [name];
}

/// Emitted when the role selector value changes.
final class RegisterRoleChanged extends RegisterEvent {
  const RegisterRoleChanged(this.role);
  final UserRole role;
  @override List<Object?> get props => [role];
}

/// Emitted when the user taps the Submit / Create Account button.
final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
  @override List<Object?> get props => [];
}
