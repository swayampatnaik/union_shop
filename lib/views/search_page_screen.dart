import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';

class SearchPageScreen extends StatelessWidget {
  const SearchPageScreen({super.key});
  
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
                  Text('Search', style: heading1),
                  SizedBox(height: 40),
                  Text(
                    'Search functionality is coming soon. Please check back later!',
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