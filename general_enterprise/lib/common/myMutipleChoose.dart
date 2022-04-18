import 'package:enterprise/common/customChoose.dart';
// import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
import '../common/myCustomColor.dart';
import '../tool/interface.dart';

// dropbutton choose
// title : first title
// placeHolder: choose => placeHolder
// index:  only key
// name
class MutipleDrop extends StatefulWidget {
  MutipleDrop(
      {this.title,
      this.data,
      this.placeHolder,
      this.index,
      this.onPress,
      this.purview,
      this.dataUrl,
      this.type,
      this.memo = '',
      this.tableIndex,
      this.showTitle = true});
  final List data;
  final placeHolder, title, index, onPress, purview, dataUrl;
  final bool showTitle;
  final String type, memo;
  final int tableIndex;
  @override
  _MutipleDropState createState() => _MutipleDropState();
}

class _MutipleDropState extends State<MutipleDrop> {
  List<int> seleted = [];
  String msg = '';
  List ownDate = [];

  _getDropDate() {
    var _value;
    switch (widget.index) {
      case 'apply/unit':
        _value = 1;
        break;
      case 'apply/area':
        _value = 2;
        break;
      case 'apply/guardian':
        break;
      case 'license/unit':
        _value = 1;
        break;
      case 'license/dependency':
        _value = 3;
        break;
      default:
        _value = widget.dataUrl;
    }
    if (_value is int) {
      myDio
          .request(
        type: 'get',
        url: Interface.workBaseInfoUrl + '/' + _value.toString(),
      )
          .then((value) {
        setState(() {
          ownDate = value;
        });
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    } else if (_value == 'workTypeList') {
      myDio
          .request(
        type: 'get',
        url: Interface.workTypeList,
      )
          .then((value) {
        setState(() {
          ownDate = value;
        });
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    } else {
      // print(widget.data);
      seleted = [];
      ownDate = widget.data;
      if (widget.placeHolder != null) {
        List tempSpilt = widget.placeHolder.toString().split('|');
        for (var i = 0; i < ownDate.length; i++) {
          tempSpilt.forEach((temp) {
            if (temp == ownDate[i]['name'].toString()) {
              seleted.add(i);
            }
          });
        }
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  _judgeText() {
    Widget _widget;
    if (msg != '') {
      _widget = Text(
        msg,
        style: TextStyle(color: msg == '' ? placeHolder : Colors.black),
      );
    } else {
      if (widget.placeHolder == null) {
        _widget = Text(
          '请选择' + widget.title,
          style: TextStyle(
              color: msg == '' ? placeHolder : Colors.black,
              fontSize: size.width * 28),
        );
      } else {
        _widget = Text(
          widget.placeHolder.toString(),
          style: TextStyle(color: Colors.black),
        );
      }
    }

    return _widget;
  }

  @override
  void initState() {
    super.initState();
    _getDropDate();
  }

  @override
  Widget build(BuildContext context) {
    // final _context = Provider.of<Counter>(context);
    return Row(
      children: <Widget>[
        widget.showTitle
            ? Row(
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: size.width * 30),
                  ),
                  SizedBox(
                    width: size.width * 10,
                  ),
                ],
              )
            : Container(),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: _judgeText(),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (ownDate.length > 0) {
                showBottomSheet(
                    context: context,
                    builder: (context) => CustomChoose(
                          ownData: ownDate,
                          callback: () {},
                        ));
              } else {
                Fluttertoast.showToast(
                    msg: '请在PC端配置' + widget.title.toString());
              }
            },
          ),
        ),
        Icon(Icons.keyboard_arrow_right)
      ],
    );
  }
}
