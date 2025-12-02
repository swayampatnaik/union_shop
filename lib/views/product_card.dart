import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovering = false;

  void _onEnter(PointerEvent _) => setState(() => _hovering = true);
  void _onExit(PointerEvent _) => setState(() => _hovering = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image area with hover-only opacity overlay
          Expanded(
            child: MouseRegion(
              onEnter: _onEnter,
              onExit: _onExit,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.imageUrl,
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
                  // overlay only over the image; instant opacity change
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        color: Colors.black.withValues(alpha: _hovering ? 0.2 : 0.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // details below image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget.price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}