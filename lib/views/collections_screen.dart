import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});
  
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
                  Text('Collections', style: heading1),
                  SizedBox(height: 40),
                  Text(
                    'Our collections are curated to bring you the best of university branded products. Explore our range of clothing, accessories, and merchandise designed to showcase your school spirit. Whether you are looking for casual wear or something special, our collections have something for everyone.',
                    style: normalText,
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