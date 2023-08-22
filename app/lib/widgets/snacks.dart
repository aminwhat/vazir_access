import 'package:app/helper/global.dart';
import 'package:flutter/material.dart';

abstract class Snacks {
  static void submited() {
    SnackBar(
      content: SnackBarAction(
        label: 'label',
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
