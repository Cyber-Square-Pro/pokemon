import 'package:flutter/material.dart';

class CustomAltElevatedButton extends StatelessWidget {
  const CustomAltElevatedButton({
    required this.label,
    required this.onPressed,
    super.key,
  });
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      // Decoration
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white.withOpacity(0.9),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Circular',
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
