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
        body: H(
      itemCount: 12,
      aspectRatio: 0.65,
      spacing: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.green,
            child: ListTile(
              title: Text('Item $index'),
            ),
          ),
        );
      },
    ));
  }
}

class H extends StatelessWidget {
  @required
  final IndexedWidgetBuilder? itemBuilder;
  @required
  final int? itemCount;
  final double? spacing;
  final double? aspectRatio;

  const H(
      {Key? key,
      this.itemBuilder,
      this.itemCount,
      this.spacing,
      this.aspectRatio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio!;

      final height = constraints.maxHeight + itemHeight;

      return OverflowBox(
        maxHeight: height,
        maxWidth: width,
        minHeight: height,
        minWidth: height,
        child: GridView.builder(
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio!,
                crossAxisSpacing: spacing!,
                mainAxisSpacing: spacing!),
            itemBuilder: (context, index) => Transform.translate(
                  offset: Offset(0.0, index.isOdd ? itemHeight + 0.5 : 0.0),
                  child: itemBuilder!(context, index),
                )),
      );
    });
  }
}
