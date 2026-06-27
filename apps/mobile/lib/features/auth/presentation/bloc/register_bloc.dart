/// LifeCircle OS — RegisterBloc.
///
/// Orchestrates the registration form state:
///   - Validates fields on each change
///   - On submit: calls the registration API, enqueues outbox entry on success
///   - Exposes password strength for the strength indicator widget
///
/// Governed by: docs/golden-path/mobile-feature.md | LC-S1-009
library;

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/local/auth_local_datasource.dart';
import '../../../../data/local/auth_local_schema.dart';
import '../../../../data/models/user_local_model.dart';
import '../../../sync/data/local/outbox_datasource.dart';
import '../../../sync/data/local/outbox_entry.dart';
import 'register_event.dart';
import 'register_state.dart';

// ignore: avoid_print

/// BLoC for the registration flow.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required Dio httpClient,
    required AuthLocalDatasource localDatasource,
    required OutboxDatasource outboxDatasource,
    required String apiBaseUrl,
  })  : _http = httpClient,
        _localDs = localDatasource,
        _outbox = outboxDatasource,
        _apiBaseUrl = apiBaseUrl,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterRoleChanged>(_onRoleChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final Dio _http;
  final AuthLocalDatasource _localDs;
  final OutboxDatasource _outbox;
  final String _apiBaseUrl;

  // ── Event Handlers ─────────────────────────────────────────────────────────

  void _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email, clearError: true));
  }

  void _onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      password: event.password,
      passwordStrength: evaluatePasswordStrength(event.password),
      clearError: true,
    ));
  }

  void _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(fullName: event.name, clearError: true));
  }

  void _onRoleChanged(RegisterRoleChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(role: event.role));
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(state.copyWith(errorMessage: 'Please fill in all fields correctly.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final response = await _http.post<Map<String, dynamic>>(
        '$_apiBaseUrl/api/v1/auth/register',
        data: {
          'email':     state.email,
          'password':  state.password,
          'full_name': state.fullName,
          'role':      state.role.name,
        },
        options: Options(
          headers: {'X-API-Version': '1.0.0'},
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

      final data = (response.data?['data'] as Map<String, dynamic>?) ?? {};
      final userId = data['user_id'] as String? ?? '';
      final token  = data['token']   as String? ?? '';

      // Persist user locally
      await _localDs.saveUser(UserLocalModel(
        id:        userId,
        email:     state.email,
        fullName:  state.fullName,
        role:      state.role.name,
        jwtToken:  token,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));

      // Enqueue outbox entry for offline sync confirmation
      await _outbox.enqueue(OutboxEntry(
        id:             userId,
        eventType:      'user.registered',
        payload:        '{"user_id":"$userId","email":"${state.email}","role":"${state.role.name}"}',
        idempotencyKey: 'register-$userId',
        createdAt:      DateTime.now().millisecondsSinceEpoch,
        status:         kStatusSynced, // Already confirmed by server
      ));

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final body = e.response?.data as Map<String, dynamic>?;
      final errorCode = (body?['error'] as Map<String, dynamic>?)?['code'] as String?;

      final message = switch (errorCode) {
        'EMAIL_ALREADY_REGISTERED' => 'This email is already registered.',
        'VALIDATION_FAILED'        => 'Please check your password requirements.',
        'RATE_LIMIT_EXCEEDED'      => 'Too many attempts. Please wait 60 seconds.',
        _                          => statusCode != null
            ? 'Registration failed (error $statusCode). Please try again.'
            : 'Network error. Check your connection and try again.',
      };

      emit(state.copyWith(isSubmitting: false, errorMessage: message));
    } catch (_) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      ));
    }
  }
}
