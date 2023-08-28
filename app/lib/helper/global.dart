import 'package:app/apis/socket_api.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class GLobal {
  static final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();

  static late String url;

  static late Socket socket;

  static StreamSocket streamSocket = StreamSocket();
}
