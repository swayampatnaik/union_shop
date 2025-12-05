import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/search_page_screen.dart';

void main() {
  testWidgets('SearchPageScreen builds and shows main UI', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPageScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('SEARCH OUR SITE'), findsOneWidget);
  });

  testWidgets('Finds the main search TextField (hint="Search") and SUBMIT button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPageScreen()));
    await tester.pumpAndSettle();

    final searchField = find.byWidgetPredicate((w) {
      return w is TextField && w.decoration?.hintText == 'Search';
    });
    expect(searchField, findsOneWidget);

    expect(find.text('SUBMIT'), findsOneWidget);
  });

  testWidgets('Tapping SUBMIT with text shows SnackBar with the query', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPageScreen()));
    await tester.pumpAndSettle();

    final searchField = find.byWidgetPredicate((w) {
      return w is TextField && w.decoration?.hintText == 'Search';
    }).first;
    await tester.enterText(searchField, 'hello');
    await tester.pumpAndSettle();

    await tester.tap(find.text('SUBMIT'));
    await tester.pumpAndSettle();

    expect(find.text('Search: hello'), findsOneWidget);
  });

  testWidgets('Tapping SUBMIT with empty input shows SnackBar with (empty)', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPageScreen()));
    await tester.pumpAndSettle();

    final searchField = find.byWidgetPredicate((w) {
      return w is TextField && w.decoration?.hintText == 'Search';
    }).first;
    await tester.enterText(searchField, '');
    await tester.pumpAndSettle();

    await tester.tap(find.text('SUBMIT'));
    await tester.pumpAndSettle();

    expect(find.text('Search: (empty)'), findsOneWidget);
  });

  testWidgets('Submitting via keyboard (TextInputAction.search) also shows SnackBar', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPageScreen()));
    await tester.pumpAndSettle();

    final searchField = find.byWidgetPredicate((w) {
      return w is TextField && w.decoration?.hintText == 'Search';
    }).first;

    // Enter text and simulate the "search" action from the keyboard
    await tester.enterText(searchField, 'keyboard');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.text('Search: keyboard'), findsOneWidget);
  });
}