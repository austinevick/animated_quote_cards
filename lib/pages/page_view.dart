import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:google_fonts/google_fonts.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  Random random = Random();
  late StreamSubscription subscription;
  List<Quote> quote = [];
  final controller = new PageController();
  final notifierScroll = ValueNotifier(0.0);

  void _listener() {
    notifierScroll.value = controller.page!;
  }

  getQuotes() {
    Future<List<Quote>> quote = ApiRequest.fetchQuotes();
    quote.then((value) => setState(() => this.quote = value));
  }

  @override
  void initState() {
    controller.addListener(_listener);
    getQuotes();
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(checkConnectivity);
  }

  void checkConnectivity(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You are connected to the internet'
        : 'You have no internet connection';
    final color = hasInternet ? Colors.green : Colors.red;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ))));
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();
    subscription.cancel();
    super.dispose();
  }

  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MouseRegion(
      onHover: (event) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Quotes'),
        ),
        body: ValueListenableBuilder<double>(
            valueListenable: notifierScroll,
            builder: (context, value, _) {
              if (quote.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              return PageView.builder(
                controller: controller,
                itemCount: random.nextInt(quote.length),
                itemBuilder: (context, index) {
                  final percentage = index - value;
                  final rotation = percentage.clamp(0.0, 1.0);
                  final fixRotation = pow(rotation, 0.35);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002)
                              ..rotateY(6.0 * fixRotation)
                              ..translate(rotation * size.width)
                              ..scale(rotation)
                              ..rotateZ(2 * rotation)
                              ..setRotationX(rotation)
                              ..setRotationY(rotation * 2.5),
                            child: Container(
                              width: 300,
                              height: 300,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors
                                    .primaries[index % Colors.primaries.length],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(quote[index].text,
                                    style: GoogleFonts.abrilFatface(
                                        fontSize: 28, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedOpacity(
                          opacity: 1 - rotation,
                          duration: Duration(seconds: 1),
                          child: Text(quote[index].author,
                              style: GoogleFonts.pattaya(
                                  fontSize: 18, color: Colors.white))),
                    ],
                  );
                },
              );
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent),
            height: 60,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: IconButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                      // controller.animateTo(-0.1,
                      //     duration: Duration(seconds: 1), curve: Curves.easeIn);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 32,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 32,
                      )),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
