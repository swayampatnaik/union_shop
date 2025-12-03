import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/product_card.dart';

class SelectedCollectionScreen extends StatefulWidget {
  const SelectedCollectionScreen({super.key});

  @override
  State<SelectedCollectionScreen> createState() => _SelectedCollectionScreenState();
}

class _SelectedCollectionScreenState extends State<SelectedCollectionScreen> {
  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  String _selectedFilter = 'All';
  String _selectedSort = 'Featured';

  final List<String> _filterOptions = ['All', 'Clothing', 'Personalisation', 'Merchandise', 'Limited'];
  final List<String> _sortOptions = ['Featured', 'Price: Low → High', 'Price: High → Low', 'Newest'];

  // source product data (title, price, imageUrl) — used to build grid and calculate counts
  final List<Map<String, String>> _products = const [
    {
      'title': 'Autumn Favourites',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Black Friday',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Clothing',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Clothing - Original',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Elections Discounts',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Essential Range',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Graduation',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Limited Edition Essential Zip Hoodies',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Merchandise',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Nike Final Chance',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Personalisation',
      'price': '£12.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
  ];

  List<Map<String, String>> _applyFilterAndSort() {
    // filter
    final filtered = _selectedFilter == 'All'
        ? List<Map<String, String>>.from(_products)
        : _products.where((p) => p['title']!.toLowerCase().contains(_selectedFilter.toLowerCase())).toList();

    // sort — basic example: price sort (parsing numeric value), otherwise keep order
    if (_selectedSort == 'Price: Low → High') {
      filtered.sort((a, b) {
        double pa = double.tryParse(a['price']!.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        double pb = double.tryParse(b['price']!.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        return pa.compareTo(pb);
      });
    } else if (_selectedSort == 'Price: High → Low') {
      filtered.sort((a, b) {
        double pa = double.tryParse(a['price']!.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        double pb = double.tryParse(b['price']!.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        return pb.compareTo(pa);
      });
    } // 'Featured' and 'Newest' keep original order for this example

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _applyFilterAndSort();
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200 ? 3 : (width > 900 ? 3 : 2);
    final gridMaxWidth = width > 1200 ? 1050.0 : (width > 900 ? 850.0 : double.infinity);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              placeholderCallbackForButtons: () {},
            ),

            // Heading + description (kept inside horizontal padding)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Selected Collection', style: heading1),
                  SizedBox(height: 10),
                  Text('Description of the selected collection goes here.', style: greyText),
                ],
              ),
            ),

            // TOP full-width divider (not constrained by the padding)
            Container(width: double.infinity, height: 1, color: const Color(0xFFE6E6E6)),

            // Centered filter/sort row (row itself constrained, dividers span full width)
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: gridMaxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Builder(builder: (ctx) {
                    final isMobile = MediaQuery.of(ctx).size.width < 600;
                    final smallStyle = greyText.copyWith(fontSize: 12);
                    const dropdownStyle = TextStyle(fontSize: 12, color: Colors.black);

                    final row = Row(
                      children: [
                        Text('FILTER', style: smallStyle),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedFilter,
                          style: dropdownStyle,
                          underline: const SizedBox.shrink(),
                          items: _filterOptions.map((f) => DropdownMenuItem(value: f, child: Text(f, style: dropdownStyle))).toList(),
                          onChanged: (v) => setState(() => _selectedFilter = v ?? 'All'),
                        ),
                        const SizedBox(width: 12),
                        Text('SORT', style: smallStyle),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedSort,
                          style: dropdownStyle,
                          underline: const SizedBox.shrink(),
                          items: _sortOptions.map((s) => DropdownMenuItem(value: s, child: Text(s, style: dropdownStyle))).toList(),
                          onChanged: (v) => setState(() => _selectedSort = v ?? 'Featured'),
                        ),
                        const Spacer(),
                        if (!isMobile) Text('${filteredProducts.length} products', style: greyText2),
                      ],
                    );

                    return SizedBox(height: 40, child: row);
                  }),
                ),
              ),
            ),

            // BOTTOM full-width divider
            Container(width: double.infinity, height: 1, color: const Color(0xFFE6E6E6)),

            // product count for mobile sits under the bottom divider
            Builder(builder: (ctx) {
              final isMobile = MediaQuery.of(ctx).size.width < 600;
              if (!isMobile) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${filteredProducts.length} products', style: greyText2.copyWith(fontSize: 12)),
                ),
              );
            }),

            // Grid (kept inside padded container so content aligns with page gutters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: gridMaxWidth),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 35,
                            mainAxisSpacing: 35,
                            children: filteredProducts
                                .map((p) => ProductCard(title: p['title']!, price: p['price']!, imageUrl: p['imageUrl']!))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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