import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.prefixIcon,
    required this.labelText,
    this.isPassword,
    super.key,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.isPasswordField,
    this.suffixIcon,
    this.maxLines,
    this.borderColor,
    this.errorBorderColor,
    this.textColor,
  });

  final String labelText;
  final bool? isPassword;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final TextInputType? keyboardType;
  final bool? isPasswordField;
  final Widget? suffixIcon;
  final int? maxLines;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Settings
      obscureText: isPassword ?? false,

      style: TextStyle(
        fontFamily: 'Circular',
        letterSpacing: 0.5,
        fontSize: 16,
        color: textColor ?? Colors.white,
      ),
      maxLines: maxLines ?? 1,

      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // Decoration
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: borderColor ?? Colors.white.withOpacity(0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: borderColor ?? Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: errorBorderColor ?? Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: 2,
            color: errorBorderColor ?? Colors.red,
          ),
        ),
        contentPadding: const EdgeInsets.only(
          left: 10,
          bottom: 10,
          top: 10,
          right: 25,
        ),

        // Label
        floatingLabelStyle: TextStyle(
          fontSize: 15,
          color: Colors.white.withOpacity(0.75),
        ),
        labelText: labelText,
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
        prefixIcon: SizedBox(
          width: 45,
          child: Icon(prefixIcon),
        ),
        // Suffix icon for password field
        suffixIcon: suffixIcon,
      ),
    );
  }
}

final double _borderRadius = AppTheme.globalBorderRadius;
