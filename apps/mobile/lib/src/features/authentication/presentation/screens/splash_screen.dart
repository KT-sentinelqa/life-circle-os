import 'package:flutter/material.dart';
import 'package:mobile/src/design_system/colors/app_colors.dart';
import 'package:mobile/src/design_system/typography/app_typography.dart';
import 'package:mobile/src/design_system/widgets/lc_scaffold.dart';

/// Initial loading screen shown while checking session state.
class SplashScreen extends StatelessWidget {
  /// Creates a [SplashScreen].
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LcScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'LifeCircle OS',
              style: AppTypography.displayMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
