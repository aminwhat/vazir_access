import 'package:app/apis/socket_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class GLobal {
  static final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  static String url = 'https://panel.baspar.vazir.io/';

  static late Socket _socket;
  static Socket get socket => _socket;
  static set setSocket(String url) {
    _socket = io(
      url,
      OptionBuilder().setTransports(['websocket']).build(),
    );
    _socket.connect();
    final container = ProviderContainer();
    container.read(providerOfSocket);
  }
}
