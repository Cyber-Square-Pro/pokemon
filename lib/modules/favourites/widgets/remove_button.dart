import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget removeButton(BuildContext context, {required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Icon(
        CupertinoIcons.xmark,
        size: 20,
        color: Theme.of(context).colorScheme.background,
      ),
    ),
  );
}
