import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_domain_providers.dart';

void main() {
  test('domain providers return correct types', () {
    final container = ProviderContainer();

    final calculator = container.read(adherenceCalculatorProvider);
    expect(calculator, isNotNull);

    final analyzer = container.read(missedDoseAnalyzerProvider);
    expect(analyzer, isNotNull);

    final engine = container.read(streakEngineProvider);
    expect(engine, isNotNull);

    final insights = container.read(weeklyInsightsServiceProvider);
    expect(insights, isNotNull);

    container.dispose();
  });
}
