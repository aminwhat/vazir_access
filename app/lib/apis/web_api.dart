import 'package:browser_launcher/browser_launcher.dart';

class WebApi {
  final String url;
  late Chrome chrome;
  bool opend = false;

  WebApi(this.url);

  Future<void> open() async {
    chrome = await Chrome.startWithDebugPort([url]);
    opend = true;
  }

  Future<void> close() async {
    await chrome.close();
    opend = false;
  }
}
