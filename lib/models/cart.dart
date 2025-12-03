import 'package:flutter/foundation.dart';

class CartItem {
  final String id; // unique id for the cart entry
  final String productId; // id of the product
  final String title;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      productId: productId,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Cart with ChangeNotifier {
  // key = productId
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get totalQuantity =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.values.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  bool containsProduct(String productId) => _items.containsKey(productId);

  void addItem({
    required String productId,
    required String title,
    required double price,
    int quantity = 1,
  }) {
    if (_items.containsKey(productId)) {
      final existing = _items[productId]!;
      existing.quantity += quantity;
    } else {
      _items[productId] = CartItem(
        id: DateTime.now().toIso8601String(),
        productId: productId,
        title: title,
        price: price,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void updateItemQuantity(String productId, int quantity) {
    if (!_items.containsKey(productId)) return;
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      _items[productId] = _items[productId]!.copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    final item = _items[productId]!;
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}