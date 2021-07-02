import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/pages/daily_quote_screen.dart';

import 'page_view.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final style = TextStyle(color: Colors.white, fontSize: 18);
  var scaleFactor = 0.2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('images/img6.jpg'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                  ScaleAnimatedText(
                      'Success is walking from failure to failure with no loss of enthusiasm.',
                      textStyle: style,
                      scalingFactor: scaleFactor),
                  ScaleAnimatedText('Do one thing every day that scares you.',
                      textStyle: style),
                  ScaleAnimatedText(
                      'If you really look closely, most overnight successes took a long time',
                      scalingFactor: scaleFactor,
                      textStyle: style),
                  ScaleAnimatedText('Do one thing every day that scares you.',
                      scalingFactor: scaleFactor, textStyle: style),
                  ScaleAnimatedText(
                      'If you really look closely, most overnight successes took a long time',
                      scalingFactor: scaleFactor,
                      textStyle: style),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            style: ButtonStyle(
                                //  padding: MaterialStateProperty.all(50)
                                ),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => PageViewScreen())),
                            child: Text('Random quotes', style: TextStyle())),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => DailyQuoteScreen())),
                            child: Text('Daily Quote')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
