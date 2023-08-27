import 'dart:io';
import 'package:app/apis/chrome_api.dart';
import 'package:flutter/material.dart';

abstract class HeaderWidgets {
  static List<Widget> connected() => [
        const Text(
          'Everything is fine',
        ),
        IconButton(
          onPressed: () async {
            if (Platform.isWindows) {
              await ChromeService.open();
            }
          },
          icon: const Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.green,
          ),
        ),
      ];

  static List<Widget> connecting() => [
        const Text('Connecting...'),
        const SizedBox(width: 5),
        const CircularProgressIndicator(),
      ];

  static List<Widget> error() => [
        const Text(
          'ERROR?!!!',
        ),
        const SizedBox(width: 5),
        const Icon(
          Icons.error_outline_outlined,
          color: Colors.red,
        ),
      ];

  static List<Widget> disconnected() => [
        const Text('Disconnected...'),
        const SizedBox(width: 5),
        const Icon(Icons.signal_wifi_connected_no_internet_4_rounded),
      ];
}
