import 'package:flutter/material.dart';

enum PageAnimationStyle { Fade, Scale, Rotate, Slide, SlideBottomTop }

class CustomRoute extends PageRouteBuilder {
  final Widget child;
  final Duration? duration;
  final String? routeName;
  final PageAnimationStyle? animationStyle;

  CustomRoute({
    required this.child,
    this.duration,
    this.routeName,
    this.animationStyle,
  }) : super(
          pageBuilder: (context, anim1, anim2) => child,
          transitionDuration: duration ?? const Duration(milliseconds: 300),
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animationStyle == PageAnimationStyle.Fade) {
              return FadeTransition(opacity: animation, child: child);
            } else if (animationStyle == PageAnimationStyle.Slide) {
              return SlideTransition(
                child: child,
                position: Tween(
                  begin: const Offset(1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
              );
            } else if (animationStyle == PageAnimationStyle.Rotate) {
              return RotationTransition(
                child: child,
                turns: ReverseAnimation(animation),
              );
            } else if (animationStyle == PageAnimationStyle.Scale) {
              return ScaleTransition(child: child, scale: animation);
            } else {
              return FadeTransition(opacity: animation, child: child);
            }
          },
        );
}
