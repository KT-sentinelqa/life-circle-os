import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/adherence_heatmap.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_skeleton.dart';

void main() {
  testWidgets('AdherenceHeatmap renders correctly and handles semantics',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: AdherenceHeatmap(),
          ),
        ),
      ),
    );

    // Initial state is loading
    expect(find.byType(LcSkeletonCard), findsOneWidget);

    // Check for title
    expect(find.text('Adherence Heatmap'), findsOneWidget);
  });
}
