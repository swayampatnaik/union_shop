import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about_screen.dart';

void main() {
  testWidgets('AboutScreen builds without errors', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('AboutScreen shows a title containing "About" (case-insensitive)', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
    await tester.pumpAndSettle();
    expect(find.textContaining(RegExp(r'about', caseSensitive: false)), findsWidgets);
  });

  testWidgets('AboutScreen can be pushed and popped via Navigator', (tester) async {
    final navKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(MaterialApp(
      navigatorKey: navKey,
      home: Builder(
        builder: (ctx) => ElevatedButton(
          onPressed: () => Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => const AboutScreen())),
          child: const Text('Open'),
        ),
      ),
    ));

    // open AboutScreen
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // after push there should be something to pop
    expect(navKey.currentState?.canPop(), isTrue);

    // pop programmatically and ensure we return to home
    navKey.currentState!.pop();
    await tester.pumpAndSettle();
    expect(navKey.currentState?.canPop(), isFalse);
  });
}