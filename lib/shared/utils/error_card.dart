import 'package:flutter/material.dart';

Widget errorCard(BuildContext context, {required String message}) {
  return Container(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        //? <Sad Pokemon Icon>
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
