// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bisma_certification/main.dart';

void main() {
  testWidgets('Onboarding screen reach the end page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Get Started'), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    expect(find.text('Skip'), findsNothing);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Next'), findsNothing);
  });
}
