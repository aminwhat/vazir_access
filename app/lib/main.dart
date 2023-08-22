import 'package:app/helper/global.dart';
import 'package:app/screens/screens.dart';
import 'package:flutter/material.dart';

void _init() {}

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
