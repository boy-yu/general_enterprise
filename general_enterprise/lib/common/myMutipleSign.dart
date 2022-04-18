import 'dart:io';

import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'myCustomColor.dart';
import 'myFileImage.dart';

class MyMutipleSIgn extends StatefulWidget {
  MyMutipleSIgn(
      {this.title, this.value, this.index, this.placeHolder, this.name});
  final String title, name;
  final String value;
  final String index, placeHolder;
  @override
  _MyMutipleSIgnState createState() => _MyMutipleSIgnState();
}

class _MyMutipleSIgnState extends State<MyMutipleSIgn> {
  bool showFirst = false;

  @override
  Widget build(BuildContext context) {
    final _context = Provider.of<Counter>(context);
    showFirst = !showFirst;
    // print(_context.signArrs[widget.index]);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.title == ''
              ? Container()
              : Container(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: themeColor),
                  ),
                  margin: EdgeInsets.only(
                      left: size.width * 35,
                      top: size.width * 35,
                      bottom: size.width * 20),
                ),
          Container(
            child: Text(
              widget.placeHolder,
              textAlign: TextAlign.center,
              style: TextStyle(color: placeHolder),
            ),
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: size.width * 5),
          ),
          Container(
              color: Colors.white,
              child: Text(widget.value),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 10)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign', arguments: {
                'index': widget.index,
                'name': widget.name,
                'title': widget.title
              });
            },
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: _context.signArrs[widget.index] != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image(
                          image: FileImageEx(
                              File(_context.signArrs[widget.index])),
                          height: size.width * 160,
                        ),
                        Text(DateTime.now().toString().split(' ')[0]),
                      ],
                    )
                  : null,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 44),
            ),
          )
        ],
      ),
    );
  }
}
