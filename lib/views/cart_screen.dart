import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart', style: heading1),
      ),
      body: const Center(
        child: Text(
          'Cart Content Goes Here',
          style: normalText,
        ),
      ),
    );
  }
}