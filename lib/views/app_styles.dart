import 'package:flutter/material.dart';

const TextStyle normalText = TextStyle(
  color: Colors.black,
  fontSize: 16,
);

const heading1 = TextStyle(
  fontSize: 33,
  fontWeight: FontWeight.bold,
);

const heading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

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