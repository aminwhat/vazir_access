import 'package:app/helper/global.dart';
import 'package:app/helper/router.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void _init() {
  setPathUrlStrategy();
}

void main() {
  _init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Vazir Access',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
      scaffoldMessengerKey: GLobal.scaffoldMessenger,
    );
  }
}
