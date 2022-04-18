import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/legitimate/__FileProject.dart';
import 'package:enterprise/pages/home/legitimate/__basicMessage.dart';
import 'package:enterprise/pages/home/legitimate/__fileManagement.dart';
import 'package:enterprise/pages/home/legitimate/__legislation.dart';
import 'package:enterprise/pages/home/legitimate/__licenseType.dart';
import 'package:enterprise/pages/home/legitimate/__projectCompliance.dart';
import 'package:enterprise/pages/home/legitimate/__safetyManagement.dart';
import 'package:enterprise/pages/home/legitimate/__legitimateCraft.dart';
import 'package:enterprise/pages/home/legitimate/__legitimateSystem.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

GlobalKey<_LegitimateLeftListState> _legitimateLeftglobalKey = GlobalKey();

class LegitimateLeftList extends StatefulWidget {
  LegitimateLeftList({this.index}): super(key: _legitimateLeftglobalKey);
  final int index;
  @override
  _LegitimateLeftListState createState() => _LegitimateLeftListState();
}

class _LegitimateLeftListState extends State<LegitimateLeftList> {
  List leftBar = [
    {
      "name": "基本信息",
      'title': '企业基础信息',
      'icon': "assets/images/icon_legitimate_basic_checked.png",
      'unIcon': 'assets/images/icon_legitimate_basic_unchecked.png',
      "widget": BasicMessage()
    },
    {
      "name": "管理机构",
      'title': '安全生产管理机构',
      'icon': "assets/images/icon_legitimate_management_checked.png",
      'unIcon': 'assets/images/icon_legitimate_management_unchecked.png',
      "widget1": SafetyManagement(),
      "widget2": FileManagement(),
    },
    {
      "name": "企业证照",
      'title': '企业证照',
      'icon': "assets/images/icon_legitimate_firm_license_checked.png",
      'unIcon': 'assets/images/icon_legitimate_firm_license_unchecked.png',
      "widget": LicenseType(arguments: {'type': 0})
    },
    {
      "name": "人员持证",
      'title': '岗位人员持证',
      'icon': "assets/images/icon_legitimate_crew_license_checked.png",
      'unIcon': 'assets/images/icon_legitimate_crew_license_unchecked.png',
      "widget": LicenseType(arguments: {'type': 1})
    },
    {
      "name": "设备证照",
      'title': '设备证照',
      'icon': "assets/images/icon_legitimate_equipment_license_checked.png",
      'unIcon': 'assets/images/icon_legitimate_equipment_license_unchecked.png',
      "widget": LicenseType(arguments: {'type': 2})
    },
    {
      "name": "项目合规",
      'title': '项目合规性',
      'icon': "assets/images/icon_legitimate_project_compliance_checked.png",
      'unIcon': 'assets/images/icon_legitimate_project_compliance_unchecked.png',
      "widget1": ProjectCompliance(),
      "widget2": FileProject(),
    },
    {
      "name": "制度及规程",
      'title': '管理制度和操作规程',
      'icon': "assets/images/icon_legitimate_system_checked.png",
      'unIcon': 'assets/images/icon_legitimate_system_unchecked.png',
      "widget": LegitimateSystem()
    },
    {
      "name": "生产及工艺",
      'title': '生产设施及工艺安全',
      'icon': "assets/images/icon_legitimate_craft_checked.png",
      'unIcon': 'assets/images/icon_legitimate_craft_unchecked.png',
      "widget": LegitimateCraft()
    },
    {
      "name": "法律法规",
      'title': '法律法规',
      'icon': "assets/images/icon_legitimate_legislation_checked.png",
      'unIcon': 'assets/images/icon_legitimate_legislation_unchecked.png',
      "widget": Legislation()
    },
  ];
  int choosed = 0;
  int managementTitleChoosed = 0;
  int projectTitleChoosed = 0;

  @override
  void initState() {
    super.initState();
    choosed = widget.index;
  }

  _getWidget(){
    setState(() {});
  }

  _getTitle(String title){
    if(title == '安全生产管理机构'){
      return CheckManagementTitle(callback: _getWidget, managementTitleChoosed: managementTitleChoosed);
    }else if(title == '项目合规性'){
      return CheckProjectTitle(callback: _getWidget, projectTitleChoosed: projectTitleChoosed);
    }else{
      return Text(title);
    }
  }
  
  _getChild(String title){
    if(title == '安全生产管理机构'){
      if(managementTitleChoosed == 1){
        return leftBar[choosed]['widget2'];
      }else{
        return leftBar[choosed]['widget1'];
      }
    }else if(title == '项目合规性'){
      if(projectTitleChoosed == 1){
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
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 53),
            height: widghtSize.height,
            color: Color(0xffF6F9FF),
            child: _getChild(leftBar[choosed]['title']),
          ),
          LegitimateLeftBar(
            leftBar: leftBar,
            callback: (int index) {
              choosed = index;
              if (mounted) {
                setState(() {});
              }
            },
            choosed: choosed
          ),
        ],
      ),
    );
  }
}

typedef LeftBarCallback = void Function(int index);

class LegitimateLeftBar extends StatefulWidget {
  LegitimateLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  _LegitimateLeftBarState createState() => _LegitimateLeftBarState();
}

class _LegitimateLeftBarState extends State<LegitimateLeftBar>
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
                                      alignment: Alignment.center,
                                      margin: !isOpen
                                        ? EdgeInsets.only( bottom: 10, top: 10)
                                        : EdgeInsets.only( bottom: 10, top: 10, left: 10),
                                        height: size.width * 60,
                                        width: size.width * 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                                        ),
                                        child: Image.asset(
                                          _getIcon(index),
                                          width: size.width * 50,
                                          height: size.width * 50,
                                        )
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
                                                  color: Color(0xff343434),
                                                  fontSize: size.width * 20,
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
                                            fontSize: size.width * 20),
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

class CheckManagementTitle extends StatefulWidget {
  CheckManagementTitle({this.callback, this.managementTitleChoosed});
  final Function callback;
  final int managementTitleChoosed;
  @override
  _CheckManagementTitleState createState() => _CheckManagementTitleState();
}

class _CheckManagementTitleState extends State<CheckManagementTitle> {
  List<String> data = ['机构', '文件'];
  int choosed;

  @override
  void initState() {
    super.initState();
    if(widget.managementTitleChoosed == 0){
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
                      _legitimateLeftglobalKey.currentState.managementTitleChoosed = choosed;
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

class CheckProjectTitle extends StatefulWidget {
  CheckProjectTitle({this.callback, this.projectTitleChoosed});
  final Function callback;
  final int projectTitleChoosed;
  @override
  _CheckProjectTitleState createState() => _CheckProjectTitleState();
}

class _CheckProjectTitleState extends State<CheckProjectTitle> {
  List<String> data = ['合规', '文件'];
  int choosed;

  @override
  void initState() {
    super.initState();
    if(widget.projectTitleChoosed == 0){
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
                      _legitimateLeftglobalKey.currentState.projectTitleChoosed = choosed;
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
