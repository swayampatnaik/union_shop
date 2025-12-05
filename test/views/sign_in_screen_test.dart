import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/sign_in_screen.dart';

void main() {
  testWidgets('SignInScreen shows title and email TextField', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    await tester.pumpAndSettle();

    // Only test text and text field (skip any image checks)
    expect(find.text('Sign in'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == 'Email address',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Continue does nothing when email is empty', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // No SnackBar with "Continue with:" should appear
    expect(find.textContaining('Continue with:'), findsNothing);
  });

  testWidgets('Entering email enables Continue and shows SnackBar with email', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    await tester.pumpAndSettle();

    final emailField = find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Email address',
    );
    expect(emailField, findsOneWidget);

    await tester.enterText(emailField, 'test@example.com');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Continue with: test@example.com'), findsOneWidget);
  });
}