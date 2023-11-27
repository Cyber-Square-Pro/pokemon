import 'package:app/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingSpinner(BuildContext context, [String message = 'loading']) {
  return Column(
    children: [
      Lottie.asset(
        AppConstants.pokeballSpinLottie,
        height: 50,
        width: 50,
      ),
      Text(
        message,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
      ),
    ],
  );
}
