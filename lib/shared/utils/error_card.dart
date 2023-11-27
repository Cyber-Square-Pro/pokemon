import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

Widget errorCard(BuildContext context, {required String message}) {
  return Container(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Image.asset(
          AppConstants.pikachuSadImage,
          height: 70,
          width: 70,
          fit: BoxFit.fitHeight,
        ),
        wSpace(10),
        Text(
          message,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.25,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ],
    ),
  );
}
