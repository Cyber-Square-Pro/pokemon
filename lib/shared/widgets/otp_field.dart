import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomOtpField extends StatefulWidget {
  const CustomOtpField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      defaultPinTheme: PinTheme(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Circular',
          fontSize: 17,
        ),
        height: 40,
        width: 35,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
      ),
      controller: widget.controller,
    );
  }
}
