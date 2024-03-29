import 'dart:developer';
import 'dart:io';
import 'package:app/apis/chrome_api.dart';
import 'package:app/helper/global.dart';
import 'package:app/models/socketdb.dart';
import 'package:app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:realm/realm.dart';
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
    MenuItemLabel(
        label: 'Exit',
        onClicked: (menuItem) async {
          await ChromeService.close();
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

  // AppWindow().hide();
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

void _db() {
  log('***Checking Database***');
  var realm = Realm(Configuration.local([SocketDB.schema]));
  try {
    var first = realm.all<SocketDB>().first;
    log(first.url);
    log('***Database is Healthy***');
  } on StateError {
    log('***Config Database***');
    realm.write(() {
      realm.add<SocketDB>(SocketDB(ObjectId()));
    });
  } catch (e) {
    log('***Uknown Database Error :|***');
  }
  realm.close();
  log('***Checking Database Finished***');
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await _windowInit();
    await _tray();
    await _startupApp();
  } else if (Platform.isAndroid) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  } else {
    throw UnimplementedError('Unknown Platform');
  }

  _db();
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 128, 255),
        ),
        useMaterial3: true,
      ),
      scaffoldMessengerKey: GLobal.scaffoldMessenger,
      home: const DashboardScreen(),
    );
  }
}
