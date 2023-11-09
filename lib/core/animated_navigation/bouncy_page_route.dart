import 'package:flutter/cupertino.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget page;
  BouncyPageRoute({
    required this.page,
  }) : super(
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (context, animation, secAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secAnimation) => page,
        );
}
