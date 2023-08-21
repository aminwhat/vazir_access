import 'package:app/helper/global.dart';
import 'package:app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

void _init() {
  setPathUrlStrategy();
  WebViewPlatform.instance = WebWebViewPlatform();
}

void main() {
  _init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vazir Access',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scaffoldMessengerKey: GLobal.scaffoldMessenger,
      home: const DashboardScreen(),
    );
  }
}
