import 'dart:math';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomQuoteList extends StatelessWidget {
  final double? value;
  final int? itemCount;
  final PageController? controller;
  final List<Quote>? quotes;
  RandomQuoteList(
      {Key? key, this.value, this.itemCount, this.controller, this.quotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
              image: AssetImage('images/img5.jpg'))),
      child: PageView.builder(
        controller: controller,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final percentage = index - value!;
          final rotation = percentage.clamp(0.0, 1.0);
          final fixRotation = pow(rotation, 0.35);

          return Entry.all(
            delay: Duration(milliseconds: 800),
            duration: Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateY(6.0 * fixRotation)
                          ..translate(rotation * size.width)
                          ..scale(rotation)
                          ..setRotationX(rotation)
                          ..setRotationY(rotation),
                        child: Container(
                          height: 480,
                          width: 310,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xff000080),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(
                                    'images/img2.png',
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(quotes![index].text,
                                      style: GoogleFonts.abrilFatface(
                                          fontSize: 28, color: Colors.white)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'images/img1.png',
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.copy)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AnimatedOpacity(
                    opacity: 1 - rotation,
                    duration: Duration(seconds: 1),
                    child: Text(quotes![index].author,
                        style: GoogleFonts.pattaya(
                            fontSize: 18, color: Colors.white))),
              ],
            ),
          );
        },
      ),
    );
  }
}
