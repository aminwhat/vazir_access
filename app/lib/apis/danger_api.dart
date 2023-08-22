import 'dart:io';
import 'package:app/helper/global.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';

abstract class DangerApi {
  static Future<void> danger() async {
    // TODO: let the other devices know

    if (Platform.isWindows) {
      await GLobal.webApi.close();

      await launchAtStartup.disable();
      await windowManager.destroy();
    }
  }

  static Future<void> openPanel() async {
    await GLobal.webApi.open();
  }
}
