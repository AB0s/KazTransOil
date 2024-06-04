import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget widget;

  FadeRoute({required this.widget})
      : super(
    pageBuilder: (_, __, ___) => widget,
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
