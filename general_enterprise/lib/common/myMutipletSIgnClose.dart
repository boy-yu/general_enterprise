import 'package:enterprise/common/myInput.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myCustomColor.dart';
// import 'myFileImage.dart';

class MyMutipleSignClose extends StatefulWidget {
  MyMutipleSignClose(
      {this.title,
      this.name,
      this.value,
      this.index,
      this.dataList,
      this.placeHolder,
      this.purview,
      this.memo = '',
      this.type = -1,
      this.execution = 0,
      this.clickName});
  final index;
  final String title, purview, name, memo;
  final String value;
  final List dataList;
  final placeHolder;
  final int clickName, execution, type;
  // type is  0 => clickName sign
  @override
  _MyMutipleSignCloseState createState() => _MyMutipleSignCloseState();
}

class _MyMutipleSignCloseState extends State<MyMutipleSignClose> {
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _initShared();
  }

  _initShared() async {
    prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('username'));
  }

  _generateImg(data, width, Counter _counter,
      {screenIndex = -1, mutipleIndex = -1}) {
    Widget _widget;
    if (widget.placeHolder == null) {
      if (data != '' && data.indexOf('http') > -1) {
        String temp = data;
        String severId = temp.substring(temp.indexOf('-') + 1);
        List signSplit = severId.split('|');
        if (mutipleIndex >= signSplit.length) {
          for (var i = 0; i < mutipleIndex; i++) {
            if (i >= signSplit.length - 1) {
              signSplit.add('');
            }
          }
        }
        _widget = signSplit[mutipleIndex].toString().indexOf('http') > -1
            ? Image(
                image: NetworkImage(signSplit[mutipleIndex].toString()),
                height: width * 160,
              )
            : Container();
      } else {
        _widget = Container();
      }
    } else {
      _widget = Expanded(
          child: Image(
              image: NetworkImage(widget.placeHolder.toString()),
              height: width * 160,
              width: width * 300));
    }
    return _widget;
  }

  _generateInput({
    String title,
    String name,
    List index,
    String value,
  }) {
    Widget _widget;
    String temp = value;
    String severValue = temp.substring(temp.indexOf('-') + 1);
    if (severValue == '') severValue = null;
    _widget = MyInput(
      title: title,
      name: name,
      index: index,
      submitName: 'inputValue',
      placeHolder: severValue,
    );
    return _widget;
  }

  _judgeIsLoad() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: widget.dataList.asMap().keys.map((i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.dataList[i]['signList']
                      .asMap()
                      .keys
                      .map<Widget>((n) {
                    int editLevel = int.parse(
                        widget.dataList[i]['signList'][n]['editLevel']);
                    List tempIndex = [];
                    widget.index.forEach((i) {
                      tempIndex.add(i);
                    });
                    tempIndex.add(i);
                    tempIndex.add('signList');
                    tempIndex.add(n);
                    List signArr = widget.dataList[i]['signList'][n]['value']
                        .toString()
                        .split('|');
                    return editLevel == widget.clickName
                        ? widget.execution == editLevel
                            ? SignMutiple(
                                data: widget.dataList[i]['signList'][n],
                                title: widget.title,
                                name: widget.name,
                                generateInput: _generateInput,
                                tempIndex: tempIndex,
                                purview: widget.purview,
                                n: n,
                                generateImg: _generateImg,
                                isLoad: _judgeIsLoad,
                              )
                            //  just show
                            : widget.dataList[i]['signList'][n]['isshow'] !=
                                    false
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: size.width * 10,
                                              height: size.width * 10,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      63, 224, 175, 1),
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: size.width * 10,
                                            ),
                                            Text(
                                              widget.title,
                                              style: TextStyle(
                                                  color: titleColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: size.width * 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                              widget.memo,
                                              style: TextStyle(
                                                fontSize: size.width * 20,
                                                color: Color.fromRGBO(
                                                    180, 180, 180, 1),
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
                                      widget.dataList[i]['signList'][n]
                                                  ['isAddInput'] !=
                                              "0"
                                          ? _generateInput(
                                              title: widget.dataList[i]
                                                  ['signList'][n]['inputName'],
                                              name: widget.name,
                                              index: tempIndex,
                                              value: widget.dataList[i]
                                                  ['signList'][n]['inputValue'])
                                          : Container(),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Colors.black
                                                      .withOpacity(0.1)),
                                            )),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.width * 8,
                                                  right: size.width * 5),
                                              child: Icon(
                                                Icons.grade,
                                                size: size.width * 20,
                                                color: Color.fromRGBO(
                                                    255, 126, 126, 1),
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              widget.dataList[i]['signList'][n]
                                                      ['text']
                                                  .toString(),
                                              style:
                                                  TextStyle(color: placeHolder),
                                            ))
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 30,
                                            vertical: size.width * 44),
                                      ),
                                      Column(
                                        children: signArr
                                            .asMap()
                                            .keys
                                            .map<Widget>((signIndex) {
                                          return Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        widget.dataList[i]
                                                                ['signList'][n]
                                                                ['name']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 24,
                                                            color: titleColor),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        DateTime.now()
                                                            .toString()
                                                            .substring(
                                                                0,
                                                                DateTime.now()
                                                                        .toString()
                                                                        .length -
                                                                    10),
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width * 24,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          size.width * 160),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: underColor)),
                                                  margin: EdgeInsets.all(
                                                      size.width * 20),
                                                  child: _generateImg(
                                                      widget.dataList[i]
                                                              ['signList'][n]
                                                          ['value'],
                                                      size.width,
                                                      _context,
                                                      screenIndex: n,
                                                      mutipleIndex: signIndex),
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 30,
                                                vertical: size.width * 44),
                                          );
                                        }).toList(),
                                      )
                                    ],
                                  )
                                : Container()
                        : Container();
                  }).toList(),
                )
              ],
            );
            // : Container();
          }).toList(),
        ),
      ],
    );
  }
}

class SignMutiple extends StatefulWidget {
  SignMutiple(
      {this.title,
      this.data,
      this.name,
      this.generateInput,
      this.tempIndex,
      this.purview,
      this.n,
      this.generateImg,
      this.isLoad});
  final title, data, name, tempIndex, purview;
  final int n;
  final Function generateInput, generateImg, isLoad;
  @override
  _SignMutipleState createState() => _SignMutipleState();
}

class _SignMutipleState extends State<SignMutiple> {
  List signArr = [0];
  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return widget.data['isshow'] != false
        ? Column(
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
                      style: TextStyle(
                          color: titleColor, fontWeight: FontWeight.bold),
                    ),
                    // Text(data)
                  ],
                ),
                margin: EdgeInsets.only(
                    left: size.width * 35,
                    top: size.width * 35,
                    bottom: size.width * 20),
              ),
              widget.data['isAddInput'] != "0"
                  ? widget.generateInput(
                      title: widget.data['inputName'],
                      name: widget.name,
                      index: widget.tempIndex,
                      value: widget.data['inputValue'])
                  : Container(),
              widget.data['text'].toString() != ''
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Colors.black.withOpacity(0.1)))),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 8, right: size.width * 5),
                            child: Icon(
                              Icons.grade,
                              size: size.width * 20,
                              color: Color.fromRGBO(255, 126, 126, 1),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            widget.data['text'].toString(),
                            style: TextStyle(color: placeHolder),
                          ))
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 30,
                          vertical: size.width * 44),
                    )
                  : Container(),
              Column(
                children: signArr.asMap().keys.map<Widget>((signIndex) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign', arguments: {
                        'names': widget.data['name'],
                        "purview": widget.purview,
                        'name': widget.name,
                        'title': widget.title + widget.n.toString(),
                        'index': widget.tempIndex,
                        'type': 'table',
                        'tableIndex': signIndex,
                        'callback': widget.isLoad
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                widget.data['name'].toString(),
                                style: TextStyle(
                                    color: titleColor,
                                    fontSize: size.width * 24),
                              )),
                              Text(
                                DateTime.now().toString().substring(
                                    0, DateTime.now().toString().length - 10),
                                style: TextStyle(fontSize: size.width * 24),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(size.width * 20),
                                constraints:
                                    BoxConstraints(minHeight: size.width * 160),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: underColor)),
                                width: double.infinity,
                                child: widget.generateImg(
                                    widget.data['value'], size.width, _context,
                                    screenIndex: widget.n,
                                    mutipleIndex: signIndex),
                              ),
                              Positioned(
                                child: Icon(
                                  Icons.create,
                                  color: placeHolder,
                                  size: size.width * 30,
                                ),
                                bottom: 20,
                                right: 20,
                              ),
                              signArr.length > 1
                                  ? Positioned(
                                      right: 20,
                                      top: 20,
                                      child: GestureDetector(
                                        onTap: () {
                                          signArr.removeAt(signIndex);
                                          _context.changeSmallTicket(
                                            widget.tempIndex,
                                            '',
                                            type: 'remove|' +
                                                signIndex.toString(),
                                          );
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ))
                                  : Container()
                            ],
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 30,
                          vertical: size.width * 44),
                    ),
                  );
                }).toList(),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    signArr.add(0);
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(size.width * 20),
                    decoration: BoxDecoration(
                        color: themeColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: size.width * 60,
                    ),
                    width: size.width * 80,
                    height: size.width * 80,
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}
