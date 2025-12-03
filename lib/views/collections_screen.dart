import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/collection_card.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});
  
  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    void _openCollection(String title) {
      Navigator.pushNamed(context, '/selected_collection', arguments: title);
    }

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
                  const Text('Collections', style: heading1),
                  const SizedBox(height: 10),
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
                                  children: [
                                    CollectionCard(
                                      title: 'Autumn Favourites',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Autumn Favourites'),
                                    ),
                                    CollectionCard(
                                      title: 'Black Friday',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Black Friday'),
                                    ),
                                    CollectionCard(
                                      title: 'Clothing',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Clothing'),
                                    ),
                                    CollectionCard(
                                      title: 'Clothing - Original',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Clothing - Original'),
                                    ),
                                    CollectionCard(
                                      title: 'Elections Discounts',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Elections Discounts'),
                                    ),
                                    CollectionCard(
                                      title: 'Essential Range',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Essential Range'),
                                    ),
                                    CollectionCard(
                                      title: 'Graduation',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Graduation'),
                                    ),
                                    CollectionCard(
                                      title: 'Limited Edition Essential Zip Hoodies',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Limited Edition Essential Zip Hoodies'),
                                    ),
                                    CollectionCard(
                                      title: 'Merchandise',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Merchandise'),
                                    ),
                                    CollectionCard(
                                      title: 'Nike Final Chance',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Nike Final Chance'),
                                    ),
                                    CollectionCard(
                                      title: 'Personalisation',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Personalisation'),
                                    ),
                                    CollectionCard(
                                      title: 'Popular',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Popular'),
                                    ),
                                    CollectionCard(
                                      title: 'Portsmouth City Collection',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Portsmouth City Collection'),
                                    ),
                                    CollectionCard(
                                      title: 'Pride Collection',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Pride Collection'),
                                    ),
                                    CollectionCard(
                                      title: 'SALE',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('SALE'),
                                    ),
                                    CollectionCard(
                                      title: 'Signature & Essential Range',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Signature & Essential Range'),
                                    ),
                                    CollectionCard(
                                      title: 'Signature Range',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Signature Range'),
                                    ),
                                    CollectionCard(
                                      title: 'Sports Clubs',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Sports Clubs'),
                                    ),
                                    CollectionCard(
                                      title: 'Spring Favourites',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Spring Favourites'),
                                    ),
                                    CollectionCard(
                                      title: 'Student Essentials',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Student Essentials'),
                                    ),
                                    CollectionCard(
                                      title: 'Student Groups',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Student Groups'),
                                    ),
                                    CollectionCard(
                                      title: 'Summer Essentials',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Summer Essentials'),
                                    ),
                                    CollectionCard(
                                      title: 'Summer Favourites',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Summer Favourites'),
                                    ),
                                    CollectionCard(
                                      title: 'University Clothing',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('University Clothing'),
                                    ),
                                    CollectionCard(
                                      title: 'University Merchandise',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('University Merchandise'),
                                    ),
                                    CollectionCard(
                                      title: 'UPSU Bears',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('UPSU Bears'),
                                    ),
                                    CollectionCard(
                                      title: 'Winter Favourites',
                                      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      onTap: () => _openCollection('Winter Favourites'),
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