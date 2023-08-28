import 'package:app/helper/global.dart';
import 'package:flutter/material.dart';

abstract class Snacks {
  static void success() {
    SnackBar(
      content: SnackBarAction(
        label: 'Success',
        onPressed: () {},
      ),
    ).show();
  }
}

extension on SnackBar {
  /// **[showSnackbar]**
  ///
  /// based on the Global ScaffoldMassenger
  void show() {
    GLobal.scaffoldMessenger.currentState?.clearSnackBars();
    GLobal.scaffoldMessenger.currentState?.showSnackBar(this);
  }
}
