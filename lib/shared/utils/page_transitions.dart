import 'package:flutter/material.dart';

enum PageTransitions {
  slideLeft,
  slideRight,
  circularReveal,
}

class TransitionPageRoute extends PageRouteBuilder {
  final PageTransitions? transition;
  final Widget child;
  final Curve? curve;
  final Duration? duration;

  TransitionPageRoute({
    required this.child,
    this.duration,
    this.transition,
    this.curve,
  }) : super(
          transitionDuration: duration ?? const Duration(milliseconds: 800),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            switch (transition) {
              case PageTransitions.slideLeft:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve ?? Curves.easeOut,
                    ),
                  ),
                  child: child,
                );
              case PageTransitions.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve ?? Curves.easeOut,
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
                      curve: curve ?? Curves.easeOut,
                    ),
                  ),
                  child: child,
                );
            }
          },
        );
}
