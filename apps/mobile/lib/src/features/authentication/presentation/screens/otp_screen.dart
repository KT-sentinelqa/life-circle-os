import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen for entering the OTP code.
class OtpScreen extends ConsumerStatefulWidget {
  /// Creates an [OtpScreen].
  const OtpScreen({
    required this.identifier,
    super.key,
  });

  /// The identifier (email or phone) the OTP was sent to.
  final String identifier;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _otpController = TextEditingController();
  Timer? _countdownTimer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() => _secondsRemaining = 60);
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _verify() {
    unawaited(
      ref.read(authProvider.notifier).verifyOtp(
            widget.identifier,
            _otpController.text,
          ),
    );
  }

  void _resend() {
    _startCountdown();
    // In real app, trigger requestOtp again here
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen(
      authProvider,
      (previous, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${next.error}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
    );

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Verify Identity'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter the 6-digit code',
                style: AppTypography.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Sent to ${widget.identifier}',
                style: AppTypography.bodyLarge.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: AppSpacing.xl),
              LcTextField(
                label: '6-digit OTP',
                controller: _otpController,
                keyboardType: TextInputType.number,
                autofocus: true,
              ),
              const SizedBox(height: AppSpacing.md),
              if (_secondsRemaining > 0)
                Text(
                  'Resend code in 0:${_secondsRemaining.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                )
              else
                Column(
                  children: [
                    TextButton(
                      onPressed: _resend,
                      child: const Text('Resend Code'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Get a Voice Call Instead'),
                    ),
                  ],
                ),
              const SizedBox(height: AppSpacing.xl),
              if (authState.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                LcButton(
                  text: 'Verify',
                  onPressed: _verify,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
