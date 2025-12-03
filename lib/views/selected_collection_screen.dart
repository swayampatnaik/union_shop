import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/product_card.dart';

class SelectedCollectionScreen extends StatelessWidget {
  const SelectedCollectionScreen({super.key});
  
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 75.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Selected Collection', style: heading1),
                  const SizedBox(height: 10),
                  const Text('Description of the selected collection goes here.', style: greyText,),
                  const SizedBox(height: 50),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          // responsive, centered grid with a maximum width
                          Builder(builder: (context) {
                            final width = MediaQuery.of(context).size.width;
                            final crossAxisCount = width > 1200 ? 3 : (width > 900 ? 3 : 2);
                            // control how wide the grid gets on large screens
                            final gridMaxWidth = width > 1200 ? 1050.0 : (width > 900 ? 850.0 : double.infinity);

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
                                      title: 'Autumn Favourites',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Black Friday',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Clothing',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Clothing - Original',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Elections Discounts',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Essential Range',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Graduation',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Limited Edition Essential Zip Hoodies',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Merchandise',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Nike Final Chance',
                                      price: '\$12.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                    ProductCard(
                                      title: 'Personalisation',
                                      price: '\$12.00',
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