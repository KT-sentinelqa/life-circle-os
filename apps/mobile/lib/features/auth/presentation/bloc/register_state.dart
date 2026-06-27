/// LifeCircle OS — RegisterBloc states.
///
/// States represent the current snapshot of the registration form.
/// Governed by: docs/golden-path/mobile-feature.md | LC-S1-009
library;

import 'package:equatable/equatable.dart';

import '../../../../domain/auth/user_role.dart';

/// Password strength classification.
enum PasswordStrength { empty, weak, fair, strong }

PasswordStrength evaluatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.empty;
  int score = 0;
  if (password.length >= 12)                              score++;
  if (RegExp(r'[A-Z]').hasMatch(password))               score++;
  if (RegExp(r'[0-9]').hasMatch(password))               score++;
  if (RegExp(r'[!@#\$%\^&\*\(\)_\+]').hasMatch(password)) score++;
  return switch (score) {
    4     => PasswordStrength.strong,
    >= 2  => PasswordStrength.fair,
    _     => PasswordStrength.weak,
  };
}

/// The canonical state of the registration form.
final class RegisterState extends Equatable {
  const RegisterState({
    this.email            = '',
    this.password         = '',
    this.fullName         = '',
    this.role             = UserRole.guardian,
    this.isSubmitting     = false,
    this.isSuccess        = false,
    this.errorMessage,
    this.passwordStrength = PasswordStrength.empty,
  });

  final String          email;
  final String          password;
  final String          fullName;
  final UserRole        role;
  final bool            isSubmitting;
  final bool            isSuccess;
  final String?         errorMessage;
  final PasswordStrength passwordStrength;

  bool get isFormValid =>
      email.contains('@') &&
      password.length >= 12 &&
      fullName.trim().length >= 2;

  RegisterState copyWith({
    String?          email,
    String?          password,
    String?          fullName,
    UserRole?        role,
    bool?            isSubmitting,
    bool?            isSuccess,
    String?          errorMessage,
    bool             clearError = false,
    PasswordStrength? passwordStrength,
  }) =>
      RegisterState(
        email:            email            ?? this.email,
        password:         password         ?? this.password,
        fullName:         fullName         ?? this.fullName,
        role:             role             ?? this.role,
        isSubmitting:     isSubmitting     ?? this.isSubmitting,
        isSuccess:        isSuccess        ?? this.isSuccess,
        errorMessage:     clearError ? null : (errorMessage ?? this.errorMessage),
        passwordStrength: passwordStrength ?? this.passwordStrength,
      );

  @override
  List<Object?> get props => [
        email, password, fullName, role,
        isSubmitting, isSuccess, errorMessage, passwordStrength,
      ];
}
