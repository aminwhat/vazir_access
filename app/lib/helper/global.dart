import 'package:app/apis/web_api.dart';
import 'package:flutter/material.dart';

abstract class GLobal {
  static final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  static const String _endPoint = 'http://5.202.172.196:8081/';
  static WebApi webApi = WebApi(_endPoint);
}
