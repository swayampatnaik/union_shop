import 'package:flutter/material.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Header(
              placeholderCallbackForButtons: () {},
            ),

            // Product details (now responsive: two-column on wide screens, stacked on mobile)
            LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              const imageUrl =
                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282';

              final imageWidget = Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.hardEdge,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: isWide ? 420 : 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: isWide ? 420 : 300,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Image unavailable', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );

              const infoColumn = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Placeholder Product Name',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  Text(
                    '£15.00',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4d2963)),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
                    style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                ],
              );

              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(24),
                child: isWide
                    ? Row(
                        // align children to the top so the info column starts at the same height as the image
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column (image) occupies half the page; image constrained and aligned to top
                          Expanded(
                            flex: 1,
                            child: Center(
                              // keep the column half-width but make the image smaller and centered
                              child: Align(
                                alignment: Alignment.centerRight, // place the image on the right side of the left column
                                child: SizedBox(
                                  width: 420, // adjust this to change image width
                                  child: imageWidget,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 28),

                          // Right column (info) occupies the other half; add internal left padding so text isn't flush
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.0),
                              child: infoColumn,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageWidget,
                          const SizedBox(height: 24),
                          infoColumn,
                        ],
                      ),
              );
            }),

            // Footer
            Footer(
              placeholderCallbackForButtons: placeholderCallbackForButtons,
            ),
          ],
        ),
      ),
    );
  }
}
