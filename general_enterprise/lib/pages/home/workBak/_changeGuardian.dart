import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myConfirmDialog.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../tool/interface.dart';

class Guardian extends StatefulWidget {
  Guardian({this.arguments});
  final arguments;
  @override
  _GuardianState createState() => _GuardianState();
}

class _GuardianState extends State<Guardian> {
  int iconClick = -1;
  double opctity = 1.0;
  List treeData = [];
  TextEditingController textControl;
  @override
  void initState() {
    super.initState();
    // _getTreeDate();
  }

  _searchPeople(String keywords) {
    myDio
        .request(type: 'get', url: Interface.getSearchPeople, queryParameters: {
      "keywords": keywords
      // "workUnit": '公司'
    }).then((value) {
      if (value != null) {
        treeData = value;
      }
      setState(() {});
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    Counter _context = Provider.of<Counter>(context);
    return MyAppbar(
      title: Text(widget.arguments['type'].toString()),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(width * 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.white)),
            child: TextField(
              style: TextStyle(fontSize: width * 26),
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.symmetric(vertical: width * 0),
                border: InputBorder.none,
                hintText: '请输入搜索姓名',
                prefixIcon: Icon(Icons.search),
              ),
              controller: textControl,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                _searchPeople(value);
                _context.changeGuardianSearch(value);
              },
            ),
          ),
          treeData.length == 0
              ? Column(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: width * 100,
                      color: themeColor,
                    ),
                    Text('抱歉，没有发现的相关内容 \n 换个关键词试试吧'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '搜索历史',
                            style: TextStyle(
                                fontSize: width * 28,
                                fontWeight: FontWeight.bold),
                          ),
                          margin: EdgeInsets.only(left: width * 40),
                        ),
                        GestureDetector(
                          onTap: () {
                            _context.emptyGuardianSearch(callback: () {
                              setState(() {});
                            });
                          },
                          child: Container(
                            child: Icon(Icons.restore_from_trash),
                            margin: EdgeInsets.only(right: width * 40),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 3,
                            crossAxisSpacing: width * 10,
                            mainAxisSpacing: width * 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _searchPeople(_context.guardianSearch[index]);
                            },
                            child: Center(
                              child: Container(
                                child: Text(_context.guardianSearch[index]),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 10,
                                    vertical: width * 5),
                              ),
                            ),
                          );
                        },
                        itemCount: _context.guardianSearch.length,
                      ),
                      height: 200,
                    ),
                  ],
                )
              : Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: width * 40,
                            right: width * 40,
                            top: width * 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 40, vertical: width * 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  treeData[index]['nickname'].toString(),
                                  style: TextStyle(fontSize: width * 30),
                                ),
                                Text.rich(TextSpan(
                                    style: TextStyle(fontSize: width * 24),
                                    children: [
                                      TextSpan(
                                          text: '职位: ',
                                          style: TextStyle(color: placeHolder)),
                                      TextSpan(
                                          text: treeData[index]['positions']
                                                      .toString() !=
                                                  'null'
                                              ? treeData[index]['positions']
                                                  .toString()
                                              : '暂无')
                                    ])),
                                Text.rich(TextSpan(
                                    style: TextStyle(fontSize: width * 24),
                                    children: [
                                      TextSpan(
                                          text: '部门: ',
                                          style: TextStyle(color: placeHolder)),
                                      TextSpan(
                                          text: treeData[index]['departments']
                                                      .toString() !=
                                                  'null'
                                              ? treeData[index]['departments']
                                                  .toString()
                                              : '暂无')
                                    ]))
                                // Text( ),
                                // Text(treeData[index]['departments'].toString()),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(themeColor)),
                              onPressed: () {
                                String url;
                                switch (widget.arguments['type']) {
                                  case '作业关闭人':
                                    url = Interface.getChangeClose;
                                    break;
                                  case '变更监护人':
                                    url = Interface.getChangeGuartian;
                                    break;
                                  case '变更数据录入人':
                                    url = Interface.getChangeDataInput;
                                    break;
                                  default:
                                }

                                showDialog(
                                    context: context,
                                    builder: (_) => MyDialog(
                                          title: widget.arguments['type']
                                              .toString(),
                                          content: treeData[index]['nickname']
                                              .toString(),
                                          okCallBack: () {
                                            myDio.request(
                                                type: 'get',
                                                url: url,
                                                queryParameters: {
                                                  "id": widget.arguments['id']
                                                      .toString(),
                                                  "userId": treeData[index]
                                                      ['id']
                                                }).then((value) {
                                              Fluttertoast.showToast(
                                                  msg: '变更成功');
                                              Navigator.pop(context);
                                            }).catchError((onError) {
                                              Interface()
                                                  .error(onError, context);
                                            });
                                          },
                                          rightText: '确定',
                                          leftText: '取消',
                                        ));
                              },
                              child: Text('变更'),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: treeData.length,
                  ),
                  height: size.height - 200,
                )
        ],
      )),
    );
  }
}

class UiStyle extends StatefulWidget {
  UiStyle(this.width, this.name, this.data, this.press, this.iconPress, this.id,
      {this.iconName = '查看人员',
      this.marginHor = 40,
      this.resurtionIndex = 1,
      this.opctity = 1.0,
      this.buttonColor = themeColor});
  final double width, marginHor, opctity;
  final String name, iconName, id;
  final int resurtionIndex;
  final Function iconPress, press;
  final Map data;
  final Color buttonColor;
  @override
  _UiStyleState createState() => _UiStyleState();
}

class _UiStyleState extends State<UiStyle> {
  bool shows = false;
  List peopleData = [];
  _getPeople(String id) {
    myDio
        .request(
      type: 'get',
      url: Interface.getGuartian + '/' + id,
    )
        .then((value) {
      peopleData = value;
      setState(() {});
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: widget.width * widget.marginHor * widget.opctity,
              right: widget.width * widget.marginHor * widget.opctity,
              top: widget.width * 30),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    offset: Offset(-2, 2),
                    blurRadius: 2.0,
                    spreadRadius: 0.5),
              ],
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.width * 24))),
          padding: EdgeInsets.symmetric(
              horizontal: widget.width * 52, vertical: widget.width * 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: widget.width * 28),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.iconName == '变更监护人') {
                        widget.press();
                      } else {
                        if (widget.data['isClick'] == null) {
                          widget.data['isClick'] = true;
                        } else {
                          widget.data['isClick'] = !widget.data['isClick'];
                        }
                        _getPeople(widget.data['id'].toString());
                      }
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: widget.width * 20),
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.width * 10,
                            vertical: widget.width * 5),
                        decoration: BoxDecoration(
                            color: widget.data['isClick'] == true
                                ? Colors.red
                                : widget.buttonColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(widget.width * 14))),
                        child: Center(
                          child: Text(
                            widget.iconName,
                            style: TextStyle(
                                fontSize: widget.width * 20,
                                color: Colors.white),
                          ),
                        )),
                  )
                ],
              ),
              IconButton(
                  icon: Icon(
                    shows
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    color: placeHolder,
                  ),
                  onPressed: () {
                    shows = !shows;
                    setState(() {});
                  })
            ],
          ),
        ),
        null != widget.data['children'] && shows
            ? Column(
                children: widget.data['children'].map<Widget>((ele) {
                  return UiStyle(
                    widget.width,
                    ele['name'],
                    ele,
                    () {},
                    () {},
                    widget.id,
                    opctity: widget.opctity + 0.2,
                  );
                }).toList(),
              )
            : Container(),
        widget.data['isClick'] == true
            ? Column(
                children: peopleData.map((ele) {
                  return UiStyle(
                    widget.width,
                    ele['nickname'].toString(),
                    ele,
                    () {
                      myDio.request(
                          type: 'get',
                          url: Interface.getChangeGuartian,
                          queryParameters: {
                            "id": widget.id.toString(),
                            "userId": ele['id']
                          }).then((value) {
                        Fluttertoast.showToast(msg: '变更成功');
                        Navigator.pop(context);
                      }).catchError((onError) {
                        Interface().error(onError, context);
                      });
                    },
                    () {},
                    widget.id,
                    iconName: '操作',
                    opctity: widget.opctity + 0.4,
                    buttonColor: Color.fromRGBO(241, 169, 120, 1),
                  );
                }).toList(),
              )
            : Container()
      ],
    );
  }
}
