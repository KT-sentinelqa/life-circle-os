import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_empty_state.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_skeleton.dart';

void main() {
  group('Shared Widgets Golden Tests', () {
    testWidgets('LcEmptyState golden test', (WidgetTester tester) async {
      final emptyState = LcEmptyState(
        icon: Icons.family_restroom,
        title: 'Build your care circle',
        subtitle:
            'Invite parents, grandparents,\nor caregivers to get started.',
        ctaText: 'Add Family Member',
        onCtaPressed: () {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: emptyState,
          ),
        ),
      );

      await expectLater(
        find.byType(LcEmptyState),
        matchesGoldenFile('goldens/lc_empty_state.png'),
      );
    });

    testWidgets('LcSkeletonListTile golden test', (WidgetTester tester) async {
      const skeleton = LcSkeletonListTile();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: skeleton,
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(LcSkeletonListTile),
        matchesGoldenFile('goldens/lc_skeleton_list_tile.png'),
      );
    });
  });
}
