import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions of Sale Policy', style: heading1),
      ),
      body: const Center(
        child: Text(
          'Terms & Conditions of Sale Policy Content Goes Here',
          style: normalText,
        ),
      ),
    );
  }
} 