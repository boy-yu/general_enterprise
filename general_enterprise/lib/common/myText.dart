import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myCustomColor.dart';

class MyText extends StatefulWidget {
  MyText({
    this.title,
    this.value,
    this.line = 3,
    this.type = 'input',
    this.dataList,
    this.tableTitle,
    this.signValue,
  });
  final String title;
  final String value, type;
  final int line;
  // dataList => sign data  table value
  // tableTitle => table data
  final List dataList, tableTitle, signValue;
  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  GlobalKey _globalKey = GlobalKey();
  double currentWidth = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentWidth = _globalKey.currentContext.size.width;
      if (mounted) {
        setState(() {});
      }
    });
  }

  List signArr = [];
  _judgeType(_context) {
    Widget _widget;
    switch (widget.type) {
      case 'sign':
        _widget = Column(
          children: widget.dataList.map<Widget>((ele) {
            Widget __widget;

            __widget = Column(
                children: ele['signList'].map<Widget>((_ele) {
              Widget ___widget;
              String temp = _ele['value'];
              String value = temp.substring(temp.indexOf('-') + 1);
              if (value == '') {
                widget.signValue.forEach((element) {
                  if (element['matchField'] == _ele['matchField']) {
                    // print(element['value'].toString());
                    value = element['value']
                        .toString()
                        .substring(temp.indexOf('-') + 1);
                  }
                });
              }
              ___widget = Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: underColor))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 40,
                          vertical: size.width * 20),
                      child: Text(_ele['name'].toString() + " : "),
                    )),
                    Column(
                      children: value.toString().split('|').map((__ele) {
                        return __ele != ''
                            ? Image.network(
                                __ele.toString().indexOf('http:') > -1
                                    ? Interface.fileUrl + __ele
                                    : __ele,
                                height: size.width * 160,
                              )
                            : Container();
                      }).toList(),
                    )
                  ],
                ),
              );
              return ___widget;
            }).toList());
            return __widget;
          }).toList(),
        );
        break;
      case 'images':
        List<String> values = [];
        if (widget.value != null) {
          values = widget.value.split('|');
        }
        _widget = Wrap(
          children: values.map((ele) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: ele == '' || ele == null
                  ? Image.network(
                      ele.toString().indexOf('http:') > -1
                          ? Interface.fileUrl + ele
                          : ele,
                      width: size.width * 200,
                    )
                  : Container(),
            );
          }).toList(),
        );
        // _widget = Text('data');
        break;
      case 'table':
        String temp = widget.tableTitle[0]['value'];
        String values = temp.substring(temp.indexOf('-') + 1);
        // print(temp);
        _widget = Column(
          children: values.split('|').asMap().keys.map<Widget>((i) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.tableTitle.map<Widget>((ele) {
                  String temps = ele['value'];
                  List value =
                      temps.substring(temp.indexOf('-') + 1).split('|');
                  String assginValue = '';
                  if (value.length - 1 < i)
                    assginValue = ele['name'] + '为空';
                  else {
                    assginValue = value[i];
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          ele['name'] + " : ",
                          style: TextStyle(color: placeHolder),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 40,
                            vertical: size.width * 10),
                      ),
                      ele['valueType'] == 'sign'
                          ? Expanded(
                              child: Image.network(
                              assginValue.toString().indexOf('http:') > -1
                                  ? Interface.fileUrl + assginValue
                                  : assginValue,
                            ))
                          : Padding(
                              padding: EdgeInsets.only(right: size.width * 40),
                              child: Text(assginValue)),
                    ],
                  );
                }).toList());
          }).toList(),
        );

        break;
      default:
        _widget = Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Text(
            widget.value == null
                ? widget.title.toString() + '为空'
                : widget.value,
            style: TextStyle(
                fontSize: size.width * 28,
                color: widget.value == null || widget.value == ''
                    ? placeHolder
                    : Colors.black),
          ),
          padding: EdgeInsets.symmetric(vertical: size.width * 20),
        );
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return Row(
      key: _globalKey,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(fontSize: size.width * 30),
        ),
        currentWidth > 0 ? _judgeType(_context) : Container(),
      ],
    );
  }
}
