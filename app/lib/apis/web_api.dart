import 'package:app/helper/global.dart';
import 'package:browser_launcher/browser_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late Chrome _chrome;
bool _opened = false;

final openChromeProvider = FutureProvider<void>((ref) async {
  _chrome = await Chrome.startWithDebugPort([GLobal.url]);
  _opened = true;
});

final closeChromeProvider = FutureProvider<void>((ref) async {
  if (_opened) {
    await _chrome.close();
    _opened = false;
  }
});
