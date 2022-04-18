import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enterprise/tool/funcType.dart';

class SpotCheckFour extends StatefulWidget {
  SpotCheckFour({this.title, this.leftBar, this.id});
  final String title;
  final List<HiddenDangerInterface> leftBar;
  final int id;
  @override
  _SpotCheckFourState createState() => _SpotCheckFourState();
}

class _SpotCheckFourState extends State<SpotCheckFour> {
  bool isOpen = false;
  List<HiddenDangerInterface> iconList = [];
  int type = 1;
  String title;
  int id = -1;
  int choosed = 0;
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
  }

  int total = 0;
  int checked = 1;

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
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
              margin: EdgeInsets.only(left: 50),
              width: widghtSize.width - 50,
              height: widghtSize.height,
              child: MyRefres(
                  child: (index, list) => SpotCheckFourItem(
                      mapData: list[index],
                      callback: (title) async {
                        Navigator.pushNamed(context, '/home/hiddenScreening',
                            arguments: {
                              "id": list[index]['id'],
                              "fourId": list[index]['id'],
                              "type": list[index]['status'],
                              "title": title,
                              'controlType': 2,
                              'authority': 0,
                              'data': list[index]
                            }).then((value) {
                          _throwFunc.run(argument: {
                            "current": 1,
                            "size": 30,
                            "threeId": id,
                            'controlType': 2,
                            "QRCode": null
                          });
                        });
                      }),
                  url: Interface.getRiskFourList,
                  throwFunc: _throwFunc,
                  queryParameters: {
                    "current": 1,
                    "size": 30,
                    "threeId": id,
                    'controlType': 2,
                    "QRCode": null
                  },
                  listParam: 'records',
                  method: 'get')),
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
                "current": 1,
                "size": 30,
                "threeId": id,
                'controlType': 2,
                "QRCode": null
              });
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}

class SpotCheckFourItem extends StatefulWidget {
  SpotCheckFourItem({this.mapData, this.callback});
  final Map mapData;
  final SpotCheckFourCallBackFunc callback;
  @override
  _SpotCheckFourItemState createState() => _SpotCheckFourItemState();
}

class _SpotCheckFourItemState extends State<SpotCheckFourItem> {
  List state = [
    {"title": '待点检', "bgStateColor": Color(0xff03AA07), "button": '点检'},
    {"title": '待确认', "bgStateColor": Color(0xff3074FE), "button": '确认隐患'},
    {"title": '整改中', "bgStateColor": Color(0xffFF7F00), "button": '整改完毕'},
    {"title": '整改完毕', "bgStateColor": Color(0xffFFC600), "button": '整改确认'},
    {"title": '已完成', "bgStateColor": Color(0xffFFC600), "button": '已完成'},
    {"title": '逾期', "bgStateColor": Color(0xffFFC600), "button": '逾期'},
  ];

  int fourId = -1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.callback(widget.mapData['keyParameterIndex']);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(size.width * 10, 0, size.width * 10, 0),
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 20, left: size.width * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.mapData['keyParameterIndex'].toString(),
                            style: TextStyle(
                                color: Color(0xff343434),
                                fontSize: size.width * 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: size.width * 10),
                          alignment: Alignment.center,
                          constraints: BoxConstraints.expand(
                              height: size.width * 46.0,
                              width: size.width * 114.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              color: state[widget.mapData['status']]
                                      ['bgStateColor']
                                  .withOpacity(.3)),
                          child: Text(
                            state[widget.mapData['status']]['title'].toString(),
                            style: TextStyle(
                                color: state[widget.mapData['status']]
                                    ['bgStateColor'],
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
                            text: '点检措施:      ',
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
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '点检手段:      ',
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
                        GestureDetector(
                          onTap: () {
                            fourId = widget.mapData['id'];
                            Navigator.pushNamed(context, '/home/myLedger', arguments: {
                              'fourId': fourId,
                              'controlType': 2,
                            });
                          },
                          child: Container(
                              height: size.width * 45,
                              width: size.width * 45,
                              decoration: BoxDecoration(
                                  color: Color(0xff295FFA),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 5, top: size.width * 5),
                                child: Icon(
                                  Icons.query_builder,
                                  color: Colors.white,
                                  size: size.width * 28,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
