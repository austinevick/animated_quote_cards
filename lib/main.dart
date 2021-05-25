import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/pages/page_view.dart';
import 'package:flutter_animated_cards/pages/staggered_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Flutter App',
      home: PageViewScreen(),
    );
  }
}
