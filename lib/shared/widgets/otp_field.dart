import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomOtpField extends StatefulWidget {
  const CustomOtpField({
    required this.controller,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Circular',
          fontSize: 17,
        ),
        height: 45,
        width: 40,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white.withOpacity(0.75),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppTheme.globalBorderRadius)),
        ),
      ),
      focusedPinTheme: PinTheme(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Circular',
          fontSize: 17,
        ),
        height: 45,
        width: 40,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppTheme.globalBorderRadius)),
        ),
      ),
      errorPinTheme: PinTheme(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Circular',
          fontSize: 17,
        ),
        height: 45,
        width: 40,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppTheme.globalBorderRadius)),
        ),
      ),
      errorTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}
