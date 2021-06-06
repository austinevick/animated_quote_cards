import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:flutter_animated_cards/pages/favourites_quotes_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page_view.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<Quote> quotes = [];
  late StreamSubscription subscription;
  late final snackBar;
  getQuotes() {
    Future<List<Quote>> quote = ApiRequest.fetchDailyQuotes();
    quote.then((value) => setState(() => this.quotes = value));
  }

  @override
  void initState() {
    getQuotes();
    subscription =
        Connectivity().onConnectivityChanged.listen(checkConnectivity);
    super.initState();
  }

  // void checkConnectivity(ConnectivityResult result) {
  //   final hasNetworkConnection = result != ConnectivityResult.none;
  //   !hasNetworkConnection ? buildSnackBar() : Container();
  // }
  ConnectivityResult? result;
  void checkConnectivity(ConnectivityResult result) {
    setState(() => this.result = result);

    if (result == ConnectivityResult.none) {
      buildSnackBar();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 50,
        )));
  }

  buildSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(days: 365),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'Dismiss',
            onPressed: () => SnackBarClosedReason.action),
        content: Container(
          height: 50,
          child: Text('No internet connection',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        )));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
          child: quotes.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    //  backgroundColor: Colors.white,
                  ),
                )
              : PageView.builder(
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
                                  height: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Entry.all(
                              delay: Duration(milliseconds: 800),
                              duration: Duration(seconds: 1),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: Text(
                                  quotes[index].text,
                                  style: GoogleFonts.abrilFatface(fontSize: 35),
                                ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextButton(
                                          style: ButtonStyle(
                                              //  padding: MaterialStateProperty.all(50)
                                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      FavouriteQuotesScreen())),
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
