import 'package:flutter/material.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridPage extends StatefulWidget {
  @override
  _StaggeredGridPageState createState() => _StaggeredGridPageState();
}

class _StaggeredGridPageState extends State<StaggeredGridPage> {
  List<Quote> quote = [];

  getQuotes() {
    Future<List<Quote>> quote = ApiRequest.fetchQuotes();
    quote.then((value) => setState(() => this.quote = value));
  }

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: quote.length,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: new Center(
            child: new Text(quote[index].text),
          )),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    ));
  }
}

// class H extends StatelessWidget {
// @required  final IndexedWidgetBuilder? itemBuilder;
//  @required final int? itemCount;
//   final double? spacing;
//   final double? aspectRatio;

//   const H({Key? key, this.itemBuilder, this.itemCount, this.spacing, this.aspectRatio}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: aspectRatio!,
//     crossAxisSpacing: spacing!,mainAxisSpacing: spacing!
//     ), itemBuilder: (context,index)=>Transform.translate(offset: Offset(0.0, index.isOdd?100:0.0)
//    child: itemBuilder:(context,index),));
//   }
// }
