import 'dart:io';
import 'package:app/apis/chrome_api.dart';
import 'package:app/helper/global.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';

abstract class DangerService {
  static Future<void> danger() async {
    GLobal.socket.emit('setstatus', false);

    if (Platform.isWindows) {
      await ChromeService.close();
      await launchAtStartup.disable();
      await windowManager.destroy();
    }
  }
}
