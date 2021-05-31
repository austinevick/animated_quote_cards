import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/pages/page_view.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => PageViewScreen())),
            child: buildCategory(text: 'Random Quotes')),
        buildCategory(text: ''),
        buildCategory(text: ''),
        buildCategory(text: ''),
      ],
    ));
  }

  Widget buildCategory({String? text}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              height: 200,
              child: Text(
                text!,
                style: TextStyle(fontSize: 18),
              )),
        ),
      );
}
