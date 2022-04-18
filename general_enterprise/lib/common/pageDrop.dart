import 'package:enterprise/common/customChoose.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import '../common/myCustomColor.dart';
import '../tool/interface.dart';
import 'myInput.dart';

// dropbutton choose
// title : names
// placeHolder: choose => placeHolder
// purview: only key
class PageDrop extends StatefulWidget {
  PageDrop({
    this.title = '',
    this.placeHolder = '',
    this.index,
    this.name,
    this.data,
    this.type,
    this.memo = '',
    this.tableIndex,
    this.dataUrl,
    this.showTitle = true,
    this.bindKey,
    @required this.callSetstate,
    this.queryParameters,
    this.ontap,
  });
  // type table  tableIndex resolve table assgin program
  final index, name, type, showTitle, tableIndex;
  final String bindKey, dataUrl, title, placeHolder;
  final String memo;
  final List data;
  final dynamic queryParameters;
  final Function(dynamic data) callSetstate;
  final Function ontap;
  @override
  _PageDropState createState() => _PageDropState();
}

class _PageDropState extends State<PageDrop> {
  String msg = '';
  _changeMsg(String msgs) {
    msg = msgs;
    if (mounted) {
      setState(() {});
    }
  }

  bool isShowPop = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (widget.ontap is Function) {
          widget.ontap();
        }
        showBottomSheet(
            context: context,
            builder: (_) => Padding(
                padding: EdgeInsets.all(size.width * 20),
                child: ShowPop(
                    data: widget.data ?? [],
                    dataUrl: widget.dataUrl,
                    title: widget.title,
                    index: widget.index,
                    type: widget.type,
                    queryParameters: widget.queryParameters,
                    showMsg: _changeMsg,
                    callSetstate: widget.callSetstate)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text(widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 30,
                            color: Colors.black))),
                msg == '' && widget.placeHolder == ''
                    ? Expanded(
                        child: Text(
                          '请选择',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: placeHolder,
                            fontSize: size.width * 28,
                          ),
                        ),
                      )
                    : Container(),
                Icon(Icons.keyboard_arrow_right, color: Colors.black87),
              ],
            ),
            Text(msg == '' ? widget.placeHolder : msg,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.width * 26,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class ShowPop extends StatefulWidget {
  final title;
  final String dataUrl;
  final List data;
  final int index;
  final CustomChooseType type;
  final dynamic queryParameters;
  final Function(String str) showMsg;
  final Function(dynamic data) callSetstate;
  ShowPop(
      {this.dataUrl,
      this.data,
      this.title,
      this.index,
      this.type = CustomChooseType.drop,
      @required this.showMsg,
      @required this.callSetstate,
      this.queryParameters});
  @override
  _ShowPopState createState() => _ShowPopState();
}

class _ShowPopState extends State<ShowPop> {
  int seleted = -1, addtionSeleted = -1;
  String msg = '';
  List ownDate = [];
  List tempData = [];
  TextEditingController _editingController = TextEditingController();
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
    if (widget.dataUrl != null && widget.data.isEmpty) {
      myDio
          .request(
              type: 'get',
              url: widget.dataUrl,
              queryParameters: widget.queryParameters)
          .then((value) {
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

  _secherPeople(String str) {
    widget.queryParameters["keyword"] = str;
    seleted = -1;
    myDio
        .request(
            type: 'get',
            url: widget.dataUrl,
            queryParameters: widget.queryParameters)
        .then((value) {
      ownDate = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Container(
      height: sizes.height - 80,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.width * 76,
            margin: EdgeInsets.fromLTRB(size.width * 40, size.width * 30,
                size.width * 40, size.width * 5),
            decoration: BoxDecoration(
                color: Color(0xffFAFAFB),
                borderRadius: BorderRadius.circular(50),
                border:
                    Border.all(color: placeHolder.withOpacity(.2), width: 2)),
            child: TextField(
              controller: _editingController,
              textInputAction: TextInputAction.search,
              onChanged: _secherPeople,
              onSubmitted: _secherPeople,
              maxLines: 1,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        _secherPeople(_editingController.text);
                      }),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                      size.width * 40, 0, size.width * 40, size.width * 22),
                  hintText: '搜索',
                  hintStyle: TextStyle(color: Color(0xffACACBC))),
            ),
          ),
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
                  style:
                      TextStyle(fontSize: size.width * 28, color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {});
              }
              widget.callSetstate(ownDate[seleted]);
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
