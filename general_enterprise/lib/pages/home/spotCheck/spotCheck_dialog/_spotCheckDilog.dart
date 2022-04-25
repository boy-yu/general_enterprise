import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/myView/myDragContainer.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckButton.dart';
import 'package:flutter/material.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SpotCheckDialog extends StatefulWidget {
  final Function callback;
  final int threeId;
  final String spotCheckItemtitle;
  final bool operable;
  SpotCheckDialog(
      {this.threeId, this.callback, this.spotCheckItemtitle, this.operable});
  @override
  _SpotCheckDialogState createState() => _SpotCheckDialogState();
}

class _SpotCheckDialogState extends State<SpotCheckDialog> {
  Map threeDetailsMap = {
    "riskName": "",
    "riskLevel": 0,
    "riskDescription": "锅炉给水泵运行异常超压泄漏，造成烫伤、机械伤害、检修，导致系统停车",
    "riskPossibility": 0,
    "initialRiskConsequences": 0,
    "initialRiskLevel": 0,
    "riskDegree": 0,
    "responsibleDepartment": "",
    "riskUnit": "",
    "riskPoint": "",
    "riskConsequences": 0,
    "riskType": "",
    "personLiable": "",
    "inherentHazardLevel": "",
    "initialRiskPossibility": 0,
    "riskItem": "",
    "initialRiskDegree": 0
  };
  List threeDetailsList = [
    {"controlMeasures": "", "keyParameterIndex": ""},
  ];
  String spotCheckLevel = '';
  String initialSpotCheckLevel = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    try {
      myDio.request(
          type: 'get',
          url: Interface.getThreeDetails,
          queryParameters: {
            "threeId": widget.threeId,
          }).then((value) {
        if (value != null) {
          threeDetailsMap = value;
          threeDetailsList = threeDetailsMap['fourList'];
          if (threeDetailsMap['riskLevel'] != null) {
            switch (threeDetailsMap['riskLevel']) {
              case 0:
                spotCheckLevel = '暂无数据';
                break;
              case 1:
                spotCheckLevel = '重大风险';
                break;
              case 2:
                spotCheckLevel = '较大风险';
                break;
              case 3:
                spotCheckLevel = '一般风险';
                break;
              case 4:
                spotCheckLevel = '低风险';
                break;
              default:
            }
          }
          if (threeDetailsMap['initialRiskLevel'] != null) {
            switch (threeDetailsMap['initialRiskLevel']) {
              case 0:
                initialSpotCheckLevel = '暂无数据';
                break;
              case 1:
                initialSpotCheckLevel = '重大风险';
                break;
              case 2:
                initialSpotCheckLevel = '较大风险';
                break;
              case 3:
                initialSpotCheckLevel = '一般风险';
                break;
              case 4:
                initialSpotCheckLevel = '低风险';
                break;
              default:
            }
          }
          if (mounted) {
            setState(() {});
          }
        }
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text(
        '巡检点检风险管控',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      elevation: 0,
      child: Stack(
        children: [
          Container(
            width: widghtSize.width,
            height: widghtSize.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: lineGradBlue),
            ),
            padding: EdgeInsets.fromLTRB(size.width * 25, size.width * 5,
                size.width * 25, size.width * 150),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '风险名称：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Expanded(
                          child: Text(
                            threeDetailsMap['riskName'],
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: size.width * 24),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险点：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskPoint'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '固有危害等级：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['inherentHazardLevel'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '责任部门：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['responsibleDepartment'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '责任人：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['personLiable'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险单元：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskUnit'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险项：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskItem'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险类别：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskType'],
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '管控描述：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Expanded(
                          child: Text(
                            threeDetailsMap['riskDescription'],
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: size.width * 24),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '初始风险后果：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['initialRiskConsequences'].toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '初始风险可能性：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['initialRiskPossibility'].toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '初始风险度：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['initialRiskDegree'].toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '初始风险等级：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          initialSpotCheckLevel,
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险后果：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskConsequences'].toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险可能性：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskPossibility'].toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险度：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          threeDetailsMap['riskDegree'].toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '风险等级：',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 5,
                        ),
                        Text(
                          spotCheckLevel,
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                    ListView.builder(
                        itemCount: threeDetailsList.length,
                        shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                        physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '管控部位：',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width * 5,
                                  ),
                                  Text(
                                    threeDetailsList[index]
                                        ['keyParameterIndex'],
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 24),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '管控措施：',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width * 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      threeDetailsList[index]
                                          ['controlMeasures'],
                                      style: TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: size.width * 24),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ],
            ),
          ),
          SpotCheckBuildDragWidget(
              callback: widget.callback,
              threeId: widget.threeId,
              spotCheckItemtitle: widget.spotCheckItemtitle,
              operable: widget.operable),
        ],
      ),
    );
  }
}

class SpotCheckDropDown extends StatefulWidget {
  SpotCheckDropDown(
      {this.callback, this.threeId, this.spotCheckItemtitle, this.operable});
  final Function callback;
  final int threeId;
  final String spotCheckItemtitle;
  final bool operable;
  @override
  _SpotCheckDropDownState createState() => _SpotCheckDropDownState();
}

class _SpotCheckDropDownState extends State<SpotCheckDropDown> {
  TextEditingController spotCheckUnameController = TextEditingController();
  int selectbgColor = 0xff0ABA08;
  int selecttextColor = 0xffffffff;
  Counter _counter = Provider.of<Counter>(myContext);
  bool isFull = true;
  List fullList = [];
  Map spotCheckControlVo = {
    "threeId": 0,
    "executionUrl": "",
    "executionData": "",
    "opinion": "",
    "fourIds": [],
    "executionStatus": 0,
  };
  @override
  void initState() {
    super.initState();
    _getdatas();
    _getRecentControlRecords();
  }

  List recentControlRecords = [];

  _getRecentControlRecords() {
    myDio.request(
        type: 'get',
        url: Interface.getRiskItemHistory,
        queryParameters: {
          "threeId": widget.threeId,
        }).then((value) {
      if (value != null && value["records"] is List) {
        recentControlRecords = value["records"];
      }
    });
  }

  _getdatas() {
    myDio.request(
        type: 'get',
        url: Interface.getriskControlDataList,
        queryParameters: {"threeId": widget.threeId}).then((value) {
      if (value != null && value is List) {
        value.forEach((element) {
          element["select"] = false;
        });
        fullList = value;
        if (mounted) {
          setState(() {});
        }
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  saveData() async {
    if (_counter.submitDates["executionUrls"] != null &&
        _counter.submitDates["executionUrls"] is List &&
        _counter.submitDates["executionUrls"][0]["value"] != null) {
      spotCheckControlVo["executionUrl"] =
          _counter.submitDates["executionUrls"][0]["value"].join("|");
    }
    spotCheckControlVo["opinion"] = spotCheckUnameController.text;
    spotCheckControlVo["executionStatus"] = isFull ? 1 : 2;
    List forids = [];
    if (!isFull) {
      fullList.forEach((element) {
        if (element["select"]) {
          forids.add(element["fourId"]);
        }
      });
      spotCheckControlVo["fourIds"] = forids;
      if (mounted) {
        setState(() {});
      }
    }
    spotCheckControlVo['threeId'] = widget.threeId;
    if (spotCheckControlVo['executionUrl'] == '') {
      Fluttertoast.showToast(msg: "请拍照后再提交");
    } else if (spotCheckControlVo['opinion'] == '') {
      Fluttertoast.showToast(msg: "请先填写描述");
    } else {
      await myDio.request(
          type: 'post', url: Interface.setriskdata, data: spotCheckControlVo);
      Fluttertoast.showToast(msg: "提交成功");
      widget.callback();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return SingleChildScrollView(
      child: widget.operable
          ? _content(width)
          : Container(
              padding: EdgeInsets.only(
                  left: width * 30, right: width * 30, top: size.width * 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '近期管控记录',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: double.infinity,
                      height: size.width * 250,
                      margin: EdgeInsets.only(
                          top: size.width * 20,
                          right: size.width * 15,
                          left: size.width * 15),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recentControlRecords.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: size.width * 20),
                              child: Column(
                                children: <Widget>[
                                  recentControlRecords[index]
                                              ['inspectionUrl'] !=
                                          ''
                                      ? Image.network(
                                          recentControlRecords[index]
                                                  ['inspectionUrl']
                                              .toString()
                                              .split('|')[0]
                                              .toString(),
                                          width: size.width * 160,
                                          height: size.width * 120)
                                      : Image.asset(
                                          'assets/images/image_recent_control.jpg',
                                          width: size.width * 160,
                                          height: size.width * 120),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Text(
                                    recentControlRecords[index]
                                            ['inspectionTime']
                                        .toString()
                                        .substring(0, 10),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 20),
                                  ),
                                  Text(
                                    recentControlRecords[index]
                                            ['inspectionTime']
                                        .toString()
                                        .substring(11, 19),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 20),
                                  ),
                                ],
                              ),
                            );
                          }))
                ],
              )),
    );
  }

  Widget setFull(width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "异常风险条目选择：",
            style: TextStyle(fontSize: width * 28, color: Color(0xff666666)),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fullList
              .asMap()
              .keys
              .map((e) => Container(
                    padding: EdgeInsets.only(top: 30 * width),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              fullList[e]["select"] = !fullList[e]["select"];
                            });
                          },
                          child: Container(
                            child: Image.asset(
                              fullList[e]["select"] == false
                                  ? "assets/images/circle@2x.png"
                                  : "assets/images/select@2x.png",
                              width: width * 50,
                              height: width * 50,
                            ),
                            margin: EdgeInsets.only(right: width * 10),
                          ),
                        ),
                        Container(
                          width: size.width * 500,
                          child: Text(
                            "${fullList[e]['keyParameterIndex']}",
                            style: TextStyle(
                                fontSize: width * 28, color: Color(0xff000000)),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  _content(width) {
    return Container(
        padding: EdgeInsets.only(
            left: width * 30, right: width * 30, top: size.width * 50),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.spotCheckItemtitle,
                  style: TextStyle(
                      fontSize: width * 28,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: width * 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: width * 60),
                    child: SpotCheckButtons(
                      text: "正常",
                      testcolor: isFull ? selecttextColor : 0xff9A9A9A,
                      bgcolor: isFull ? selectbgColor : 0xffFFFFFF,
                      callback: () {
                        isFull = !isFull;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  SpotCheckButtons(
                    text: "异常",
                    testcolor: isFull ? 0xff9A9A9A : 0xffffffff,
                    bgcolor: isFull ? 0xffFFFFFF : 0xffFF1818,
                    callback: () {
                      isFull = !isFull;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            ),
            !isFull
                ? Row(
                    children: [
                      setFull(width),
                    ],
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: width * 92,
              child: TextField(
                autofocus: false,
                controller: spotCheckUnameController,
                decoration: InputDecoration(
                  fillColor: Color(0xffF0F5FF),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 23),
                      borderSide: BorderSide.none),
                  hintText: "请输入描述",
                  hintStyle: TextStyle(
                      color: Color(0xffBBBBBB), fontSize: width * 24.0),
                ),
              ),
            ),
            Container(
              child: MyImageCarma(
                  title: "executionUrl",
                  name: "executionUrls",
                  purview: "executionUrls"),
            ),
            SizedBox(
              height: size.width * 50,
            ),
            Container(
              margin: EdgeInsets.only(bottom: width * 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: width * 505,
                    height: width * 76,
                    child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      child: Text(
                        "${isFull ? '提交' : '上报隐患'}",
                        style: TextStyle(
                            fontSize: width * 36, color: Color(0xffffffff)),
                      ),
                      onPressed: () {
                        saveData();
                      },
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "近期管控记录",
                  style: TextStyle(
                      fontSize: width * 28,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
                width: double.infinity,
                height: size.width * 250,
                margin: EdgeInsets.only(
                    top: size.width * 20,
                    right: size.width * 15,
                    left: size.width * 15),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentControlRecords.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: size.width * 20),
                        child: Column(
                          children: <Widget>[
                            recentControlRecords[index]['inspectionUrl'] != ''
                                ? Image.network(
                                    recentControlRecords[index]['inspectionUrl']
                                        .toString()
                                        .split('|')[0]
                                        .toString(),
                                    width: size.width * 160,
                                    height: size.width * 120)
                                : Image.asset(
                                    'assets/images/image_recent_control.jpg',
                                    width: size.width * 160,
                                    height: size.width * 120),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              recentControlRecords[index]['inspectionTime']
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 20),
                            ),
                            Text(
                              recentControlRecords[index]['inspectionTime']
                                  .toString()
                                  .substring(11, 19),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 20),
                            ),
                          ],
                        ),
                      );
                    }))
          ],
        ));
  }
}

class SpotCheckBuildDragWidget extends StatefulWidget {
  SpotCheckBuildDragWidget(
      {this.callback, this.threeId, this.spotCheckItemtitle, this.operable});
  final Function callback;
  final int threeId;
  final String spotCheckItemtitle;
  final bool operable;
  @override
  _SpotCheckBuildDragWidgetState createState() =>
      _SpotCheckBuildDragWidgetState();
}

class _SpotCheckBuildDragWidgetState extends State<SpotCheckBuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();
  @override
  Widget build(BuildContext context) {
    //层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        //抽屉关闭时的高度 默认0.4
        initChildRate: 0.1,
        //抽屉打开时的高度 默认0.4
        maxChildRate: 0.8,
        //是否显示默认的标题
        isShowHeader: true,
        //背景颜色
        backGroundColor: Colors.white,
        //背景圆角大小
        cornerRadius: 0,
        //自动上滑动或者是下滑的分界值
        maxOffsetDistance: 1.5,
        //抽屉控制器
        controller: dragController,
        //滑动控制器
        scrollController: scrollController,
        //自动滑动的时间
        duration: Duration(milliseconds: 800),
        //抽屉的子Widget
        dragWidget: SpotCheckDropDown(
            callback: widget.callback,
            threeId: widget.threeId,
            spotCheckItemtitle: widget.spotCheckItemtitle,
            operable: widget.operable),
        //抽屉标题点击事件回调
        dragCallBack: (isOpen) {},
      ),
    );
  }
}
