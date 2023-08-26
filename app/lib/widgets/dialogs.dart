import 'package:app/apis/danger_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Dialogs {
  static void danger(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?!'),
        actions: [
          OutlinedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            onPressed: () async {
              ref.watch(dangerProvider.call(true).future);
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          OutlinedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        content: const Text(
          'THIS IS SUPER DANGER',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
