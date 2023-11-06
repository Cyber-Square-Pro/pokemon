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
        fontSize: 18,
        color: Colors.white,
      ),
      // Decoration
      decoration: InputDecoration(
        // Text STyle

        //Enabled, Focused, Error
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white.withOpacity(0.75),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 25),

        // Label
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
        // Prefix Icon
        prefixIcon: SizedBox(width: 65, child: Icon(widget.prefixIcon)),
        prefixIconColor: Colors.white,
      ),
    );
  }
}

const double _borderRadius = 20;
