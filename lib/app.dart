import 'package:flutter/material.dart';
import 'package:pure_muslim_app/screen/home_screen.dart';

class PureMuslimApp extends StatelessWidget {
  const PureMuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
