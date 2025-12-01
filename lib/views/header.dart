import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class Header extends StatefulWidget {
  final VoidCallback onNavigateHome;
  final VoidCallback onNavigateProduct;
  final VoidCallback onNavigateAbout;
  final VoidCallback onNavigateCart;
  final VoidCallback onToggleMenu;
  final VoidCallback placeholderCallbackForButtons;

  const Header({
    super.key,
    required this.onNavigateHome,
    required this.onNavigateProduct,
    required this.onNavigateAbout,
    required this.onNavigateCart,
    required this.onToggleMenu,
    required this.placeholderCallbackForButtons,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) _searchController.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
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
              padding: const EdgeInsets.symmetric(horizontal: 23),
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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          onPressed: _toggleSearch,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: widget.onNavigateHome,
                          child: Builder(
                            builder: (context) {
                              final isWide = MediaQuery.of(context).size.width > 800;
                              final logoHeight = isWide ? 38.0 : 28.0;

                              return Image.network(
                                'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                height: logoHeight,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    width: 18,
                                    height: 18,
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                                    ),
                                  );
                                },
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
                                    TextButton(onPressed: widget.onNavigateHome, child: const Text('Home', style: normalText)),
                                    TextButton(onPressed: widget.placeholderCallbackForButtons, child: const Text('Shop', style: normalText)),
                                    TextButton(onPressed: widget.placeholderCallbackForButtons, child: const Text('The Print Shack', style: normalText)),
                                    TextButton(onPressed: widget.placeholderCallbackForButtons, child: const Text('SALE!', style: normalText)),
                                    TextButton(onPressed: widget.onNavigateAbout, child: const Text('About', style: normalText)),
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

                              // ensure mobile menu toggles are preserved
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.search, size: 30, color: Colors.black),
                                    padding: const EdgeInsets.all(6),
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    onPressed: _toggleSearch,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.person_outline, size: 30, color: Colors.black),
                                    padding: const EdgeInsets.all(6),
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    onPressed: widget.placeholderCallbackForButtons,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.shopping_bag_outlined, size: 30, color: Colors.black),
                                    padding: const EdgeInsets.all(6),
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    onPressed: widget.onNavigateCart,
                                  ),
                                  if (!isWide)
                                    IconButton(
                                      icon: const Icon(Icons.menu, size: 27, color: Colors.black),
                                      padding: const EdgeInsets.all(6),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      onPressed: widget.onToggleMenu,
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
    );
  }
}