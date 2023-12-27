import 'package:flutter/material.dart';

class MyBottomSheets {
  static success(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          builder: (context) {
            return Column(
              children: [
                Text(title),
                Text(message),
              ],
            );
          },
        );
      },
    );
  }
}
