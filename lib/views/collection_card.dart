import 'package:flutter/material.dart';

class CollectionCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;

  const CollectionCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  bool _hovering = false;

  void _setHover(bool value) {
    if (mounted) setState(() => _hovering = value);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // keeps 1:1 ratio; GridView cell will set actual size
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Material(
          color: const Color.fromARGB(255, 86, 86, 86),
          child: MouseRegion(
            onEnter: (_) => _setHover(true),
            onExit: (_) => _setHover(false),
            child: InkWell(
              onTap: widget.onTap ??
                  () {
                    Navigator.pushNamed(context, '/collections');
                  },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: const Color.fromARGB(255, 67, 67, 67),
                      child: const Center(
                        child: Icon(Icons.image_not_supported, color: Color.fromARGB(255, 64, 63, 63)),
                      ),
                    ),
                  ),

                  // gradient for contrast
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.45),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // translucent grey hover overlay (animated)
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 180),
                      opacity: _hovering ? 0.65 : 0.0,
                      child: Container(color: Colors.grey),
                    ),
                  ),

                  // centered title overlay
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Semantics(
                        button: true,
                        label: widget.title,
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          final double computedFont = (constraints.maxWidth * 0.16).clamp(12.0, 32.0);
                          return Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: computedFont,
                              fontWeight: FontWeight.bold,
                              shadows: const [
                                Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(0, 1)),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}