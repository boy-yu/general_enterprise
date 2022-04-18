import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class WorkTable extends StatefulWidget {
  @override
  _WorkTableState createState() => _WorkTableState();
}

class _WorkTableState extends State<WorkTable> {
  List<Map<String, String>> data = [
    {
      "title": '1',
      'value': '维修行车控制面板失灵维修行车控制面板失灵维修行车控制面板失灵维修行车控制面板失灵维修行车控制面板失灵维修行车控制面板失灵',
      'type': 'string'
    },
    {"title": 'asdasds', 'value': 'asda封为贵妃各位sdas', 'type': 'string'},
    {"title": '作业', 'value': '维修分威风车', 'type': 'string'},
    {"title": 'asd', 'value': '维修行车控制面板', 'type': 'string'},
    {"title": '作业', 'value': '维', 'type': 'string'},
    {
      'title': '图片',
      'value':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855576345&di=4e7fd17bb8b0ae616329336542badf02&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F86%2F10%2F01300000184180121920108394217.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855576345&di=4e7fd17bb8b0ae616329336542badf02&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F86%2F10%2F01300000184180121920108394217.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg',
      'type': 'image'
    },
    {"title": '业', 'value': '灵行灵行灵', 'type': 'string'},
    {"title": '作业灵', 'value': '维修二车', 'type': 'string'},
    {"title": '业行', 'value': '灵行灵灵', 'type': 'string'},
    {"title": '作业', 'value': '热', 'type': 'string'},
    {
      "title": '作业e个人个人名称',
      'value': '维修行车控制面板失灵维修行车控制rujw灵维修行车控制面板失灵维修行车控制面板失灵维修行车控制面板失灵',
      'type': 'string'
    },
    {
      'title': '图片',
      'value':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855576345&di=4e7fd17bb8b0ae616329336542badf02&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F86%2F10%2F01300000184180121920108394217.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855576345&di=4e7fd17bb8b0ae616329336542badf02&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F86%2F10%2F01300000184180121920108394217.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg|https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600855707702&di=8b77bdb8a1ebd9cc0699d1d1eda43ed9&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg',
      'type': 'image'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Text(
        '作业表格',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: CoustomTable(data: data),
      // child: DSasda(),
    );
  }
}

class CoustomTable extends StatefulWidget {
  CoustomTable({
    this.fontSize = 30,
    this.horPadding = 20,
    this.verPadding = 10,
    this.margin = 10,
    this.data,
  }) : assert(data != null);
  final double fontSize, horPadding, verPadding, margin;
  final List<Map<String, String>> data;
  @override
  _CoustomTableState createState() => _CoustomTableState();
}

class _CoustomTableState extends State<CoustomTable> {
  bool show = false;
  List<List> tableData = [];
  @override
  void initState() {
    super.initState();
    _reactiveTable();
  }

  _reactiveTable() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      int lineWork = ((context.size.width -
                  size.width * widget.horPadding * 4 -
                  size.width * widget.margin * 2) /
              (widget.fontSize * size.width))
          .floor();
      bool isAddtionLine = true;
      for (var i = 0; i < widget.data.length; i++) {
        if (isAddtionLine) {
          if (tableData.length == 0) {
            tableData.insert(0, []);
          }
          tableData[0].insert(0, widget.data[i]);
        } else {
          tableData.insert(0, [widget.data[i]]);
        }
        int currenWork = 0;
        tableData[0].forEach((element) {
          element.forEach((key, value) {
            currenWork += value.length;
          });
        });
        int nextWork = 0;
        if (i + 1 <= widget.data.length - 1) {
          widget.data[i + 1].forEach((key, value) {
            nextWork += value.length;
          });
        }
        // 6: type: string
        if (currenWork + nextWork - 6 < lineWork) {
          isAddtionLine = true;
        } else {
          isAddtionLine = false;
        }
      }
      show = true;
      if (mounted) {
        setState(() {});
      }
    });
  }

  _generate(String title) {
    String _string = '';
    if (title.length < 8)
      _string = title;
    else {
      _string = title;
      int titleLength = title.length ~/ 8;
      for (var i = 1; i <= titleLength; i++) {
        _string = _string.replaceRange(
            i * 8 - 1 + (i - 1), 8 * i + (i - 1), '${title[i * 8 - 1]}\n');
      }
    }
    return _string + ': ';
  }

  @override
  void didUpdateWidget(CoustomTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    tableData = [];
    _reactiveTable();
  }

  @override
  Widget build(BuildContext context) {
    Size currenWindow = MediaQuery.of(context).size;
    return show
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: lineGradBlue,
              ),
            ),
            child: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.all(widget.margin),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.white, width: 1),
                      right: BorderSide(color: Colors.white, width: 1))),
              child: Column(
                children: tableData.reversed
                    .map<Widget>((ele) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 1))),
                        child: Row(
                          children: ele.asMap().keys.map((_index) {
                            double _width =
                                (ele[_index]['title'].toString().length +
                                            ele[_index]['value']
                                                .toString()
                                                .length) *
                                        size.width *
                                        widget.fontSize +
                                    size.width * widget.margin +
                                    size.width * widget.horPadding;
                            if (_index == ele.length - 1 && ele.length > 1) {
                              double tempWidth = 0;
                              for (var i = 0;
                                  i < ele[_index]['title'].toString().length;
                                  i++) {
                                if (Utf8Encoder().convert(
                                        ele[_index]['title'][i].toString())
                                    is List) {
                                  tempWidth += size.width * widget.fontSize;
                                } else {
                                  tempWidth +=
                                      size.width * widget.fontSize * 0.7;
                                }
                              }
                              for (var i = 0;
                                  i < ele[_index]['value'].toString().length;
                                  i++) {
                                if (Utf8Encoder().convert(
                                        ele[_index]['value'][i].toString())
                                    is List) {
                                  tempWidth += size.width * widget.fontSize;
                                } else {
                                  tempWidth +=
                                      size.width * widget.fontSize * 0.7;
                                }
                              }
                              _width = tempWidth +
                                  size.width * widget.horPadding * 4;
                            }
                            if (_width >
                                    currenWindow.width -
                                        widget.margin * 2 -
                                        widget.horPadding * 2 ||
                                ele.length == 1) {
                              _width = currenWindow.width -
                                  widget.margin -
                                  widget.horPadding;
                            }
                            if (ele.length > 1) {
                              _width += size.width * 20;
                            }
                            return Container(
                                width: _width,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 3),
                                      child: Text(
                                        ele.length > 1
                                            ? ele[_index]['title'] + ':'
                                            : _generate(ele[_index]['title']),
                                        style: TextStyle(
                                            fontSize:
                                                size.width * widget.fontSize,
                                            color: Colors.white),
                                      ),
                                    ),
                                    ele[_index]['type'] == 'string'
                                        ? Expanded(
                                            child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                width: 1,
                                                color: Colors.white,
                                              )),
                                              // color: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                ele[_index]['value'],
                                                style: TextStyle(
                                                    fontSize: size.width *
                                                        widget.fontSize,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ))
                                        : Container(
                                            // 总页面width - 表格margin * 2 - title长度（）
                                            width: _width -
                                                ele[_index]['title']
                                                        .toString()
                                                        .length *
                                                    size.width *
                                                    widget.fontSize -
                                                widget.margin * size.width * 4,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                width: 1,
                                                color: Colors.white,
                                              )),
                                            ),
                                            child: Wrap(
                                                children: ele[_index]['value']
                                                    .split('|')
                                                    .map<Widget>((ele) {
                                              return Image.network(
                                                ele,
                                                width: size.width * 180,
                                                height: size.width * 100,
                                              );
                                            }).toList()),
                                          )
                                  ],
                                ));
                          }).toList(),
                        )))
                    .toList(),
              ),
            )))
        : Container();
  }
}
