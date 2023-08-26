import 'dart:io';
import 'package:app/apis/danger_api.dart';
import 'package:app/apis/init_api.dart';
import 'package:app/apis/web_api.dart';
import 'package:app/core/version.dart';
import 'package:app/helper/global.dart';
import 'package:app/widgets/dialogs.dart';
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
  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        ref.watch(initProvider.future);
      },
    );
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
            children: ref.watch(headerProvider),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            onPressed: () {
              Dialogs.danger(context, ref);
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

final headerProvider = Provider<List<Widget>>((ref) {
  switch (GLobal.connectionState) {
    case AppConnectionState.connected:
      return [
        const Text(
          'Everything is fine',
        ),
        IconButton(
          onPressed: () async {
            if (Platform.isWindows) {
              ref.watch(openChromeProvider.future);
            }
          },
          icon: const Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.green,
          ),
        ),
      ];
    case AppConnectionState.disconnected:
      return [
        const Text(
          'Disconnected!!!',
        ),
        const Icon(
          Icons.error_outline_outlined,
          color: Colors.yellow,
        ),
      ];
    case AppConnectionState.waiting:
      return [
        const Text('Connecting...'),
        const CircularProgressIndicator(),
      ];
    case AppConnectionState.danger:
      ref.watch(dangerProvider.call(true).future);
      return [
        const Text('Connecting...'),
        const CircularProgressIndicator(),
      ];
    default:
      return [
        const Text('Connecting...'),
        const CircularProgressIndicator(),
      ];
  }
});
