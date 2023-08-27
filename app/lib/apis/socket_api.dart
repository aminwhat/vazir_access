import 'dart:async';
import 'dart:developer';
import 'package:app/apis/danger_api.dart';
import 'package:app/helper/global.dart';
import 'package:app/models/socketdb.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AvailableDashboard {
  final List<Widget> children;
  final bool available;

  AvailableDashboard({
    required this.children,
    this.available = false,
  });
}

final providerOfSocket =
    StreamProvider.autoDispose<AvailableDashboard>((ref) async* {
  StreamController<AvailableDashboard?> stream = StreamController();

  GLobal.socket.onConnect((_) {
    stream.add(AvailableDashboard(
      children: HeaderWidgets.connected(),
      available: true,
    ));
  });
  GLobal.socket.onConnecting((_) {
    stream.add(AvailableDashboard(children: HeaderWidgets.connecting()));
  });
  GLobal.socket.onerror((_) {
    stream.add(AvailableDashboard(children: HeaderWidgets.error()));
  });
  GLobal.socket.onDisconnect((_) {
    stream.add(AvailableDashboard(children: HeaderWidgets.disconnected()));
  });
  GLobal.socket.on('status', (data) async {
    GLobal.status = bool.tryParse(data) ?? true;
    log(GLobal.status.toString());
    if (!GLobal.status) {
      await DangerService.danger();
    }
  });
  GLobal.socket.on('url', (data) {
    String theUrl = data;
    GLobal.url = theUrl;
  });

  Future.delayed(
    const Duration(seconds: 3),
    () {
      GLobal.socket.emit('getstatus');
    },
  );

  /** if you using .autDisopose */
  ref.onDispose(() {
    // close socketio
    stream.close();
    GLobal.socket.dispose();
  });

  await for (final value in stream.stream) {
    log('stream value => ${value.toString()}');
    yield value ?? AvailableDashboard(children: HeaderWidgets.connecting());
  }
});

abstract class SocketService {
  static void initConnection() {
    var realm = Realm(Configuration.local([SocketDB.schema], isReadOnly: true));
    var first = realm.all<SocketDB>().first;
    GLobal.socket = io(
      first.url,
      OptionBuilder().setTransports(['websocket']).build(),
    );

    GLobal.socket.connect();
    realm.close();
  }
}
