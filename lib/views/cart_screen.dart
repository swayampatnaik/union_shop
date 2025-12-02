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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 75.0),
              child: Column(
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