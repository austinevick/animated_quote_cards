import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page_view.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<Quote> quotes = [];

  getQuotes() {
    Future<List<Quote>> quote = ApiRequest.fetchDailyQuotes();
    quote.then((value) => setState(() => this.quotes = value));
  }

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                image: AssetImage('images/sea.jpg'))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'images/quote.png',
                              height: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            quotes[index].text,
                            style: GoogleFonts.abrilFatface(fontSize: 35),
                          ),
                        ),
                        Spacer(flex: 3),
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
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) =>
                                                  PageViewScreen())),
                                      child: Text('Random quotes',
                                          style: TextStyle())),
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
                                      onPressed: () => null,
                                      child: Text('Favourites')),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ])),
        ),
      ),
    );
  }
}
