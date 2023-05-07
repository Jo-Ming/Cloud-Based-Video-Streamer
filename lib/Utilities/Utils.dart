import 'package:flutter/material.dart';

class Utils {
  static final messengerkey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBarRed(String? text, BuildContext context) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSnackBarGreen(String? text, BuildContext context) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
