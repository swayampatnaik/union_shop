import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';

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
      routes: {'/product': (context) => const ProductPage()},
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  bool _isMenuOpen = false;
  final TextEditingController _searchController = TextEditingController();

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                // Header
                Container(
                  height: 135,
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Top banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        color: const Color(0xFF4d2963),
                        child: const Text(
                          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Main header
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _isSearching
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          suffixIcon: const Icon(Icons.search, size: 25),
                                        ),
                                        autofocus: true,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        size: 27,
                                        color: Colors.black,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      onPressed: _toggleSearch,
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navigateToHome(context);
                                      },
                                      child: Image.network(
                                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                        height: 27,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            width: 18,
                                            height: 18,
                                            child: const Center(
                                              child: Icon(Icons.image_not_supported,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        },
                                        ),
                                      ),
                                      Expanded(
                                        child: Builder(builder: (context) {
                                          final isWide = MediaQuery.of(context).size.width > 800;

                                          if (isWide) {
                                            return Center(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton(
                                                    onPressed: () => navigateToHome(context),
                                                    child: const Text('Home'),
                                                  ),
                                                  TextButton(
                                                    onPressed: placeholderCallbackForButtons,
                                                    child: const Text('Shop'),
                                                  ),
                                                  TextButton(
                                                    onPressed: placeholderCallbackForButtons,
                                                    child: const Text('The Print Shack'),
                                                  ),
                                                  TextButton(
                                                    onPressed: placeholderCallbackForButtons,
                                                    child: const Text('SALE!'),
                                                  ),
                                                  TextButton(
                                                    onPressed: placeholderCallbackForButtons,
                                                    child: const Text('About'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }

                                          return const SizedBox.shrink();
                                        }),
                                      ),

                                      ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 1000),
                                        child: Builder(
                                          builder: (context) {
                                            final isWide = MediaQuery.of(context).size.width > 800;

                                            if (_isMenuOpen && isWide) {
                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                if (mounted) setState(() => _isMenuOpen = false);
                                              });
                                            }

                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.search,
                                                    size: 27,
                                                    color: Colors.black,
                                                  ),
                                                  padding: const EdgeInsets.all(8),
                                                  constraints: const BoxConstraints(
                                                    minWidth: 32,
                                                    minHeight: 32,
                                                  ),
                                                  onPressed: _toggleSearch,
                                                ),

                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.person_outline,
                                                    size: 27,
                                                    color: Colors.black,
                                                  ),
                                                  padding: const EdgeInsets.all(8),
                                                  constraints: const BoxConstraints(
                                                    minWidth: 32,
                                                    minHeight: 32,
                                                  ),
                                                  onPressed: placeholderCallbackForButtons,
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.shopping_bag_outlined,
                                                    size: 27,
                                                    color: Colors.black,
                                                  ),
                                                  padding: const EdgeInsets.all(8),
                                                  constraints: const BoxConstraints(
                                                    minWidth: 32,
                                                    minHeight: 32,
                                                  ),
                                                  onPressed: placeholderCallbackForButtons,
                                                ),

                                                if (!isWide)
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.menu,
                                                      size: 27,
                                                      color: Colors.black,
                                                    ),
                                                    padding: const EdgeInsets.all(8),
                                                    constraints: const BoxConstraints(
                                                      minWidth: 32,
                                                      minHeight: 32,
                                                    ),
                                                    onPressed: _toggleMenu,
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Hero Section
                SizedBox(
                  height: 400,
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
                      // Content overlay
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Placeholder Hero Title',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is placeholder text for the hero section.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: placeholderCallbackForButtons,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text(
                                'BROWSE PRODUCTS',
                                style: TextStyle(fontSize: 14, letterSpacing: 1),
                              ),
                            ),
                          ],
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
                      children: [
                        const Text(
                          'PRODUCTS SECTION',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 48),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          children: const [
                            ProductCard(
                              title: 'Placeholder Product 1',
                              price: '£10.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 2',
                              price: '£15.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 3',
                              price: '£20.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 4',
                              price: '£25.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer
                Container(
                  width: double.infinity,
                  color: Colors.grey[50],
                  child: Column(
                    children: [
                      // Top section with padding
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // stack into one column on narrow screens (breakpoint = 600)
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final isNarrow = constraints.maxWidth < 600;

                                const leftColumn = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Opening Hours',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      '\n❄️ Winter Break Closure Dates ❄️\n \nClosing 4pm 19/12/2025\n \nReopening 10am 05/01/2026\n \nLast post date: 12pm 18/12/2025\n',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      '- - - - - - - - - - - - - - - - - -',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      '\n(Term Time)\n \nMonday - Friday 10am - 4pm\n \n(Outside of Term Time / Consolidation Weeks)\n \nMonday - Friday 10am - 3pm\n \nPurchase online 24/7\n',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                );

                                const middleColumn = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Help and Information',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Search'),
                                    SizedBox(height: 10),
                                    Text('Terms & Conditions of Sale Policy'),
                                  ],
                                );

                                const rightColumn = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Latest Offers',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Email Address (Placeholder for Text Box)'),
                                    SizedBox(height: 10),
                                    Text('Subscribe (Placeholder for Button)'),
                                  ],
                                );

                                if (isNarrow) {
                                  return const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      leftColumn,
                                      SizedBox(height: 24),
                                      middleColumn,
                                      SizedBox(height: 24),
                                      rightColumn,
                                    ],
                                  );
                                }

                                return const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: leftColumn),
                                    Expanded(child: middleColumn),
                                    Expanded(child: rightColumn),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Full-width divider
                      const Divider(thickness: 0.75, height: 1),

                      // Bottom section with padding
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                        child: Column(
                          children: [
                            // Responsive footer bottom: 2 columns on wide screens, 1 column on narrow screens
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final isNarrow = constraints.maxWidth < 600;

                                const leftColumn = Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.facebook, size: 28),
                                        SizedBox(width: 20),
                                        Icon(Icons.camera, size: 28),
                                      ],
                                    ),
                                  ],
                                );

                                final rightColumn = Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 12,
                                      children: [
                                        Container(width: 50, height: 30, color: Colors.black12),
                                        Container(width: 50, height: 30, color: Colors.black12),
                                        Container(width: 50, height: 30, color: Colors.black12),
                                        Container(width: 50, height: 30, color: Colors.black12),
                                      ],
                                    ),
                                  ],
                                );

                                if (isNarrow) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      leftColumn,
                                      const SizedBox(height: 32),
                                      rightColumn,
                                      const SizedBox(height: 32),
                                      const Text(
                                        '© 2025 UPSU Store — Powered by Shopify',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Expanded(child: leftColumn),
                                        Expanded(child: rightColumn),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    const Text(
                                      '© 2025 UPSU Store — Powered by Shopify',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Full-width dropdown menu
          if (_isMenuOpen)
            Positioned(
              top: 135,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem('Home'),
                    _buildMenuItem('Shop'),
                    _buildMenuItem('The Print Shack'),
                    _buildMenuItem('SALE!'),
                    _buildMenuItem('About'),
                    _buildMenuItem('UPSU.net'),
                  ],
                ),
              ),
            ),
          // Close menu when clicking outside
          if (_isMenuOpen)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: _toggleMenu,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Material(
      child: Column(
        children: [
          const Divider(height: 0.2, thickness: 0.2),
          InkWell(
            onTap: () {
              _toggleMenu();
              // Handle menu item tap here
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, thickness: 0.75),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
