import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

mixin BaseClass {
  errorLog(String screenName, String funName, String error) {
    log(" error on $screenName method is $funName error: $error ");
  }

  showLoader(BuildContext context) => context.loaderOverlay.show();
  unFocusOverlay() => FocusManager.instance.primaryFocus?.unfocus();
  hideLoader(BuildContext context) {
    try {
      if (context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    } catch (err) {
      errorLog("BaseClass", "hideLoader", err.toString());
    }
  }

  showSnackBar(
    BuildContext context, {
    String? title,
    required String message,
    int type = 1,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      IconData? icon;
      Color? color;

      //assign color and icon as per type
      switch (type) {
        case 1:
          icon = Icons.done_rounded;
          color = Colors.green;
          title = title ?? "Success";
          break;
        case 2:
          icon = Icons.warning;
          color = Colors.black;
          title = title ?? "Warning";
          break;
        case 3:
          icon = Icons.error;
          color = Colors.red;
          title = title ?? "Error";
          break;
      }

      Flushbar(
        title: title ?? "",
        message: message,
        icon: Icon(
          icon,
          size: 28.0,
          color: color,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(8),
        flushbarStyle: FlushbarStyle.FLOATING,
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: color,
      ).show(context);
    } catch (err) {
      errorLog("ShowSnack", "showSnackBar", err.toString());
    }
  }
}
