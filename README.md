# Union Shop

A simple Flutter e-commerce demo app that supports browsing products and managing a shopping cart. The app uses Provider for state management and a ChangeNotifier-based Cart model to track items, quantities and totals.

## Features
- Add products to cart with quantity
- Update quantity or remove items from cart
- Responsive cart screen (mobile and desktop/tablet layouts)
- Order note field on cart screen
- Real-time updates using Provider / ChangeNotifier

## Prerequisites
- Flutter SDK (stable)
- Dart
- Android/iOS toolchain (emulator or device)
- (Optional) VS Code or Android Studio

## Quick setup

1. Open a terminal and clone/open the project folder:
   - cd c:\Users\swaya\Year2\ProgrammingLanguages\union_shop

2. Install dependencies:
   - flutter pub get

3. Run the app:
   - flutter run

## Provider setup
Ensure the Cart provider is registered at the app root so all screens can access it. Example main.dart snippet:

```dart
// lib/main.dart (example)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/app.dart'; // replace with your root widget

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => Cart(),
      child: const MyApp(),
    ),
  );
}
```

## How the cart works (usage)
- On a product page, call Cart.addItem(...) with productId, title, price and quantity.
- CartScreen listens to the Cart provider (Consumer/Provider.of) and updates automatically.
- Use Cart.updateItemQuantity(productId, newQuantity) or Cart.removeItem(productId) to modify contents.
- The cart model exposes:
  - items (Map<String, CartItem>)
  - totalQuantity
  - totalAmount
  - clear()

## File organization (important files)
- lib/models/cart.dart — CartItem and Cart ChangeNotifier
- lib/views/product_page.dart — UI that adds product(s) to cart
- lib/views/cart_screen.dart — responsive cart UI
- lib/widgets/* — shared widgets (buttons, etc.)
- lib/views/* — header/footer and styles

## Responsive behavior
- Mobile: cart shows Product and Total columns; quantity is shown under the product name.
- Desktop/tablet: cart shows Product / Price / Quantity / Total columns, with controls to increase/decrease.

## Notes & tips
- Do a full app restart (not just hot reload) after wrapping runApp with providers.
- Use Provider.of<Cart>(context, listen: false) when performing actions (add/remove) to avoid unnecessary rebuilds.
- Adjust layout breakpoints (e.g. 600px) in `cart_screen.dart` if you need different responsiveness.

## Contributing
Make a branch, implement changes, and submit a PR. Keep UI and state logic separate where possible.

## License
This project contains original educational/demo code. Add a license file if you plan to publish.

```// filepath: c:\Users\swaya\Year2\ProgrammingLanguages\union_shop\README.md

# Union Shop

A simple Flutter e-commerce demo app that supports browsing products and managing a shopping cart. The app uses Provider for state management and a ChangeNotifier-based Cart model to track items, quantities and totals.

## Features
- Add products to cart with quantity
- Update quantity or remove items from cart
- Responsive cart screen (mobile and desktop/tablet layouts)
- Order note field on cart screen
- Real-time updates using Provider / ChangeNotifier

## Prerequisites
- Flutter SDK (stable)
- Dart
- Android/iOS toolchain (emulator or device)
- (Optional) VS Code or Android Studio

## Quick setup

1. Open a terminal and clone/open the project folder:
   - cd c:\Users\swaya\Year2\ProgrammingLanguages\union_shop

2. Install dependencies:
   - flutter pub get

3. Run the app:
   - flutter run

## Provider setup
Ensure the Cart provider is registered at the app root so all screens can access it. Example main.dart snippet:

```dart
// lib/main.dart (example)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/app.dart'; // replace with your root widget

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => Cart(),
      child: const MyApp(),
    ),
  );
}
```

## How the cart works (usage)
- On a product page, call Cart.addItem(...) with productId, title, price and quantity.
- CartScreen listens to the Cart provider (Consumer/Provider.of) and updates automatically.
- Use Cart.updateItemQuantity(productId, newQuantity) or Cart.removeItem(productId) to modify contents.
- The cart model exposes:
  - items (Map<String, CartItem>)
  - totalQuantity
  - totalAmount
  - clear()

## File organization (important files)
- lib/models/cart.dart — CartItem and Cart ChangeNotifier
- lib/views/product_page.dart — UI that adds product(s) to cart
- lib/views/cart_screen.dart — responsive cart UI
- lib/widgets/* — shared widgets (buttons, etc.)
- lib/views/* — header/footer and styles

## Responsive behavior
- Mobile: cart shows Product and Total columns; quantity is shown under the product name.
- Desktop/tablet: cart shows Product / Price / Quantity / Total columns, with controls to increase/decrease.

## Notes & tips
- Do a full app restart (not just hot reload) after wrapping runApp with providers.
- Use Provider.of<Cart>(context, listen: false) when performing actions (add/remove) to avoid unnecessary rebuilds.
- Adjust layout breakpoints (e.g. 600px) in `cart_screen.dart` if you need different responsiveness.

## Contributing
Make a branch, implement changes, and submit a PR. Keep UI and state logic separate where possible.

## License
This project contains original educational/demo code. Add a license file if you plan to publish.
