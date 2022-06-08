import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Should display the newly added item in the list',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final addFinder = find.byKey(const ValueKey('button.add'));
      final titleFinder = find.byKey(const ValueKey('input.title'));
      final saveFinder = find.byKey(const ValueKey('button.save'));

      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      await tester.tap(titleFinder);
      await tester.enterText(titleFinder, 'Buy groceries');
      await tester.pumpAndSettle();

      await tester.tap(saveFinder);
      await tester.pumpAndSettle();

      expect(find.text('Buy groceries'), findsOneWidget);
    },
  );
}