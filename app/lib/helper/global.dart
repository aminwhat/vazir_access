import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class GLobal {
  static final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  static late String url;
  static late final Socket socket;
  static AppConnectionState connectionState = AppConnectionState.waiting;
}

enum AppConnectionState {
  connected,
  waiting,
  disconnected,
  danger,
}
