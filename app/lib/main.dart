import 'dart:io';
import 'package:app/helper/global.dart';
import 'package:app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

Future<void> _windowInit() async {
  await windowManager.ensureInitialized();
  WindowManager.instance.setMaximumSize(const Size(800, 500));
  WindowManager.instance.setMinimumSize(const Size(400, 200));
  WindowManager.instance.setTitle('Vazir Access');
  WindowManager.instance.setSize(const Size(500, 300));
}

Future<void> _tray() async {
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
    MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
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
}

Future<void> _startupApp() async {}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await _windowInit();
    await _tray();
    await _startupApp();
  }
}

Future<void> main() async {
  await _init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vazir Access',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scaffoldMessengerKey: GLobal.scaffoldMessenger,
      home: const DashboardScreen(),
    );
  }
}
