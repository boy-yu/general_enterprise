import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencySystem.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueAdmin.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueConduct.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueCard.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueEvacuatePic.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueFirmFile.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueFirmPlan.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueMaterials.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescuePicture.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueResponse.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

GlobalKey<_EmergencyRescueLeftListState> _emergencyRescueLeftListState = GlobalKey();

class EmergencyRescueLeftList extends StatefulWidget {
  EmergencyRescueLeftList({this.index}): super(key: _emergencyRescueLeftListState);
  final int index;
  @override
  _EmergencyRescueLeftListState createState() =>
      _EmergencyRescueLeftListState();
}

class _EmergencyRescueLeftListState extends State<EmergencyRescueLeftList> {
  List leftBar = [
    {
      "name": "应急一张图",
      'title': '应急救援一张图',
      'icon': "assets/images/icon_emergency_rescue_home_picture_checked.png",
      'unIcon':
          'assets/images/icon_emergency_rescue_home_picture_unchecked.png',
      "widget": EmergencyRescuePicture()
    },
    {
      "name": "企业预案",
      'title': '企业预案',
      'icon': "assets/images/icon_emergency_rescue_home_firm_checked.png",
      'unIcon': 'assets/images/icon_emergency_rescue_home_firm_unchecked.png',
      "widget1": EmergencyRescueFirmPlan(),
      "widget2": EmergencyRescueFirmFile(),
    },
    {
      "name": "应急处置卡",
      'title': '应急处置卡',
      'icon': "assets/images/icon_emergency_rescue_home_card_checked.png",
      'unIcon': 'assets/images/icon_emergency_rescue_home_card_uncheck.png',
      "widget": EmergencyRescueCard()
    },
    {
      "name": "应急指挥",
      'title': '应急指挥',
      'icon': "assets/images/icon_emergency_rescue_home_conduct_checked.png",
      'unIcon': 'assets/images/icon_emergency_rescue_home_conduct_uncheck.png',
      "widget": EmergencyRescueConduct()
    },
    {
      "name": "应急值守",
      'title': '应急值守',
      'icon': "assets/images/icon_emergency_rescue_home_system_checked.png",
      'unIcon': 'assets/images/icon_emergency_rescue_home_system_unchecked.png',
      "widget": EmergencySystem()
    },
    // {
    //   "name": "值守记录",
    //   'title': '应急值守记录',
    //   'icon': "assets/images/icon_emergency_rescue_home_record_checked.png",
    //   'unIcon': 'assets/images/icon_emergency_rescue_home_record_unchecked.png',
    //   "widget": Container()
    // },
    {
      "name": "应急疏散图",
      'title': '应急疏散图',
      'icon': "assets/images/icon_emergency_rescue_home_evacuate_checked.png",
      'unIcon':
          'assets/images/icon_emergency_rescue_home_evacuate_unchecked.png',
      "widget": EmergencyRescueEvacuatePic()
    },
    {
      "name": "救援物资",
      'title': '应急救援物资',
      'icon': "assets/images/icon_emergency_rescue_home_materials_checked.png",
      'unIcon': 'assets/images/icon_emergency_rescue_home_materials_unchecked.png',
      "widget": EmergencyRescueMaterials()
    },
    // {
    //   "name": "应急演练",
    //   'title': '应急演练',
    //   'icon': "assets/images/icon_emergency_rescue_home_drill_checked.png",
    //   'unIcon': 'assets/images/icon_emergency_rescue_home_drill_unchecked.png',
    //   "widget": Container()
    // },
    {
      "name": "事故管理",
      'title': '事故管理',
      'icon': "assets/images/icon_emergency_rescue_home_admin_checked.png",
      'unIcon': 'assets/images/icon_emergency_rescue_home_admin_unchecked.png',
      "widget": EmergencyRescueAdmin()
    },
    {
      "name": "应急响应",
      'title': '应急响应',
      'icon': "assets/images/icon_emergency_rescue_home_response_checked.png",
      'unIcon':
          'assets/images/icon_emergency_rescue_home_response_unchecked.png',
      "widget": EmergencyRescueResponse()
    },
  ];

  int choosed = 0;
  int firmTitleChoosed = 0;

  @override
  void initState() {
    super.initState();
    choosed = widget.index;
  }

  _getWidget(){
    setState(() {});
  }

  _getTitle(String title){
    if(title == '企业预案'){
      return CheckFirmTitle(callback: _getWidget, firmTitleChoosed: firmTitleChoosed);
    }else{
      return Text(title);
    }
  }

  _getChild(String title){
    if(title == '企业预案'){
      if(firmTitleChoosed == 1){
        return leftBar[choosed]['widget2'];
      }else{
        return leftBar[choosed]['widget1'];
      }
    }else{
      return leftBar[choosed]['widget'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: _getTitle(leftBar[choosed]['title']),
      backgroundColor: Colors.white,
      elevation: 0,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 110),
            height: widghtSize.height,
            // color: Color(0xffF6F9FF),
            child: _getChild(leftBar[choosed]['title']),
          ),
          EmergencyRescueLeftBar(
              leftBar: leftBar,
              callback: (int index) {
                choosed = index;
                if (mounted) {
                  setState(() {});
                }
              },
              choosed: choosed),
        ],
      ),
      actions: [
        leftBar[choosed]['title'] == '企业预案'
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/emergencyRescue/__emergencyRescueFirmHis',
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Image.asset(
                    'assets/images/icon_emergency_rescue_firm_his.png',
                    height: size.width * 32,
                    width: size.width * 32,
                  ),
                ),
              )
            : Container(),
        leftBar[choosed]['title'] == '应急响应'
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/emergencyRescue/__emergencyRescueResponsePic',
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Image.asset(
                    'assets/images/icon_response_title_bar.png',
                    height: size.width * 33,
                    width: size.width * 36,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

typedef EmergencyRescueCallback = void Function(int index);

class EmergencyRescueLeftBar extends StatefulWidget {
  EmergencyRescueLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final EmergencyRescueCallback callback;
  final int choosed;
  @override
  _EmergencyRescueLeftBarState createState() => _EmergencyRescueLeftBarState();
}

class _EmergencyRescueLeftBarState extends State<EmergencyRescueLeftBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool isOpen = false;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animation = Tween(begin: size.width * 110, end: size.width * 350)
        .animate(_animation);
    super.initState();
  }

  _getIcon(int index) {
    if (index == widget.choosed) {
      return widget.leftBar[index]['icon'];
    } else {
      return widget.leftBar[index]['unIcon'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return GestureDetector(
        onPanEnd: (details) {
          if (_animationController.value.toInt() == 0 ||
              _animationController.value.toInt() == 1) {
            isOpen = !isOpen;
            if (isOpen) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          }
        },
        child: Row(
          children: [
            Container(
              width: _animation.value,
              height: widghtSize.height,
              color: Color(0xffEAEDF2),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            isOpen = !isOpen;
                            if (isOpen) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          },
                          child: !isOpen
                              ? Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      size.width * 20,
                                      size.width * 40,
                                      size.width * 20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 26,
                                        height: size.width * 22,
                                        margin: EdgeInsets.all(3),
                                        child: Image.asset(
                                            'assets/images/hidden_open.png'),
                                      ),
                                      Text(
                                        '展开',
                                        style: TextStyle(
                                            color: Color(0xff949494),
                                            fontSize: size.width * 16),
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 26,
                                        height: size.width * 22,
                                        margin: EdgeInsets.all(3),
                                        child: Image.asset(
                                            'assets/images/hidden_close.png'),
                                      ),
                                      Text(
                                        '收起',
                                        style: TextStyle(
                                            color: Color(0xff949494),
                                            fontSize: size.width * 16),
                                      )
                                    ],
                                  ),
                                )),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.leftBar.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (isOpen) {
                                isOpen = false;
                                _animationController.reverse();
                              }
                              widget.callback(index);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Container(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: !isOpen
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: !isOpen
                                          ? EdgeInsets.only(
                                              bottom: size.width * 10,
                                              top: size.width * 10)
                                          : EdgeInsets.only(
                                              bottom: size.width * 10,
                                              top: size.width * 10,
                                              left: size.width * 10),
                                      height: size.width * 60,
                                      width: size.width * 60,
                                      decoration: BoxDecoration(
                                          gradient: index == widget.choosed
                                              ? LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xff56E0FF),
                                                    Color(0xff2182FF),
                                                  ],
                                                )
                                              : LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ],
                                                ),
                                          // color: index == widget.choosed ? Colors.blue : Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 10),
                                        child: Image.asset(
                                          _getIcon(index),
                                          width: size.width * 45,
                                          height: size.width * 45,
                                        ),
                                      ),
                                    ),
                                    !isOpen
                                        ? Container()
                                        : Expanded(
                                            child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              widget.leftBar[index]['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xff999999),
                                                  fontSize: size.width * 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                  ],
                                ),
                                !isOpen
                                    ? Text(
                                        widget.leftBar[index]['name']
                                            .toString(),
                                        style: TextStyle(
                                            color: Color(0xff999999),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Container(),
                              ],
                            )),
                          );
                        }),
                  )
                ],
              ),
            ),
            isOpen
                ? Expanded(
                    child: Container(
                    color: Color.fromRGBO(0, 0, 0, .3),
                  ))
                : Container()
          ],
        ));
  }
}

class CheckFirmTitle extends StatefulWidget {
  CheckFirmTitle({this.callback, this.firmTitleChoosed});
  final Function callback;
  final int firmTitleChoosed;
  @override
  _CheckFirmTitleState createState() => _CheckFirmTitleState();
}

class _CheckFirmTitleState extends State<CheckFirmTitle> {
  List<String> data = ['预案', '文件'];
  int choosed;

  @override
  void initState() {
    super.initState();
    if(widget.firmTitleChoosed == 0){
      choosed = 0;
    }else{
      choosed = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: size.width * 0),
      child: Container(
        width: size.width * 240,
        height: size.width * 54,
        decoration: BoxDecoration(
          border: Border.all(width: size.width * 1, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(27.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .asMap()
              .keys
              .map((index) => InkWell(
                    onTap: () {
                      choosed = index;
                      _emergencyRescueLeftListState.currentState.firmTitleChoosed = choosed;
                      widget.callback();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: size.width * 54,
                      width: size.width * 119,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(27.0)),
                        color: choosed == index
                          ? Colors.white
                          : Color(0xff295DF7)),
                      // padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                      alignment: Alignment.center,
                      child: Text(
                        data[index],
                        style: TextStyle(
                            fontSize: size.width * 30,
                            color: choosed == index
                                ? Color(0xff295DF7)
                                : Colors.white),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}