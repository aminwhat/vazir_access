import 'package:app/helper/global.dart';
import 'package:flutter/material.dart';

abstract class Snacks {
  void submitedSnackBar() {
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
    ScaffoldMessenger.of(GLobal.scaffoldMessenger.currentContext!)
        .showSnackBar(this);
  }
}
