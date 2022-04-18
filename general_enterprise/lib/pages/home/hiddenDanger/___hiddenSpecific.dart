import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/hiddenDanger/picture.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enterprise/tool/funcType.dart';

class HiddenSpecific extends StatefulWidget {
  HiddenSpecific({this.title, this.leftBar, this.id, this.hiddenType});
  final String title, hiddenType;
  final List<HiddenDangerInterface> leftBar;
  final int id;
  @override
  _HiddenSpecificState createState() => _HiddenSpecificState();
}

class _HiddenSpecificState extends State<HiddenSpecific> {
  bool isOpen = false;
  List<HiddenDangerInterface> iconList = [];
  int type = 1;
  String title;
  // List hiddenSpecificList = [];
  int id = -1;
  ThrowFunc _throwFunc = ThrowFunc();
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    title = widget.title;
    iconList = widget.leftBar ?? [];
    for (var i = 0; i < iconList.length; i++) {
      if (iconList[i].title == title) {
        iconList[i].color = Colors.white;
        type = i + 1;
      } else {
        iconList[i].color = Colors.transparent;
      }
    }
    if (widget.id is int) {
      id = widget.id;
      // _getData();
    } else {
      Fluttertoast.showToast(msg: "id不能为空，请联系开发人员");
    }
    // print(id);
    // print(widget.hiddenType);
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Text(
        title.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: size.width * 80,
            ),
            child: MyRefres(
                child: (index, hiddenSpecificList) {
                  if (index == 0) {
                    return Column(
                      children: [
                        HiddenPicture(
                          queryParameters: {
                            "type": widget.hiddenType,
                            "departmentId": id,
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 10,
                                right: size.width * 10,
                                top: size.width * 10),
                            child: HiddenSpecificItem(
                                mapData: hiddenSpecificList[index],
                                callback: (title) async {
                                  Navigator.pushNamed(
                                      context, '/home/hiddenScreening',
                                      arguments: {
                                        "id": hiddenSpecificList[index]['id'],
                                        "fourId": hiddenSpecificList[index]['id'],
                                        "type": hiddenSpecificList[index]['status'],
                                        "title": title,
                                        'authority': 0,
                                        'data': hiddenSpecificList[index],
                                      }).then((value) {
                                    _throwFunc.run(argument: {
                                      "departmentId": id,
                                      "hiddenType": widget.hiddenType
                                    });
                                  });
                                }))
                      ],
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(size.width * 10),
                    child: HiddenSpecificItem(
                        mapData: hiddenSpecificList[index],
                        callback: (title) async {
                          Navigator.pushNamed(context, '/home/hiddenScreening',
                              arguments: {
                                "id": hiddenSpecificList[index]['id'],
                                "fourId": hiddenSpecificList[index]['id'],
                                "type": hiddenSpecificList[index]['status'],
                                "title": title,
                                'authority': 0,
                                'data': hiddenSpecificList[index],
                              }).then((value) {
                            _throwFunc.run(argument: {
                              "departmentId": id,
                              "hiddenType": widget.hiddenType
                            });
                          });
                        }),
                  );
                },
                url: Interface.getHiddenTypeList,
                queryParameters: {
                  "departmentId": id,
                  "hiddenType": widget.hiddenType
                },
                throwFunc: _throwFunc,
                method: 'get'),
          ),
          LeftBar(
            iconList: iconList,
            callback: (int index) {
              iconList.forEach((element) {
                element.color = Color(0xffEAEDF2);
              });
              iconList[index].color = Colors.white;
              type = index + 1;
              title = iconList[index].title;
              id = iconList[index].id;
              _throwFunc.run(argument: {
                "departmentId": id,
                "hiddenType": widget.hiddenType
              });
            },
          ),
        ],
      ),
    );
  }
}

class HiddenSpecificItem extends StatefulWidget {
  HiddenSpecificItem(
      {this.mapData, this.callback, this.widget, this.titleWidget});
  final Map mapData;
  final Widget widget, titleWidget; //check
  final HiddenSpecificItemCallBackFunc callback;
  @override
  _HiddenSpecificItemState createState() => _HiddenSpecificItemState();
}

class _HiddenSpecificItemState extends State<HiddenSpecificItem> {
  List state = [
    {"title": '待排查', "bgStateColor": Color(0xff03AA07), "button": '排查'},
    {"title": '待确认', "bgStateColor": Color(0xff3074FE), "button": '确认隐患'},
    {"title": '整改中', "bgStateColor": Color(0xffFF7F00), "button": '整改完毕'},
    {"title": '整改完毕', "bgStateColor": Color(0xffFFC600), "button": '整改审批'},
    {"title": '已完成', "bgStateColor": Color(0xffFFC600), "button": '已完成'},
    {"title": '已逾期', "bgStateColor": Color(0xff969696), "button": '已逾期'},
  ];

  int fourId = -1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.callback(state[widget.mapData['status']]['title']);
        },
        child: Padding(
          padding: EdgeInsets.only(
              right: size.width * 10,
              bottom: size.width * 10,
              left: size.width * 10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, //阴影颜色
                      offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                      blurRadius: 5.0, //阴影大小
                      spreadRadius: 0.0 //阴影扩散程度
                      ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff3073FE),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 10,
                          vertical: size.width * 5),
                      child: Text(
                        widget.mapData['hiddenDangereType'].toString(),
                        style: TextStyle(
                          color: Color(0xfff5f5f5),
                          fontSize: size.width * 18,
                        ),
                      ),
                    ),
                    widget.widget == null
                        ? InkWell(
                            onTap: () {
                              fourId = widget.mapData['id'];
                              Navigator.pushNamed(context, '/home/myLedger', arguments: {
                                'fourId': fourId,
                                'controlType': 1,
                              });
                            },
                            child: Icon(
                              Icons.query_builder,
                              color: themeColor,
                              size: size.width * 50,
                            ),
                          )
                        : Container()
                  ],
                ),
                Row(
                  children: [
                    widget.titleWidget == null
                        ? Expanded(
                            child: Padding(
                            padding: EdgeInsets.only(top: size.width * 10),
                            child: Text(
                              widget.mapData['keyParameterIndex'].toString(),
                              style: TextStyle(
                                  color: Color(0xff343434),
                                  fontSize: size.width * 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                        : widget.titleWidget,
                    widget.widget == null ? Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints.expand(
                          height: size.width * 46.0, width: size.width * 114.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: state[widget.mapData['status']]['bgStateColor']
                              .withOpacity(.3)),
                      child: Text(
                        state[widget.mapData['status']]['title'].toString(),
                        style: TextStyle(
                            color: state[widget.mapData['status']]
                                ['bgStateColor'],
                            fontSize: size.width * 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ) 
                    : Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints.expand(
                          height: size.width * 34.0, width: size.width * 102.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(width: size.width * 1, color: Color(0xff3073FE)),
                      ),
                      child: Text(
                        state[widget.mapData['status']]['button'].toString(),
                        style: TextStyle(
                            color: Color(0xff3073FE),
                            fontSize: size.width * 20),
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1.0,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  color: Color(0xffEFEFEF),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '排查措施:      ',
                        style: TextStyle(
                            color: Color(0xff3074FE),
                            fontSize: size.width * 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.mapData['controlMeasures'].toString(),
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: size.width * 20,
                        ),
                      )
                    ]))),
                  ],
                ),
                Row(
                  children: [
                    // controlMeans
                    Expanded(
                        child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '排查手段:      ',
                        style: TextStyle(
                            color: Color(0xff3074FE),
                            fontSize: size.width * 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.mapData['controlMeans'].toString(),
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: size.width * 20,
                        ),
                      )
                    ]))),
                  ],
                ),
                // beyondDate
                widget.widget ?? Container()
              ],
            ),
          ),
        ));
  }
}
