// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Future<T?> showAnimatedDialog<T>({
  required Widget child,
  required BuildContext context,
  bool barrierDismissible = true,
  Color? barrierColor,
  bool useRootNavigator = false,
}) =>
    showGeneralDialog(
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale:
              CurvedAnimation(parent: a1, curve: const ElasticOutCurve(0.95)),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: child,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      context: context,
      useRootNavigator: useRootNavigator,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
