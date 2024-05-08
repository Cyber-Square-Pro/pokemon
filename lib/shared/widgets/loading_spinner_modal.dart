import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

Future<dynamic> showLoadingSpinnerModal(BuildContext context, String? message) {
  return showDialog(
    context: context,
    builder: (context) => Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 250,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AnimatedPokeballWidget(color: Colors.white, size: 40),
            hSpace(15),
            if (message == null || message == '')
              const SizedBox()
            else
              Text(
                message,
                style: const TextStyle(
                    fontFamily: 'Circular',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
          ],
        ),
      ),
    ),
  );
}
