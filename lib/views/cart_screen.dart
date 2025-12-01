import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';

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

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 125.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Your Cart', style: heading1),
                  SizedBox(height: 40),
                  Text(
                    'Your cart is currently empty. Browse our products and add items to your cart to see them here.',
                    style: normalText,
                  ),
                ],
              ),
            ),
            // Footer (extracted)
            Footer(
            placeholderCallbackForButtons: placeholderCallbackForButtons,
            ),
          ],
        ),
      ),
    );
  }
}