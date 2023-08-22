import 'package:browser_launcher/browser_launcher.dart';

class WebApi {
  final String url;
  late Chrome chrome;
  bool opened = false;

  WebApi(this.url);

  Future<void> open() async {
    chrome = await Chrome.startWithDebugPort([url]);
    opened = true;
  }

  Future<void> close() async {
    if (opened) {
      await chrome.close();
      opened = false;
    }
  }
}
