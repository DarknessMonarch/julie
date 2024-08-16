import 'package:flutter/material.dart';
import 'package:jolie/screens/spash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // root of the app
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Jolie house of beauty",
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

