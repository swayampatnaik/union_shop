import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/widgets/buttons.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  
  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              placeholderCallbackForButtons: () {},
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
              child: Consumer<Cart>(
                builder: (context, cart, _) {
                  final items = cart.items.values.toList();

                  if (items.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Your Cart', style: heading1),
                        const SizedBox(height: 40),
                        const Text(
                          'Your cart is currently empty.',
                          style: normalText,
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 48,
                          child: PurpleButton(
                            text: 'CONTINUE SHOPPING    --->',
                            onPressed: () {
                              Navigator.pushNamed(context, '/'); // to go back to home screen
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Your Cart', style: heading1),
                      const SizedBox(height: 60),

                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: Column(
                          children: [
                            // Header bar for the columns
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Product',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Price',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Quantity',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Total',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 0.25),

                            // Cart items list (each row separated by Divider)
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              // no external separators — we'll render a Divider under each item inside itemBuilder
                              separatorBuilder: (_, __) => const SizedBox.shrink(),
                              itemBuilder: (ctx, i) {
                                final item = items[i];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Product column (image placeholder + title + remove button)
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  color: Colors.grey[200],
                                                  child: Center(
                                                    child: Text(
                                                      item.title.isNotEmpty ? item.title[0] : '?',
                                                      style: const TextStyle(fontSize: 24, color: Colors.black54),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 40), // increase horizontal gap between thumbnail and title
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        item.title,
                                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      const SizedBox(height: 6),
                                                      TextButton(
                                                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 24)),
                                                        onPressed: () => cart.removeItem(item.productId),
                                                        child: const Text('Remove', style: TextStyle(color: Colors.purple, fontSize: 12)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Price column
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '£${item.price.toStringAsFixed(2)}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          // Quantity column (controls)
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  visualDensity: VisualDensity.compact,
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                                                  onPressed: () {
                                                    cart.updateItemQuantity(item.productId, item.quantity - 1);
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                                                ),
                                                IconButton(
                                                  visualDensity: VisualDensity.compact,
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(Icons.add_circle_outline, size: 20),
                                                  onPressed: () {
                                                    cart.updateItemQuantity(item.productId, item.quantity + 1);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Total column
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '£${(item.price * item.quantity).toStringAsFixed(2)}',
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(height: 0.15),
                                  ],
                                );
                              },
                            ),

                            const SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Items: ${cart.totalQuantity}', style: normalText),
                                    const SizedBox(height: 6),
                                    Text('Total: £${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 44,
                                      child: PurpleButton(
                                        text: 'CLEAR CART',
                                        onPressed: cart.clear,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      height: 44,
                                      child: PurpleButton(
                                        text: 'CHECKOUT',
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Proceeding to checkout (placeholder)')),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            Footer(
              placeholderCallbackForButtons: placeholderCallbackForButtons,
            ),
          ],
        ),
      ),
    );
  }
}