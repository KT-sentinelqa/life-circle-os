import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/src/design_system/spacing/app_spacing.dart';
import 'package:mobile/src/design_system/typography/app_typography.dart';
import 'package:mobile/src/design_system/widgets/lc_button.dart';
import 'package:mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen for logging in or registering a new account.
class AuthScreen extends ConsumerStatefulWidget {
  /// Creates an [AuthScreen].
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_isLogin) {
      unawaited(
        ref.read(authProvider.notifier).login(
              _emailController.text,
              _passwordController.text,
            ),
      );
    } else {
      unawaited(
        ref.read(authProvider.notifier).register(
              _nameController.text,
              _emailController.text,
              _passwordController.text,
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return LcScaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to LifeCircle',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (!_isLogin) ...[
              LcTextField(
                label: 'Full Name',
                controller: _nameController,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            LcTextField(
              label: 'Email',
              controller: _emailController,
            ),
            const SizedBox(height: AppSpacing.md),
            LcTextField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (authState.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              LcButton(
                text: _isLogin ? 'Login' : 'Create Account',
                onPressed: _submit,
              ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                _isLogin
                    ? 'Need an account? Register'
                    : 'Already have an account? Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
