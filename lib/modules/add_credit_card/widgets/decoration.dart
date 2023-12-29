import 'package:app/theme/app_layout.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CreditCardInputDecoration {
  CreditCardInputDecoration._();
  static inputDecoration(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppLayouts.globalBorderRadius),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
