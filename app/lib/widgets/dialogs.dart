import 'package:flutter/material.dart';

abstract class Dialogs {
  static void verifyYourEmail(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify your email!'),
        actions: [
          OutlinedButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: const Text('OKay'),
          ),
        ],
        content: const Text(
          'Your account created!\nPlease use the link that sent to your email to verify your email, Then Login',
        ),
      ),
    );
  }
}
