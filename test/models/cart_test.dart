import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  group('Cart model', () {
    test('adds a new item', () {
      final cart = Cart();
      cart.addItem(productId: 'p1', title: 'Product 1', price: 2.5, quantity: 1);

      expect(cart.items.length, 1);
      expect(cart.containsProduct('p1'), isTrue);
      expect(cart.totalQuantity, 1);
      expect(cart.totalAmount, 2.5);
    });

    test('increments quantity for existing product when adding again', () {
      final cart = Cart();
      cart.addItem(productId: 'p1', title: 'Product 1', price: 2.5, quantity: 1);
      cart.addItem(productId: 'p1', title: 'Product 1', price: 2.5, quantity: 2);

      final item = cart.items['p1']!;
      expect(item.quantity, 3);
      expect(cart.totalQuantity, 3);
      expect(cart.totalAmount, 7.5);
    });

    test('updateItemQuantity changes quantity and removes when set to 0', () {
      final cart = Cart();
      cart.addItem(productId: 'p1', title: 'Product 1', price: 5.0, quantity: 2);

      cart.updateItemQuantity('p1', 4);
      expect(cart.items['p1']!.quantity, 4);
      expect(cart.totalQuantity, 4);
      expect(cart.totalAmount, 20.0);

      // setting to zero removes the item
      cart.updateItemQuantity('p1', 0);
      expect(cart.containsProduct('p1'), isFalse);
      expect(cart.items.length, 0);
    });

    test('removeSingleItem decrements quantity and removes when reaches zero', () {
      final cart = Cart();
      cart.addItem(productId: 'p1', title: 'Product 1', price: 3.0, quantity: 2);

      cart.removeSingleItem('p1');
      expect(cart.items['p1']!.quantity, 1);
      expect(cart.totalAmount, 3.0);

      // second removal should remove the product entirely
      cart.removeSingleItem('p1');
      expect(cart.containsProduct('p1'), isFalse);
    });

    test('removeItem removes specific product', () {
      final cart = Cart();
      cart.addItem(productId: 'p1', title: 'Product 1', price: 2.0, quantity: 1);
      cart.addItem(productId: 'p2', title: 'Product 2', price: 4.0, quantity: 1);

      cart.removeItem('p1');
      expect(cart.containsProduct('p1'), isFalse);
      expect(cart.containsProduct('p2'), isTrue);
      expect(cart.items.length, 1);
    });

    test('clear empties the cart', () {
      final cart = Cart();
      cart.addItem(productId: 'p1', title: 'Product 1', price: 2.0, quantity: 1);
      cart.addItem(productId: 'p2', title: 'Product 2', price: 4.0, quantity: 2);

      expect(cart.items.isNotEmpty, isTrue);
      cart.clear();
      expect(cart.items.isEmpty, isTrue);
      expect(cart.totalAmount, 0.0);
      expect(cart.totalQuantity, 0);
    });

    test('CartItem.copyWith updates quantity only when provided', () {
      final original = CartItem(
        id: 'id1',
        productId: 'p1',
        title: 'Product 1',
        price: 9.99,
        quantity: 2,
      );

      final copied = original.copyWith(quantity: 5);
      expect(copied.id, original.id);
      expect(copied.productId, original.productId);
      expect(copied.title, original.title);
      expect(copied.price, original.price);
      expect(copied.quantity, 5);

      final same = original.copyWith();
      expect(same.quantity, original.quantity);
    });
  });
}