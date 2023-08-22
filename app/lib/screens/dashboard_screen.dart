import 'dart:io';
import 'package:app/apis/danger_api.dart';
import 'package:app/core/version.dart';
import 'package:app/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WindowListener {
  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      WindowManager.instance.setAlignment(Alignment.bottomRight, animate: true);
      windowManager.addListener(this);
      _init();
    }
  }

  @override
  void dispose() {
    if (Platform.isWindows) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Everything is fine',
              ),
              IconButton(
                onPressed: () async {
                  await DangerApi.openPanel();
                },
                icon: const Icon(
                  Icons.check_circle_outline_outlined,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            onPressed: () async {
              await DangerApi.danger();
            },
            child: const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Danger??!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30, top: 40),
              child: Text(
                'appVersion: $appVersion',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onWindowClose() {
    WindowManager.instance.hide();
  }
}
