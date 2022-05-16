import 'package:enterprise/common/customChoose.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/myCustomColor.dart';
import '../tool/interface.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'myCount.dart';
import 'myInput.dart';

// dropbutton choose
// title : names
// placeHolder: choose => placeHolder
// purview: only key
class MyDrop extends StatefulWidget {
  MyDrop({
    this.title,
    this.placeHolder,
    this.index,
    this.name,
    this.data,
    this.type,
    this.memo = '',
    this.tableIndex,
    this.dataUrl,
    this.showTitle = true,
    this.purview,
    this.bindKey,
    @required this.callSetstate,
  });
  // type table  tableIndex resolve table assgin program
  final placeHolder,
      title,
      index,
      name,
      data,
      purview,
      type,
      showTitle,
      tableIndex;
  final String bindKey, dataUrl;
  final String memo;
  final Function callSetstate;
  @override
  _MyDropState createState() => _MyDropState();
}

class _MyDropState extends State<MyDrop> {
  String msg = '';
  GlobalKey<_ShowPopState> _globalKey = GlobalKey();
  _changeMsg(String msgs) {
    msg = msgs;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  widget.title.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: size.width * 30),
                ),
                SizedBox(
                  width: size.width * 10,
                )
              ],
            ),
          ),
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Text(
              msg == ''
                  ? widget.placeHolder == null
                      ? '请选择' + widget.title.toString()
                      : widget.placeHolder
                  : msg,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: msg == ''
                    ? widget.placeHolder == null
                        ? placeHolder
                        : Colors.black
                    : Colors.black,
                fontSize: size.width * 28,
              ),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              showModalBottomSheet(
                  context: context,
                  builder: (_) => Padding(
                        padding: EdgeInsets.all(size.width * 20),
                        child: ShowPop(
                          globalKey: _globalKey,
                          data: widget.data,
                          dataUrl: widget.dataUrl,
                          purview: widget.purview,
                          title: widget.title,
                          index: widget.index,
                          type: widget.type,
                          tableIndex: widget.tableIndex,
                          showMsg: _changeMsg,
                          bindKey: widget.bindKey,
                          callSetstate: widget.callSetstate,
                        ),
                      ));
            },
          )),
          Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}

class ShowPop extends StatefulWidget {
  final purview;
  final title;
  final String dataUrl, bindKey;
  final data;
  final index, type, tableIndex;
  final GlobalKey globalKey;
  final Function showMsg, callSetstate;
  ShowPop(
      {this.globalKey,
      this.dataUrl,
      this.data,
      this.purview,
      this.title,
      this.index,
      this.type,
      this.tableIndex,
      this.showMsg,
      this.bindKey,
      this.callSetstate})
      : super(key: globalKey);
  @override
  _ShowPopState createState() => _ShowPopState();
}

class _ShowPopState extends State<ShowPop> {
  int seleted = -1, addtionSeleted = -1;
  String msg = '';
  List ownDate = [];
  List tempData = [];

  @override
  void initState() {
    super.initState();
    _getDropDate();
  }

  _updateSeleted(int index, String msgs) {
    seleted = index;
    msg = msgs;
    if (mounted) {
      setState(() {});
    }
  }

  _getDropDate() {
    if (widget.dataUrl != null) {
      myDio.request(type: 'get', url: widget.dataUrl).then((value) {
        ownDate = value;
        if (mounted) {
          setState(() {});
        }
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    } else if (widget.data != null && widget.data.length > 0) {
      ownDate = widget.data;
      if (mounted) {
        setState(() {});
      }
    }
  }

  _updataIndex(int index, String msgs) {
    setState(() {
      addtionSeleted = index;
      msg = msgs;
    });
  }

  _onChange(value) {
    msg = value;
  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    Counter _context = Provider.of<Counter>(context);
    return Container(
      height: sizes.height - 80,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: CustomChoose(
                  msg: msg,
                  ownData: ownDate,
                  seleted: seleted,
                  type: CustomChooseType.drop,
                  callback: _updateSeleted)),
          seleted > -1
              ? ownDate[seleted]['addtion'] != null
                  ? Addtion(
                      ownDate[seleted]['addtion'], _updataIndex, _onChange)
                  : Container()
              : Container(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size.width * 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: lineGradBlue),
              ),
              child: Center(
                child: Text(
                  '确定',
                  // textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: size.width * 28, color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {});
              }
              if (tempData.length > 0) {
                if (seleted > -1) {
                  if (ownDate[seleted]['addtion']['type'] == 'input') {
                    _context.changeSubmitDates(
                        widget.purview,
                        {
                          "title": widget.title,
                          "value": msg,
                          'id': 0,
                          "bindKey": widget.bindKey
                        },
                        callBack: widget.callSetstate);
                  } else {
                    _context.changeSubmitDates(widget.purview, {
                      "title": widget.title,
                      "value": msg,
                      'id': tempData[addtionSeleted]['id'],
                      "bindKey": widget.bindKey,
                    }, callBack: (onError) {
                      Interface().error(onError, context);
                    });
                  }
                }
              } else {
                _context.changeSubmitDates(
                    widget.purview,
                    {
                      "title": widget.title,
                      "value": msg,
                      'id': ownDate[seleted]['id'],
                      "bindKey": widget.bindKey,
                    },
                    callBack: widget.callSetstate);
              }
              if (widget.index != null) {
                _context.changeSmallTicket(widget.index, msg,
                    type: widget.type == 'table'
                        ? widget.type.toString() +
                            '|' +
                            widget.tableIndex.toString()
                        : null);
              }
              widget.showMsg(msg);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class Addtion extends StatefulWidget {
  Addtion(this.data, this.updataIndex, this.onChange);
  final data;
  final Function updataIndex, onChange;
  @override
  _AddtionState createState() => _AddtionState();
}

class _AddtionState extends State<Addtion> {
  int addtionSeleted;
  String msg = '';
  List tempData = [];
  Widget _widget;
  String oldTitle = '';

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldTitle != widget.data['title']) {
      oldTitle = widget.data['title'];
      _getData();
    }
  }

  @override
  void initState() {
    super.initState();
    oldTitle = widget.data['title'];
    _getData();
  }

  _getData() {
    myDio.request(type: 'get', url: widget.data['dataUrl']).then((value) {
      tempData = value;
      switch (widget.data['type']) {
        case 'input':
          _widget = Expanded(
              child: MyInput(
                  title: widget.data['title'], onChange: widget.onChange));
          break;
        case 'choose':
          _widget = Expanded(
              child: CustomChoose(
            msg: msg,
            ownData: tempData,
            seleted: addtionSeleted,
            type: CustomChooseType.drop,
            callback: widget.updataIndex,
          ));
          break;
        default:
          _widget = Text(widget.data['title'].toString());
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return tempData.length > 0 ? _widget : Container();
  }
}
