import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class GLobal {
  static final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  static String url = 'https://panel.baspar.vazir.io/';

  static late Socket socket;
}
