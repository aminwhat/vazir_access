import 'package:url_launcher/url_launcher.dart';

Future<void> urlLaunch(Uri uri, {void Function()? onError}) async {
  if (!await launchUrl(uri)) {
    if (onError == null) {
      throw Exception('Could not launch $uri');
    } else {
      onError();
    }
  }
}
