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
                    children: [
                      const Text('Your Cart', style: heading1),
                      const SizedBox(height: 24),

                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (ctx, i) {
                                final item = items[i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 72,
                                        height: 72,
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Text(
                                            item.title.isNotEmpty ? item.title[0] : '?',
                                            style: const TextStyle(fontSize: 24, color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                            const SizedBox(height: 6),
                                            Text('£${item.price.toStringAsFixed(2)} each', style: normalText),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline),
                                            onPressed: () {
                                              cart.updateItemQuantity(item.productId, item.quantity - 1);
                                            },
                                          ),
                                          Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline),
                                            onPressed: () {
                                              cart.updateItemQuantity(item.productId, item.quantity + 1);
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('£${(item.price * item.quantity).toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                          TextButton(
                                            onPressed: () => cart.removeItem(item.productId),
                                            child: const Text('Remove', style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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