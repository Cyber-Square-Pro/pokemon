import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.prefixIcon,
    required this.labelText,
    this.isPassword,
    super.key,
  });

  final String labelText;
  final bool? isPassword;
  final IconData prefixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Settings
      obscureText: widget.isPassword ?? false,

      style: const TextStyle(
        fontFamily: 'Circular',
        fontSize: 16,
        color: Colors.white,
      ),
      // Decoration
      decoration: InputDecoration(
        // Text STyle

        //Enabled, Focused, Error
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        contentPadding: EdgeInsets.all(20),

        // Label
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
        // Prefix Icon
        prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: Colors.white,
      ),
    );
  }
}

const double _borderRadius = 20;
