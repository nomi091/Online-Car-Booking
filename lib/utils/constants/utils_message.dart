import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(
      {String? message, Color? backgroundColor, Color? textColor}) {
    Fluttertoast.showToast(
        backgroundColor: backgroundColor, textColor: textColor, msg: message!);
  }

  static snackBar(
      {String? message, context, Color? backgroundColor, Color? textColor}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor ?? Colors.black,
      content: Text(
        message!,
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
      ),
    ));
  }
}
