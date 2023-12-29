import 'dart:async';

import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.onChanged,
    this.onCountryChanged,
  });

  final TextEditingController controller;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      // Config
      controller: controller,
      validator: validator,
      onCountryChanged: onCountryChanged,
      onChanged: onChanged,

      keyboardType: TextInputType.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      // Decoration
      cursorColor: Colors.white,
      dropdownIcon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      dropdownTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
      ),
      dropdownDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      initialCountryCode: 'IN',
      flagsButtonPadding: EdgeInsets.zero,

      //

      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.zero,
        listTilePadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 0,
        ),
        countryCodeStyle: TextStyle(
          color: Colors.indigo,
          fontSize: 14.sp,
        ),
        searchFieldInputDecoration: InputDecoration(
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: Colors.indigo,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigo,
            ),
          ),
          isDense: true,
          alignLabelWithHint: true,
          hintText: 'Search a country',
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
        ),
        searchFieldPadding: EdgeInsets.symmetric(horizontal: 20.w),
        listTileDivider: hSpace(1),
      ),

      style: TextStyle(
        fontFamily: 'Circular',
        letterSpacing: 0.5,
        fontSize: 16.sp,
        color: Colors.white,
      ),

      decoration: InputDecoration(
        hintText: 'Enter phone number',
        counterStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Circular',
          fontSize: 13.sp,
        ),
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: Colors.white.withOpacity(0.5),
        ),
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
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
        prefix: wSpace(10),
        contentPadding:
            const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 25),
      ),
    );
  }
}

final double _borderRadius = AppTheme.globalBorderRadius;
