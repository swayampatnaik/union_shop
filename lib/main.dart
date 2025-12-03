import 'package:flutter/material.dart';
import 'package:union_shop/views/about_screen.dart';
import 'package:union_shop/views/cart_screen.dart';
import 'package:union_shop/views/home_screen.dart';
import 'package:union_shop/views/search_page_screen.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/terms_screen.dart';
import 'package:union_shop/views/collections_screen.dart';
import 'package:union_shop/views/selected_collection_screen.dart';
import 'package:union_shop/views/personalisation_screen.dart';
import 'package:union_shop/views/sign_in_screen.dart';


void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutScreen(),
        '/search': (context) => const SearchPageScreen(),
        '/terms': (context) => const TermsScreen(),
        '/cart': (context) => const CartScreen(),
        '/collections': (context) => const CollectionsScreen(),
        '/selected_collection': (context) => const SelectedCollectionScreen(),
        '/personalisation': (context) => const PersonalisationScreen(),
        '/sign_in': (context) => const SignInScreen(),
        },
    );
  }
}