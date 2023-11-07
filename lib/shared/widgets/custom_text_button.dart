import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.label,
  });
  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Circular',
          shadows: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 3,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        shadowColor: Colors.black,
        shape: const StadiumBorder(),
      ),
    );
  }
}
