import 'package:app/helper/global.dart';

abstract class DangerApi {
  static Future<void> danger() async {
    // TODO: let the other devices know

    if (GLobal.webApi.opend) {
      await GLobal.webApi.close();
    }
  }

  static Future<void> openPanel() async {
    await GLobal.webApi.open();
  }
}
