import 'dart:convert';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myText.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  History({this.arguments});
  final arguments;
  // id prve pages id
  // type 作业详情 => detail
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List data = [];
  @override
  void initState() {
    super.initState();
    _getDate();
  }

  List signArr = [];

  _recursionSign(data) {
    if (data is List) {
      data.forEach((element) {
        _recursionSign(element);
      });
    } else if (data is Map) {
      data.forEach((key, value) {
        // print(data[key] is List);
        if (key == 'matchField') {
          bool isAdd = true;
          signArr.forEach((_element) {
            if (_element['matchField'] == value) {
              isAdd = false;
            }
          });
          if (isAdd) {
            signArr.add({'matchField': value, 'value': data['value']});
          }
        } else if (data[key] is List || data[key] is Map) {
          _recursionSign(value);
        }
      });
    }
  }

  _getDate() {
    String id = widget.arguments['id'].toString();
    if (widget.arguments['type'] != null) {
      String url = '';
      if (widget.arguments['type'] == '作业详情') {
        url = Interface.getWorkDetailUrl;
      } else if (widget.arguments['type'] == '审批详情') {
        url = Interface.getWorkTypeDetailUrl;
      }
      if (url != '') {
        myDio.request(type: 'get', url: url + '/' + id).then((value) {
          if (value != null) {
            data = value;
            setState(() {});
          }
        }).catchError((onError) {
          Interface().error(onError, context);
        });
      }
    }
    // else if (widget.arguments['type'] == '审批详情') {}

    else {
      // history
      myDio
          .request(type: 'get', url: Interface.lookTicketUrl + '/' + id)
          .then((value) {
        if (value != null) {
          data = jsonDecode(value['appData']);
          _recursionSign(data);
          // _recursionSubmit(widget.arguments['context']);
          setState(() {});
        }
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      backgroundColor: Colors.white,
      title: Text(widget.arguments['type'] != null
          ? widget.arguments['type'].toString()
          : '历史作业'),
      child: SingleChildScrollView(
        child: Column(
          children: data.map((ele) {
            return Column(children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  ele['name'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: themeColor, fontSize: width * 30),
                ),
                padding: EdgeInsets.symmetric(vertical: width * 20),
              ),
              Column(
                  children: ele['workList'].map<Widget>((_ele) {
                Widget _widget;
                // print(_ele['valueType']);
                switch (_ele['valueType']) {
                  case 'images':
                    String temp = _ele['value'];
                    String value = temp.substring(temp.indexOf('-') + 1);
                    if (value == '') value = null;
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      value: value,
                      type: 'images',
                    );
                    break;
                  case 'input':
                    String temp = _ele['value'];
                    String value = temp.substring(temp.indexOf('-') + 1);
                    if (value == '') value = null;
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      value: value,
                    );
                    break;
                  case 'checkbox':
                    String temp = _ele['value'];
                    String value = temp.substring(temp.indexOf('-') + 1);
                    if (value == '') value = null;
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      value: value,
                    );
                    break;
                  case 'sign':
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      type: 'sign',
                      dataList: _ele['dataList'],
                      signValue: signArr,
                    );
                    break;
                  case 'timePart':
                    String temp = _ele['value'];
                    String value = temp.substring(temp.indexOf('-') + 1);
                    if (value == '') value = null;
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      value: value,
                    );
                    break;
                  case 'select':
                    String temp = _ele['value'];
                    String value = temp.substring(temp.indexOf('-') + 1);
                    if (value == '') value = null;
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      value: value,
                    );
                    break;
                  case 'table':
                    _widget = MyText(
                      title: _ele['name'].toString(),
                      type: 'table',
                      tableTitle: _ele['tableTitle'],
                    );
                    break;
                  default:
                    _widget = Text(_ele['name'].toString() + '暂未开发');
                }
                return _widget;
              }).toList())
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
