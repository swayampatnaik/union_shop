import 'package:flutter/material.dart';
import 'package:union_shop/widgets/collection_card.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/widgets/buttons.dart';
import 'package:union_shop/widgets/product_card.dart';

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

                // Hero Section — responsive: overlay-on-image on wide, overlay-below-image on mobile
                Builder(builder: (context) {
                  final width = MediaQuery.of(context).size.width;
                  const imageUrl =
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561';
                  final isMobile = width < 600; // breakpoint, tweak as needed

                  if (isMobile) {
                    // Mobile: image first (responsive width), then a separate dark panel below containing text/button
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // responsive image that fits the width
                        Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            height: 260,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.image_not_supported)),
                          ),
                        ),

                        // dark panel below the image (acts like the overlay but below)
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Big Sale! - Over 20% OFF!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Over 20% off select collections. Come and grab yours while stock lasts!',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 48,
                                child: PurpleButton(
                                  text: 'BROWSE COLLECTIONS',
                                  onPressed: () => Navigator.pushNamed(context, '/collections'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  // Desktop / wide: keep overlayed image with centered text/button
                  return SizedBox(
                    height: 475,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                            ),
                            // darken image for readability
                            child: Container(color: Colors.black.withValues(alpha: 0.7)),
                          ),
                        ),
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
                  );
                }),

                // Essential Range Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
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
                          final gridMaxWidth = width > 1200 ? 1150.0 : (width > 900 ? 800.0 : double.infinity);

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
                                    title: 'Product 1',
                                    price: '£19.99',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard (
                                    title: 'Product 2',
                                    price: '£29.99',
                                    imageUrl:'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
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

                // Signature Range Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('SIGNATURE RANGE', style: heading2, textAlign: TextAlign.center),
                        const SizedBox(height: 35),
                          // responsive, centered grid with a maximum width
                        Builder(builder: (context) {
                          final width = MediaQuery.of(context).size.width;
                          final crossAxisCount = width > 1200 ? 2 : (width > 900 ? 2 : 1);
                          // control how wide the grid gets on large screens
                          final gridMaxWidth = width > 1200 ? 1150.0 : (width > 900 ? 800.0 : double.infinity);

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
                                    title: 'Product 1',
                                    price: '£19.99',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard (
                                    title: 'Product 2',
                                    price: '£29.99',
                                    imageUrl:'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
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

                // Portsmouth City Collection Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('PORTSMOUTH CITY COLLECTION', style: heading2, textAlign: TextAlign.center),
                        const SizedBox(height: 35),
                          // responsive, centered grid with a maximum width
                        Builder(builder: (context) {
                          final width = MediaQuery.of(context).size.width;
                          final crossAxisCount = width > 1200 ? 2 : (width > 900 ? 2 : 1);
                          // control how wide the grid gets on large screens
                          final gridMaxWidth = width > 1200 ? 1150.0 : (width > 900 ? 800.0 : double.infinity);

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
                                    title: 'Product 1',
                                    price: '£19.99',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard (
                                    title: 'Product 2',
                                    price: '£29.99',
                                    imageUrl:'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard(
                                    title: 'Product 3',
                                    price: '£39.99',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  ProductCard(
                                    title: 'Product 4',
                                    price: '£49.99',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
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

                Container(
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: SizedBox(
                      height: 48,
                      child: PurpleButton(text: 'VIEW ALL', onPressed: () => Navigator.pushNamed(context, '/collections')),
                    )
                  ),
                ),

                // Our Range Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('OUR RANGE', style: heading2, textAlign: TextAlign.center),
                        const SizedBox(height: 35),
                          // responsive, centered grid with a maximum width
                        Builder(builder: (context) {
                          final width = MediaQuery.of(context).size.width;
                          final crossAxisCount = width > 1200 ? 4 : (width > 900 ? 4 : 2);
                          // control how wide the grid gets on large screens
                          final gridMaxWidth = width > 1200 ? 1150.0 : (width > 900 ? 800.0 : double.infinity);

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
                                  CollectionCard(
                                    title: 'Product 1',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  CollectionCard (
                                    title: 'Product 2',
                                    imageUrl:'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  CollectionCard(
                                    title: 'Product 3',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                  CollectionCard(
                                    title: 'Product 4',
                                    imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
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

                // New two-column section: window = two columns, mobile = stacked with RIGHT column on top
                LayoutBuilder(builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 900;

                  final leftColumn = Padding(
                    // use smaller horizontal padding on mobile so the text can be wider
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8.0 : 0.0,
                      vertical: isMobile ? 16.0 : 60.0,
                    ),
                     child: Column(
                       // center content vertically inside the available space
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text('Add a Personal Touch', style: heading2),
                         const SizedBox(height: 12),
                         const Text(
                           'First add your item of clothing to your cart then click below to add your text! '
                           'One line of text contains 10 characters!',
                           style: normalText,
                         ),
                         const SizedBox(height: 16),
                         SizedBox(
                           height: 48,
                           child: PurpleButton(
                             text: 'CLICK HERE TO ADD TEXT!',
                             onPressed: () => Navigator.pushNamed(context, '/personalisation'),
                           ),
                         ),
                       ],
                     ),
                   );

                  final rightColumn = Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                            width: 350,
                            height: 350,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) => Container(
                              height: 350,
                              color: Colors.grey[300],
                              child: const Center(child: Icon(Icons.image_not_supported)),
                            ),
                          ),
                        ),
                    ],
                  );

                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 24.0 : 40.0,
                      horizontal: isMobile ? 16.0 : 200.0,
                    ),
                    child: isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // right column should appear on top on mobile
                              rightColumn,
                              const SizedBox(height: 20),
                              leftColumn,
                            ],
                          )
                        : Row(
                            // ensure both columns are vertically centered inside the row
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 60),
                              Expanded(child: leftColumn),
                              const SizedBox(width: 40),
                              Expanded(child: rightColumn),
                            ],
                          ),
                  );
                }),

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
