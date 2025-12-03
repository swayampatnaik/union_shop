import 'package:flutter/material.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/buttons.dart';

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

              final infoColumn = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Placeholder Product Name',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '£15.00',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 107, 107, 107)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tax included.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 107, 107, 107)),
                  ),
                  const SizedBox(height: 45),
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 107, 107, 107)),
                  ),
                  const SizedBox(height: 5),
                  // quantity input — fixed height to match WhiteButton (48)
                  const SizedBox(
                    width: 90,
                    height: 75, // set desired height (match WhiteButton)
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: '1',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15), // no vertical padding
                      ),
                    ),
                  ),
                  WhiteButton(
                    text: 'ADD TO CART',
                    onPressed: () => Navigator.pushNamed(context, '/product'), // temp link
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    height: 48,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
                    style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                ],
              );

              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(40),
                // center the two-column layout and constrain its maximum width so columns don't span the whole window
                child: Center(
                  child: ConstrainedBox(
                    // change maxWidth to control how wide the whole two-column area is on large screens
                    constraints: BoxConstraints(maxWidth: isWide ? 1000 : double.infinity),
                    child: isWide
                        ? Row(
                            // align children to the top so the info column starts at the same height as the image
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column: center image inside a fixed-width box so it doesn't expand to fill the column
                              SizedBox(
                                width: 460, // left column image area width (adjust as needed)
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: imageWidget,
                                ),
                              ),

                              const SizedBox(width: 28),

                              // Right column: take remaining space but constrained by the parent maxWidth
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
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
                  ),
                )
              ); // end of LayoutBuilder's return
            }),

            // centered button outside the two-column container — responsive height (auto on mobile)
            LayoutBuilder(builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 40),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // limit the max width on larger screens but allow full width on mobile
                      maxWidth: isMobile ? constraints.maxWidth - 40 : 500,
                    ),
                    child: WhiteButton(
                      text: '←   BACK TO SELECTED COLLECTION',
                      onPressed: () => Navigator.pushNamed(context, '/selected_collection'),
                      // on mobile let height be null so the button expands for wrapped/multi-line text;
                      // on desktop keep a fixed height
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      height: isMobile ? null : 43,
                      // width left null on mobile so button sizes to its child; fixed on desktop via maxWidth above
                      width: isMobile ? null : 500,
                    ),
                  ),
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
