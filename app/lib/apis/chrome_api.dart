import 'package:app/helper/global.dart';
import 'package:browser_launcher/browser_launcher.dart';

abstract class ChromeService {
  static late Chrome _chrome;
  static bool _opened = false;

  static Future<void> open() async {
    _chrome = await Chrome.startWithDebugPort([GLobal.url]);
    _opened = true;
  }

  static Future<void> close() async {
    if (_opened) {
      await _chrome.close();
      _opened = false;
    }
  }
}
