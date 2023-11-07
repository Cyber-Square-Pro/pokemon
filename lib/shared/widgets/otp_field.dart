import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatefulWidget {
  const OtpField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: widget.controller,
       
    );
  }
}
