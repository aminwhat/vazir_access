import 'dart:io';
import 'package:app/apis/web_api.dart';
import 'package:app/helper/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';

final dangerProvider = FutureProvider.family<void, bool>((ref, emit) async {
  if (emit) {
    GLobal.socket.emit('setstatus', false);
  }

  if (Platform.isWindows) {
    ref.watch(closeChromeProvider.future);
    await launchAtStartup.disable();
    await windowManager.destroy();
  }
});
