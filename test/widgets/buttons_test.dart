import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/buttons.dart';

void main() {
  group('PurpleButton', () {
    testWidgets('calls onPressed when enabled and tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PurpleButton(
            text: 'PRESS',
            onPressed: () => pressed = true,
          ),
        ),
      ));

      expect(find.text('PRESS'), findsOneWidget);
      await tester.tap(find.text('PRESS'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PurpleButton(
            text: 'NOPE',
            enabled: false,
            onPressed: () => pressed = true,
          ),
        ),
      ));

      expect(find.text('NOPE'), findsOneWidget);
      await tester.tap(find.text('NOPE'));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('honours explicit width and height', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
            child: PurpleButton(
              text: 'SIZE',
              width: 140,
              height: 44,
              onPressed: () {},
            ),
          ),
        ),
      ));

      final size = tester.getSize(find.byType(PurpleButton));
      expect(size.width, equals(140));
      expect(size.height, equals(44));
    });
  });

  group('WhiteButton', () {
    testWidgets('shows text and triggers callback', (tester) async {
      var pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: WhiteButton(
            text: 'SUB',
            onPressed: () => pressed = true,
          ),
        ),
      ));

      expect(find.text('SUB'), findsOneWidget);
      await tester.tap(find.text('SUB'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('respects width and height when provided', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
            child: WhiteButton(
              text: 'BOX',
              width: 120,
              height: 36,
              onPressed: () {},
            ),
          ),
        ),
      ));

      final size = tester.getSize(find.byType(WhiteButton));
      expect(size.width, equals(120));
      expect(size.height, equals(36));
    });
  });
}
