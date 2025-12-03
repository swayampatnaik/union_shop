import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/buttons.dart';

class PersonalisationScreen extends StatefulWidget {
  const PersonalisationScreen({super.key});

  @override
  State<PersonalisationScreen> createState() => _PersonalisationScreenState();
}

class _PersonalisationScreenState extends State<PersonalisationScreen> {
  String _selectedOption = '1 Line';
  final List<String> _lineOptions = [
    '1 Line',
    '2 Lines',
    '3 Lines',
    '4 Lines',
    'Small Logo (Chest)',
    'Large Logo (Back)',
  ];

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
    final isWide = MediaQuery.of(context).size.width >= 900;
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

    // Dropdown field for selecting lines (string options)
    final linesDropdown = SizedBox(
      width: 250,
      height: 75, // keep the same visual height as other inputs
      child: DropdownButtonFormField<String>(
        initialValue: _selectedOption,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        items: _lineOptions
            .map((opt) => DropdownMenuItem<String>(
                  value: opt,
                  child: Text(opt),
                ))
            .toList(),
        onChanged: (val) {
          if (val == null) return;
          setState(() => _selectedOption = val);
        },
      ),
    );

    final infoColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalisation',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Text(
          '£3.00',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 107, 107, 107)),
        ),
        const SizedBox(height: 10),
        const Text(
          'Tax included.',
          style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 107, 107, 107)),
        ),
        const SizedBox(height: 45),
        // dynamic text reflecting selected dropdown choice (string)
        Text(
          'Selection: $_selectedOption',
          style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 107, 107, 107)),
        ),
        const SizedBox(height: 5),
        // dropdown replacing the previous TextField
        linesDropdown,
        const SizedBox(height: 16),
        const Text(
          'Personalisation Line 1:',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 107, 107, 107)),
        ),
        const SizedBox(height: 5),
        const SizedBox(
          width: 400,
          height: 75,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Quantity',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 107, 107, 107)),
        ),
        const SizedBox(height: 5),
        // Quantity input with increment / decrement controls inside the box
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
                // separator
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
        const SizedBox(height: 16),
        WhiteButton(
          text: 'ADD TO CART',
          onPressed: () => Navigator.pushNamed(context, '/product'),
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(placeholderCallbackForButtons: () {}),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(40),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWide ? 1000 : double.infinity),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 460,
                              child: Align(alignment: Alignment.centerRight, child: imageWidget),
                            ),
                            const SizedBox(width: 28),
                            Expanded(child: Padding(padding: const EdgeInsets.only(left: 10.0), child: infoColumn)),
                          ],
                        )
                      : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [imageWidget, const SizedBox(height: 24), infoColumn]),
                ),
              ),
            ),
            Footer(placeholderCallbackForButtons: placeholderCallbackForButtons),
          ],
        ),
      ),
    );
  }
}
