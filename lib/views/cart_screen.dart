import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/widgets/buttons.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

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
                      const SizedBox(height: 40),

                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1165),
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          final isMobile = constraints.maxWidth < 600;

                          return Column(
                            children: [
                              // Header bar (responsive)
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: isMobile
                                    ? const Row(
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
                                              textAlign: TextAlign.end,
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Row(
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

                              // Items
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (ctx, i) {
                                  final item = items[i];

                                  if (isMobile) {
                                    // Mobile row: Product (title + qty under name) and Price
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // Product column: image + title + qty underneath + remove button
                                              Expanded(
                                                flex: 4,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    const SizedBox(width: 16),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            item.title,
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          const SizedBox(height: 6),
                                                          // quantity shown under product name on mobile
                                                          Text('Quantity: ${item.quantity}', style: const TextStyle(fontSize: 13)),
                                                          Row(
                                                            children: [
                                                              TextButton(
                                                                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 24)),
                                                                onPressed: () => cart.removeItem(item.productId),
                                                                child: const Text('Remove', style: TextStyle(color: Color(0xFF6A1B9A), fontSize: 12)),
                                                              ),
                                                            ],
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
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(height: 0.15),
                                      ],
                                    );
                                  } else {
                                    // Desktop/tablet row: full columns
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // Product column (image + title + remove button)
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
                                                    const SizedBox(width: 24),
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
                                                            child: const Text('Remove', style: TextStyle(color: Color(0xFF6A1B9A), fontSize: 12)),
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
                                                      icon: const Icon(Icons.remove, size: 20),
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
                                                      icon: const Icon(Icons.add, size: 20),
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
                                  }
                                },
                              ),

                              const SizedBox(height: 50),

                              // Totals, note field, andbuttons
                              isMobile
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Note field on mobile (full width)
                                        const Text('Add a note to your order', style: TextStyle(fontSize: 14)),
                                        const SizedBox(height: 15),
                                        TextField(
                                          controller: _noteController,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                          ),
                                        ),
                                        const SizedBox(height: 20),

                                        // totals stacked above buttons on mobile
                                        Text('Subtotal: £${cart.totalAmount.toStringAsFixed(2)}',
                                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                                        ),
                                        const SizedBox(height: 12),
                                        const Text('Tax included and shipping calculated at checkout', 
                                          style: TextStyle(fontSize: 14)),
                                        const SizedBox(height: 20),

                                        SizedBox(
                                          height: 44,
                                          width: double.infinity,
                                          child: WhiteButton(
                                            text: 'CLEAR CART',
                                            onPressed: cart.clear,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        SizedBox(
                                          height: 44,
                                          width: double.infinity,
                                          child: PurpleButton(
                                            text: 'CHECKOUT',
                                            onPressed: () {
                                              final note = _noteController.text.trim();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Proceeding to checkout (note: ${note.isEmpty ? '—' : note})')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Left column: note + total label
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Add a note to your order', style: TextStyle(fontSize: 14)),
                                            const SizedBox(height: 15),
                                            // Make the note field wider on larger screens while keeping it responsive on mobile
                                            ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 550),
                                              child: TextField(
                                                controller: _noteController,
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                          ],
                                        ),

                                        // Right column: totals + actions
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('Items: ${cart.totalQuantity}', style: normalText),
                                            const SizedBox(height: 20),
                                            Text('Subtotal              £${cart.totalAmount.toStringAsFixed(2)}',
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            const Text('Tax included and shipping calculated at checkout', 
                                              style: TextStyle(fontSize: 14)),
                                            const SizedBox(height: 30),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 44,
                                                  child: WhiteButton(
                                                    text: 'CLEAR CART',
                                                    onPressed: cart.clear,
                                                  ),
                                                ),
                                                const SizedBox(width: 12), // space between buttons
                                                SizedBox(
                                                  height: 44,
                                                  child: PurpleButton(
                                                    text: 'CHECKOUT',
                                                    onPressed: () {
                                                      final note = _noteController.text.trim();
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text('Proceeding to checkout (note: ${note.isEmpty ? '—' : note})')),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ],
                          );
                        }),
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