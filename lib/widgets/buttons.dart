import 'package:flutter/material.dart';

/// Purple button with white text
class PurpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const PurpleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4d2963),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: padding,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}


/// White button with purple text and optional size + thin purple border
class WhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final double borderWidth;
  final BorderRadius borderRadius;

  const WhiteButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.width,
    this.height,
    this.borderWidth = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  Widget build(BuildContext context) {
    const purple =  Color(0xFF4d2963);

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: purple,
        side: BorderSide(color: purple, width: borderWidth),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: padding,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    // SizedBox accepts nullable width/height; if null it won't constrain that axis
    return SizedBox(
      width: width,
      height: height,
      child: button,
    );
  }
}