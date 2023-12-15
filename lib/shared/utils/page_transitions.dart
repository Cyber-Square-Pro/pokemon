import 'package:flutter/material.dart';

enum PageTransitionType {
  slideLeft,
  slideRight,
  fadeIn,
  fadeOut,
  circularReveal,
  other,
}

class PageTransitionWrapper extends PageRouteBuilder {
  final PageTransitionType transitionType;
  final Widget page;
  final Curve curve;
  final Duration duration;

  PageTransitionWrapper({
    required this.duration,
    required this.page,
    required this.transitionType,
    required this.curve,
  }) : super(
          transitionDuration: duration,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            switch (transitionType) {
              case PageTransitionType.slideLeft:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: child,
                );
              case PageTransitionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: child,
                );

              default:
                // Default to a simple fadeIn transition
                return FadeTransition(
                  opacity: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: child,
                );
            }
          },
        );
}
