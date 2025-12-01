import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('', style: heading1),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 125.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('About us', style: heading1),
            SizedBox(height: 40),
            Text(
              'Welcome to the Union Shop!\n \nWe are dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!\n \nAll online purcghases are available for delivery or instore collection!\n \nWe hope you enjoy out products as much as we enjoy offering them to you. If you have any questions or comments, please dont hesitate to contact us at hello@upsu.net.\n \nHappy Shopping!\n \nThe Union Shop & Reception Team',
              style: normalText,
            ),
          ],
        ),
      ),
    );
  }
}