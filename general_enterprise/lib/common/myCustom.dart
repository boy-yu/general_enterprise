import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/common/myDrop.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myCount.dart';
import 'myCustomColor.dart';

// custom compontes
//  deal with different data
//  show ui
class MyCustom extends StatefulWidget {
  MyCustom(
      {this.title,
      this.name,
      this.index,
      this.memo = '',
      this.data,
      this.purview});
  final title, name, index, data, purview, memo;
  @override
  _MyCustomState createState() => _MyCustomState();
}

class _MyCustomState extends State<MyCustom> {
  List names = [];
  List tempIndex = [];
  List tableList = []; // Ui list
  List index = [];

  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    // name = widget.data;
    _initShared();

    tempIndex = List.from(widget.index);
    int _index = 1;
    widget.data['tableTitle'].forEach((ele) {
      if (ele['value'].toString().split('|').length > _index) {
        _index = ele['value'].toString().split('|').length;
      }
    });
    // print(_index);
    List.generate(_index, (index) => tableList.add(0));
  }

  _judgeIsLoad() {
    if (mounted) {
      setState(() {});
    }
  }

  _generateInput(width, data, Counter _context, tempIndex, screenIndex,
      {select}) {
    String temp = widget.data['tableTitle'][screenIndex]['value'];
    String severId =
        temp.toString().substring(temp.toString().indexOf('-') + 1);
    List imgValueArr = severId.split('|');
    // print(select >= imgValueArr.length - 1);
    if (select >= imgValueArr.length - 1) {
      for (int x = 0; x < select; x++) {
        if (x >= imgValueArr.length - 1) {
          imgValueArr.add('');
        }
      }
    }

    Widget _widget;
    _widget = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border(bottom: BorderSide(color: underColor, width: 1)),
      ),
      padding:
          EdgeInsets.symmetric(vertical: width * 0, horizontal: width * 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              data['name'].toString() + ' :',
              style: TextStyle(fontSize: width * 24, color: placeHolder),
            ),
            width: width * 260,
            margin: EdgeInsets.symmetric(vertical: width * 10),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextField(
                controller: TextEditingController(),
                onChanged: (value) {
                  if (tempIndex.length != 5) tempIndex.add(0);
                  tempIndex[4] = screenIndex;
                  if (widget.index != null) {
                    _context.changeSmallTicket(tempIndex, value,
                        type: 'table|' + select.toString());
                  }
                },
                style: TextStyle(fontSize: width * 24),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: imgValueArr[select] != ''
                        ? imgValueArr[select]
                        : '请输入内容')),
            padding: EdgeInsets.symmetric(horizontal: width * 20),
          )
        ],
      ),
    );

    return _widget;
  }

  _generateSign(width, data, _context, tempIndex, screenIndex, {select}) {
    _judgeImag() {
      Widget _widget;
      // print(widget.data['tableTitle'][screenIndex]);
      String temp = widget.data['tableTitle'][screenIndex]['value'];
      String severId =
          temp.toString().substring(temp.toString().indexOf('-') + 1);
      List imgValueArr = severId.split('|');

      if (select >= imgValueArr.length) {
        for (int i = 0; i < imgValueArr.length; i++) {
          if (select >= imgValueArr.length) {
            imgValueArr.add('');
          }
        }
      }
      _widget = imgValueArr[select].toString().indexOf('http') > -1
          ? Image(
              image: NetworkImage(imgValueArr[select]),
              height: width * 160,
            )
          : Container();

      return _widget;
    }

    Widget _widget;
    _widget = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border(bottom: BorderSide(width: 1, color: underColor)),
      ),
      padding:
          EdgeInsets.symmetric(vertical: width * 0, horizontal: width * 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: width * 260,
            child: Text(data['name'] + ':',
                style: TextStyle(fontSize: width * 24, color: placeHolder)),
            margin: EdgeInsets.symmetric(vertical: width * 10),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                if (tempIndex.length != 5) {
                  tempIndex.add(0);
                }
                tempIndex[4] = screenIndex;
                Navigator.pushNamed(context, '/sign', arguments: {
                  'index': tempIndex,
                  'name': widget.name,
                  'title': data['name'],
                  "names": data['name'],
                  "type": 'table',
                  "tableIndex": select,
                  "callback": _judgeIsLoad,
                });
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: width * 160),
                    width: double.infinity,
                    child: _judgeImag(),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: underColor),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    child: Icon(
                      Icons.create,
                      color: placeHolder,
                      size: width * 30,
                    ),
                    bottom: 20,
                    right: 20,
                  ),
                ],
              ))
        ],
      ),
    );
    return _widget;
  }

  _initShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final _context = Provider.of<Counter>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                width: size.width * 10,
                height: size.width * 10,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(63, 224, 175, 1),
                    shape: BoxShape.circle),
              ),
              SizedBox(
                width: size.width * 10,
              ),
              Text(
                widget.title,
                style:
                    TextStyle(color: titleColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: size.width * 10,
              ),
              Expanded(
                  child: Text(
                widget.memo,
                style: TextStyle(
                  fontSize: size.width * 20,
                  color: Color.fromRGBO(180, 180, 180, 1),
                  // color: Colors.black,
                ),
              ))
            ],
          ),
          margin: EdgeInsets.only(
              left: size.width * 35,
              top: size.width * 35,
              bottom: size.width * 20),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tableList.asMap().keys.map<Widget>((m) {
              return Container(
                child: Column(
                  children:
                      widget.data['tableTitle'].asMap().keys.map<Widget>((n) {
                    Widget name;
                    switch (widget.data['tableTitle'][n]['valueType']) {
                      case 'dateTime':
                        List index = [];
                        tempIndex.forEach((element) {
                          index.add(element);
                        });
                        if (index.length != 5) {
                          index.add(n);
                        }
                        index[4] = n;
                        String temp = widget.data['tableTitle'][n]['value'];
                        String severId = temp
                            .toString()
                            .substring(temp.toString().indexOf('-') + 1);
                        List imgValueArr = severId.split('|');
                        name = MychooseTime(
                            showTitle: false,
                            name: widget.name,
                            title: widget.data['tableTitle'][n]['name'],
                            index: index,
                            type: 'table',
                            placeholder: m <= imgValueArr.length - 1
                                ? imgValueArr[m] == ''
                                    ? null
                                    : imgValueArr[m]
                                : null,
                            tableIndex: m);
                        break;
                      case 'input':
                        name = _generateInput(
                            size.width,
                            widget.data['tableTitle'][n],
                            _context,
                            tempIndex,
                            n,
                            select: m);
                        break;
                      case 'sign':
                        name = _generateSign(
                            size.width,
                            widget.data['tableTitle'][n],
                            _context,
                            tempIndex,
                            n,
                            select: m);
                        break;
                      case 'select':
                        List index = [];
                        tempIndex.forEach((element) {
                          index.add(element);
                        });
                        if (index.length != 5) {
                          index.add(n);
                        }
                        index[4] = n;
                        String temp = widget.data['tableTitle'][n]['value'];
                        String severId = temp
                            .toString()
                            .substring(temp.toString().indexOf('-') + 1);
                        List imgValueArr = severId.split('|');
                        name = MyDrop(
                          showTitle: false,
                          title: widget.data['tableTitle'][n]['name'],
                          index: index,
                          name: widget.name,
                          data: widget.data['tableTitle'][n]['selectList'],
                          type: 'table',
                          placeHolder: m <= imgValueArr.length - 1
                              ? imgValueArr[m] == ''
                                  ? null
                                  : imgValueArr[m]
                              : null,
                          tableIndex: m,
                          callSetstate: () {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        );
                        break;
                      // case 'checkbox':
                      //   name = MutipleDrop(
                      //       showTitle: false,
                      //       title:
                      //           widget.data['tableTitle'][n]['name'].toString(),
                      //       index: index,
                      //       name: widget.name,
                      //       type: 'table',
                      //       data: widget.data['tableTitle'][n]['selectList'],
                      //       tableIndex: m);
                      //   break;
                      default:
                        name = Text(
                            widget.data['tableTitle'][n]['name'].toString() +
                                widget.data['tableTitle'][n]['valueType']
                                    .toString() +
                                '功能暂未开发，请联系管理员');
                    }
                    return name;
                  }).toList(),
                ),
              );
            }).toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                tableList.add(0);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.all(20),
                decoration:
                    BoxDecoration(color: themeColor, shape: BoxShape.circle),
                child: Icon(
                  Icons.add,
                  size: size.width * 60,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
