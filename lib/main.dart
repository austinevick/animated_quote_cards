import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/pages/daily_quote_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'Quote App',
        home: LandingScreen(),
      ),
    );
  }
}
