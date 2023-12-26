import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TshirtCard extends StatelessWidget {
  const TshirtCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.onTap,
    required this.tag,
  });

  final String name;
  final String description;
  final String price;
  final String imageURL;
  final String tag;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
              child: Hero(
                tag: 't_$tag',
                child: Image.network(
                  imageURL,
                  height: 175.h,
                  errorBuilder: (context, _, stackTrace) {
                    return Container(
                      height: 175.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.10),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  hSpace(5),
                  Text(
                    '₹$price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
