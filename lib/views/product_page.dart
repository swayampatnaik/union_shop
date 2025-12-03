import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/buttons.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late TextEditingController _qtyController;

  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

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

                  // Quantity input — fixed height to match WhiteButton
                  SizedBox(
                    width: 120,
                    height: 48, // match other controls' height
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          // numeric input
                          Expanded(
                            child: TextField(
                              controller: _qtyController,
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.top,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                hintText: '1',
                                hintStyle: TextStyle(fontSize: 14),
                              ),
                              onChanged: (_) => setState(() {}), // update UI if needed
                            ),
                          ),

                          // separator (thin)
                          Container(width: 0, height: double.infinity, color: Colors.grey.shade300),

                          // up / down buttons
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  final current = int.tryParse(_qtyController.text) ?? 1;
                                  final next = (current + 1);
                                  _qtyController.text = next.toString();
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                  child: Icon(Icons.arrow_drop_up, size: 20),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final current = int.tryParse(_qtyController.text) ?? 1;
                                  final next = (current - 1) < 1 ? 1 : (current - 1);
                                  _qtyController.text = next.toString();
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                  child: Icon(Icons.arrow_drop_down, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  WhiteButton(
                    text: 'ADD TO CART',
                    onPressed: () {
                      //final qty = int.tryParse(_qtyController.text) ?? 1;
                      // placeholder behaviour: in a real app, add the product to the cart with the specified quantity
                      Navigator.pushNamed(context, '/product'); // placeholder
                    },
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
                ),
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
