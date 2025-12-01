import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class SearchPageScreen extends StatelessWidget {
  const SearchPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search', style: heading1),
      ),
      body: const Center(
        child: Text(
          'Search Page Content Goes Here',
          style: normalText,
        ),
      ),
    );
  }
}