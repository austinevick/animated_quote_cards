import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final PageController? controller;

  const BottomNavBar({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.transparent),
        height: 60,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  controller!.previousPage(
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
                    controller!.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.easeIn);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 32,
                  )),
            ),
          )
        ]),
      ),
    );
  }
}
