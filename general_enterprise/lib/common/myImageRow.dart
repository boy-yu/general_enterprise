import 'package:enterprise/service/context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImageRow extends StatelessWidget {
  MyImageRow({this.data, this.index = 4, this.width});
  final List data;
  final int index;
  final double width;
  _generate(proWidth) {
    List<Widget> _widget = [];
    if (data.length < 4) {
      _widget.add(Row(
        children: data.map((e) {
          return Container(
            margin: EdgeInsets.all(proWidth * 10),
            child: Image.asset(
              e,
              width: (width - index * 10) / index,
            ),
          );
        }).toList(),
      ));
    } else {
      for (int item = 0; item < data.length; item++) {
        if (item % index == 0) {
          _widget.add(Row(
            children: _generateRow(item, proWidth),
          ));
        }
      }
    }

    return _widget;
  }

  _generateRow(column, proWidth) {
    List<Widget> _widget = [];
    for (int item = 0; item < data.length; item++) {
      if (item >= column && item < column + index) {
        _widget.add(Container(
          margin: EdgeInsets.all(proWidth * 10),
          child: Image.asset(
            data[item],
            width: (width - index * 10) / index,
          ),
        ));
      }
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    // print(width);
    return Column(children: _generate(size.width));
  }
}
