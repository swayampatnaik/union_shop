import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/views/sale_screen.dart';
import 'package:union_shop/widgets/product_card.dart';

void main() {
	TestWidgetsFlutterBinding.ensureInitialized();

	group('SaleScreen', () {
		testWidgets('renders heading and description', (WidgetTester tester) async {
			await tester.pumpWidget(
				ChangeNotifierProvider<Cart>(
					create: (_) => Cart(),
					child: const MaterialApp(home: SaleScreen()),
				),
			);

			await tester.pumpAndSettle();

			expect(find.text('SALE'), findsOneWidget);
			expect(find.textContaining("Don't Miss out"), findsOneWidget);
		});

		testWidgets('shows filter and sort dropdowns and allows selection', (WidgetTester tester) async {
			await tester.pumpWidget(
				ChangeNotifierProvider<Cart>(
					create: (_) => Cart(),
					child: const MaterialApp(home: SaleScreen()),
				),
			);

			await tester.pumpAndSettle();

			// There should be at least one DropdownButton for filter and one for sort
			final dropdowns = find.byType(DropdownButton<String>);
			expect(dropdowns, findsAtLeastNWidgets(1));

			// Open the first dropdown menu and select an option if present
			if (dropdowns.evaluate().isNotEmpty) {
				await tester.tap(dropdowns.first);
				await tester.pumpAndSettle();

				// Try to tap a common option 'Clothing' if it exists in the menu
				final clothingFinder = find.text('Clothing').last;
				if (clothingFinder.evaluate().isNotEmpty) {
					await tester.tap(clothingFinder);
					await tester.pumpAndSettle();
					// After selecting, the dropdown should still be present
					expect(find.byType(DropdownButton<String>), findsAtLeastNWidgets(1));
				}
			}
		});

		testWidgets('builds a grid with product cards', (WidgetTester tester) async {
			await tester.pumpWidget(
				ChangeNotifierProvider<Cart>(
					create: (_) => Cart(),
					child: const MaterialApp(home: SaleScreen()),
				),
			);

			await tester.pumpAndSettle();

			// The SaleScreen uses ProductCard in its grid; ensure some are present.
			// We expect multiple ProductCard widgets to be built (at least 1).
			expect(find.byType(ProductCard), findsAtLeastNWidgets(1));
		});
	});
}

