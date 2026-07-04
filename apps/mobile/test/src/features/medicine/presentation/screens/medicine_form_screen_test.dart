import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/screens/medicine_form_screen.dart';

void main() {
  testWidgets(
    'MedicineFormScreen displays Add Medicine when no medicine provided',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: MedicineFormScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Add Medicine'), findsOneWidget);
      expect(find.byType(LcTextField), findsNWidgets(5));
      expect(find.byType(LcButton), findsOneWidget);
      // No delete icon when adding
      expect(find.byIcon(Icons.delete), findsNothing);
    },
  );
}
