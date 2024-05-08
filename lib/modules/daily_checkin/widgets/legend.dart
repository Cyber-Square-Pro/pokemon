import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/material.dart';

class LegendsList extends StatelessWidget {
  const LegendsList({super.key, required this.legends});

  final Map<Color, String> legends;

  static final Map<Color, String> map = {
    Colors.red: 'Red',
    Colors.green: 'Green',
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: legends.entries.length,
      itemBuilder: (context, index) {
        return LegendItem(
          color: legends.keys.elementAt(index),
          label: legends.values.elementAt(index),
        );
      },
    );
  }
}

class LegendItem extends StatelessWidget {
  const LegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppLayouts.globalBorderRadius),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppLayouts.globalBorderRadius,
              ),
              color: color,
            ),
          ),
          wSpace(10),
          Text(label),
        ],
      ),
    );
  }
}
