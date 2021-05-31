import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/pages/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Quote App',
      home: LandingScreen(),
    );
  }
}
