import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myCustomColor.dart';

class MySign extends StatefulWidget {
  MySign({this.title, this.value, this.placeHolder, this.index, this.purview});
  final String title;
  final String value, purview;
  final String placeHolder;
  final String index;
  @override
  _MySignState createState() => _MySignState();
}

class _MySignState extends State<MySign> {
  bool showFirst = true;

  _generateImg(_context) {
    Widget _widget;

    if (null == widget.placeHolder) {
      _widget = Text(
        '请签字',
        style: TextStyle(color: placeHolder),
      );
    } else {
      // print(widget.placeHolder);
      _widget = Image(
          image: NetworkImage(widget.placeHolder), height: size.width * 160);
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    final _context = Provider.of<Counter>(context);
    showFirst = !showFirst;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              widget.title,
              style: TextStyle(color: themeColor),
            ),
            margin: EdgeInsets.only(
                left: size.width * 35,
                top: size.width * 35,
                bottom: size.width * 20),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign', arguments: {
                'index': widget.index,
                'purview': widget.purview,
                'title': widget.title
              });
            },
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: _generateImg(_context),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 44),
            ),
          )
        ],
      ),
    );
  }
}
