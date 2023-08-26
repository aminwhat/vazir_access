import 'dart:developer';
import 'dart:io';
import 'package:app/apis/danger_api.dart';
import 'package:app/apis/web_api.dart';
import 'package:app/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

Future<void> _windowInit() async {
  await windowManager.ensureInitialized();
  WindowManager.instance.setMaximumSize(const Size(800, 500));
  WindowManager.instance.setMinimumSize(const Size(400, 200));
  WindowManager.instance.setTitle('Vazir Access');
  WindowManager.instance.setSize(const Size(500, 300));
  WindowManager.instance.setMinimizable(false);
}

Future<void> _tray(FutureProviderRef ref) async {
  String path =
      Platform.isWindows ? 'assets/logo/vazir.ico' : 'assets/logo/vazir.png';

  // final AppWindow appWindow = AppWindow();
  final WindowManager appWindow = WindowManager.instance;
  final SystemTray systemTray = SystemTray();

  // We first init the systray menu
  await systemTray.initSystemTray(
    title: "system tray",
    iconPath: path,
  );

  // create context menu
  final Menu menu = Menu();
  await menu.buildFrom([
    MenuItemLabel(label: 'Show', onClicked: (menuItem) => appWindow.show()),
    MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
    MenuItemLabel(
        label: 'Exit',
        onClicked: (menuItem) async {
          ref.watch(closeChromeProvider.future);
          await windowManager.destroy();
        }),
  ]);

  // set context menu
  await systemTray.setContextMenu(menu);

  // handle system tray event
  systemTray.registerSystemTrayEventHandler((eventName) {
    debugPrint("eventName: $eventName");
    if (eventName == kSystemTrayEventClick) {
      Platform.isWindows ? appWindow.show() : systemTray.popUpContextMenu();
    } else if (eventName == kSystemTrayEventRightClick) {
      Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
    }
  });

  AppWindow().hide();
}

Future<void> _startupApp() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  await launchAtStartup.enable();
  // await launchAtStartup.disable();
  bool isEnabled = await launchAtStartup.isEnabled();
  log('launch at Startup: $isEnabled');
}

void _socket(FutureProviderRef ref) {
  GLobal.socket = io(
    'http://localhost:3781/power',
    OptionBuilder().setTransports(['websocket']).build(),
  );

  GLobal.socket.onConnect((_) {
    GLobal.connectionState = AppConnectionState.connected;
  });
  GLobal.socket.onConnecting((_) {
    GLobal.connectionState = AppConnectionState.waiting;
  });
  GLobal.socket.onDisconnect((_) {
    GLobal.connectionState = AppConnectionState.disconnected;
  });
  GLobal.socket.onConnectError((_) {
    GLobal.connectionState = AppConnectionState.disconnected;
  });
  GLobal.socket.onConnectTimeout((_) {
    GLobal.connectionState = AppConnectionState.disconnected;
  });
  GLobal.socket.on('status', (data) {
    bool? status = bool.tryParse(data);
    log(status.toString());
    if (status == true) {
    } else if (status == false) {
      ref.watch(dangerProvider.call(false).future);
    }
  });
  GLobal.socket.on('url', (data) {
    String url = data;
    GLobal.url = url;
  });
}

final initProvider = FutureProvider<void>((ref) async {
  if (Platform.isWindows) {
    await _windowInit();
    await _tray(ref);
    await _startupApp();
  }

  _socket(ref);
});
