import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/ui/widgets/pokeball.dart';
import 'package:app/theme/app_theme.dart';

class DrawerMenuItemWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  final double width;
  final VoidCallback? onTap;

  const DrawerMenuItemWidget(
      {Key? key,
      required this.color,
      required this.text,
      this.height = 55,
      this.width = 155,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap ??
            () {
              BotToast.showText(text: "Not implemented yet");
            },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color:
                  (onTap != null) ? Colors.white.withOpacity(0.75) : Colors.white.withOpacity(0.25),
            ),
            color: onTap != null
                ? Colors.transparent
                : AppTheme.getColors(context).drawerDisabled.withOpacity(0.25),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Positioned(
                  top: -12,
                  right: -14,
                  child: PokeballWidget(
                    size: 83,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                Positioned(
                  top: -60,
                  left: -50,
                  child: PokeballWidget(
                    size: 83,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: (onTap != null) ? Colors.white : Colors.white.withOpacity(0.5),
                          fontFamily: 'Circular',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
