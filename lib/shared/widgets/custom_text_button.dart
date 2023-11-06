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
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Circular',
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    );
  }
}
