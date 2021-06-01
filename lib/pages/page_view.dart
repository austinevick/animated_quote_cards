import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:flutter_animated_cards/widget/bottom_navbar.dart';
import 'package:flutter_animated_cards/widget/random_quote_list.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  Random random = Random();
  late StreamSubscription subscription;
  List<Quote> quotes = [];
  final controller = new PageController();
  final notifierScroll = ValueNotifier(0.0);

  void _listener() {
    notifierScroll.value = controller.page!;
  }

  getQuotes() {
    Future<List<Quote>> quote = ApiRequest.fetchQuotes();
    quote.then((value) => setState(() => this.quotes = value));
  }

  @override
  void initState() {
    controller.addListener(_listener);
    getQuotes();
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(checkConnectivity);
  }

  buildSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              'You have no internet connection',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ))));
  }

  ConnectivityResult? result;
  void checkConnectivity(ConnectivityResult result) {
    setState(() => this.result = result);
  }

  Widget buildBody() => result == ConnectivityResult.none
      ? Entry.scale(
          delay: Duration(milliseconds: 800),
          duration: Duration(seconds: 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 30,
                    child: Text(
                      'No internet connection',
                      style: TextStyle(fontSize: 18),
                    )),
                Center(
                  child: TextButton(
                      onPressed: () => getQuotes(), child: Text('Retry')),
                ),
              ],
            ),
          ),
        )
      : ValueListenableBuilder<double>(
          valueListenable: notifierScroll,
          builder: (context, value, _) {
            if (quotes.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return RandomQuoteList(
              itemCount: quotes.length,
              quotes: quotes,
              value: value,
              controller: controller,
            );
          });

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Quotes'),
        ),
        body: buildBody(),
        bottomNavigationBar: BottomNavBar(controller: controller));
  }
}
