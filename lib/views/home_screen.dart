import 'package:flutter/material.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _isSearching = false;
  // header handles its own navigation and menu overlay by default

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  // void _toggleSearch() {
  //   setState(() {
  //     _isSearching = !_isSearching;
  //     if (!_isSearching) {
  //       _searchController.clear();
  //     }
  //   });
  // }

  // menu is handled inside Header via an OverlayEntry; no local toggle needed

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Header (moved into its own file)
                Header(
                  // rely on Header's default named-route navigation; only provide
                  // the placeholder callback from here
                  placeholderCallbackForButtons: placeholderCallbackForButtons,
                ),

                // Hero Section
                SizedBox(
                  height: 475,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ),
                      // Content overlay - centered vertically and horizontally
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Big Sale! - Over 20% OFF!',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Over 20% off select collections. Come and Grab yours while stock lasts!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  height: 48,
                                  child: PurpleButton(
                                    text: 'BROWSE COLLECTIONS',
                                    onPressed: () => Navigator.pushNamed(context, '/collections'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Products Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('ESSENTIAL RANGE - OVER 20% OFF!', style: heading2, textAlign: TextAlign.center),
                        const SizedBox(height: 35),
                          // responsive, centered grid with a maximum width
                        Builder(builder: (context) {
                          final width = MediaQuery.of(context).size.width;
                          final crossAxisCount = width > 1200 ? 2 : (width > 900 ? 2 : 1);
                          // control how wide the grid gets on large screens
                          final gridMaxWidth = width > 1200 ? 900.0 : (width > 900 ? 800.0 : double.infinity);

                          return Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: gridMaxWidth),
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 1.0, // keep squares; change if needed
                                crossAxisSpacing: 35,
                                mainAxisSpacing: 35,
                                children: const[
                                  ProductCard(
                                    title: 'Placeholder Collection 1',
                                    price: '\$19.99',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard (
                                    title: 'Placeholder Collection 2',
                                    price: '\$29.99',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard(
                                    title: 'Placeholder Collection 3',
                                    price: '\$39.99',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard(
                                    title: 'Placeholder Collection 4',
                                    price: '\$49.99',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                Footer(
                  placeholderCallbackForButtons: placeholderCallbackForButtons,
                ),
              ],
            ),
          ),
          // Menu is handled inside the shared Header using an OverlayEntry.
        ],
      ),
    );
  }

}
