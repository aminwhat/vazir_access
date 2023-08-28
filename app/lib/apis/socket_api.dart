import 'dart:async';
import 'dart:developer';
import 'package:app/apis/danger_api.dart';
import 'package:app/helper/global.dart';
import 'package:app/models/socketdb.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<AvailableDashboard>();

  void Function(AvailableDashboard) get addResponse => _socketResponse.sink.add;

  Stream<AvailableDashboard> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void _connectAndListen(String url) {
  GLobal.socket = IO.io(
    url,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  GLobal.socket.onConnect((_) {
    GLobal.streamSocket.addResponse(AvailableDashboard(
      children: HeaderWidgets.connected(),
      available: true,
    ));
  });

  GLobal.socket.onConnecting((_) {
    GLobal.streamSocket
        .addResponse(AvailableDashboard(children: HeaderWidgets.connecting()));
  });

  GLobal.socket.onerror((error) {
    log(error.toString());
    GLobal.streamSocket
        .addResponse(AvailableDashboard(children: HeaderWidgets.error()));
  });

  GLobal.socket.onDisconnect((_) {
    GLobal.streamSocket.addResponse(
        AvailableDashboard(children: HeaderWidgets.disconnected()));
  });

  GLobal.socket.connect();

  GLobal.socket.on('status', (data) async {
    bool status = bool.tryParse(data.toString()) ?? false;
    log(status.toString());
    if (!status) {
      await DangerService.danger();
    }
  });

  GLobal.socket.on('url', (data) {
    String theUrl = data;
    GLobal.url = theUrl;
  });
}

class AvailableDashboard {
  final List<Widget> children;
  final bool available;

  AvailableDashboard({
    required this.children,
    this.available = false,
  });
}

abstract class SocketService {
  static void initConnection() {
    var realm = Realm(Configuration.local([SocketDB.schema], isReadOnly: true));
    var first = realm.all<SocketDB>().first;
    _connectAndListen(first.url);
    realm.close();
  }
}
