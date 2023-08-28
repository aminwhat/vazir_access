import 'dart:io';
import 'package:app/apis/socket_api.dart';
import 'package:app/core/version.dart';
import 'package:app/screens/screens.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with WindowListener {
  bool isAvailable = false;

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
            children: ref.watch(providerOfSocket).when(
                  data: (data) {
                    isAvailable = data.available;
                    return data.children;
                  },
                  error: (error, stackTrace) => HeaderWidgets.error(),
                  loading: () => HeaderWidgets.connecting(),
                ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  isAvailable ? Colors.red : Colors.grey),
            ),
            onPressed: isAvailable
                ? () {
                    Dialogs.danger(context);
                  }
                : null,
            child: const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Danger??!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextButton(
                style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.grey)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                child: const Text('appVersion: $appVersion'),
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
