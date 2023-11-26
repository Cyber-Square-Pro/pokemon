import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.prefixIcon,
    required this.labelText,
    this.isPassword,
    super.key,
    required this.controller,
    required this.validator,
    this.keyboardType,
  });

  final String labelText;
  final bool? isPassword;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final TextInputType? keyboardType;

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
        letterSpacing: 0.5,
        fontSize: 18,
        color: Colors.white,
      ),

      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // Decoration
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 25),

        // Label
        floatingLabelStyle: TextStyle(
          fontSize: 15,
          color: Colors.white.withOpacity(0.75),
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.white.withOpacity(0.5),
        ),

        errorStyle: TextStyle(color: Colors.white, height: 1, shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          )
        ]),

        // Prefix Icon
        prefixIcon: SizedBox(width: 65, child: Icon(widget.prefixIcon)),
      ),
    );
  }
}

final double _borderRadius = AppTheme.globalBorderRadius;
