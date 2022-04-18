import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/work/workList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class HiddenDangerAccount extends StatefulWidget {
  @override
  _HiddenDangerAccountState createState() => _HiddenDangerAccountState();
}

class _HiddenDangerAccountState extends State<HiddenDangerAccount> {
  bool isOpen;
  List iconList = [
    {
      'image': 'assets/images/bg_hidden_icon.png',
      'icon': 'assets/images/icon_hidden_scene.png',
      'details': '现场管理类',
      'bgColor': 'white',
    },
    {
      'image': 'assets/images/bg_hidden_icon.png',
      'icon': 'assets/images/icon_hidden_base.png',
      'details': '基础管理类',
      'bgColor': '',
    },
  ];
  List dropList = [
    {
      'title': '请选择排查结果',
      'data': [
        {'name': '已排查（无隐患）'},
        {'name': '排查逾期'},
        {'name': '驳回'},
        {'name': '已排查（未确认）'},
        {'name': '整改完成'},
        {'name': '整改完成（审核逾期）'},
      ],
      'value': '',
      "saveTitle": '相关作业',
      'limit': 'type'
    },
    {
      'title': '请选择隐患类型',
      'data': [],
      'value': '',
      "saveTitle": '作业单位',
      'limit': 'workUnit'
    },
  ];
  dynamic queryParameters = {"size": "20", "type": "1"};
  _changeDrop() {
    for (var i = 1; i < dropList.length; i++) {
      if (dropList[i]['title'] != dropList[i]['saveTitle']) {
        queryParameters[dropList[i]['limit'].toString()] = dropList[i]['title'];
      } else {
        queryParameters[dropList[i]['limit']] = null;
      }
    }
    // me 1  all 0
    if (dropList[0]['title'] == '与我相关') {
      queryParameters['type'] = "1";
    } else {
      queryParameters['type'] = "0";
    }
    // _getData();
  }

  List hiddenAccountItem = [
    {
      'title': '安全管理制度缺陷',
      'labelText': '安全规章制度',
      'investigationPerson': '赵伟',
      'investigationPosition': '精馏二班班长',
      'investigationTime': '2020.09.25',
      'confirmPerson': '张三',
      'confirmPosition': '精馏一班班长',
      'confirmTime': '2020.08.20',
      'grade': '无隐患',
      'state': '排查完成',
    },
    {
      'title': '安全管理制度缺陷',
      'labelText': '安全规章制度',
      'investigationPerson': '赵伟',
      'investigationPosition': '精馏二班班长',
      'investigationTime': '2020.09.25',
      'confirmPerson': '张三',
      'confirmPosition': '精馏一班班长',
      'confirmTime': '2020.08.20',
      'grade': '一般隐患',
      'state': '排查完成',
    },
    {
      'title': '安全管理制度缺陷',
      'labelText': '安全规章制度',
      'investigationPerson': '赵伟',
      'investigationPosition': '精馏二班班长',
      'investigationTime': '2020.09.25',
      'confirmPerson': '张三',
      'confirmPosition': '精馏一班班长',
      'confirmTime': '2020.08.20',
      'grade': '重大隐患',
      'state': '排查完成',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      elevation: 0,
      title: Text(
        '隐患台账',
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
            child: Column(
              children: <Widget>[
                TitleChoose(dropList, 0, _changeDrop),
                Expanded(
                  child: ListView.builder(
                    itemCount: hiddenAccountItem.length,
                    itemBuilder: (context, index) {
                      return HiddenAccountItem(
                          mapData: hiddenAccountItem[index]);
                      // return Text('data');
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: isOpen == null ? size.width * 90 : size.width * 340,
            height: widghtSize.height,
            color: Color(0xffEAEDF2),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: isOpen == null ? 0 : size.width * 270,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (isOpen == null) {
                            isOpen = true;
                          } else {
                            isOpen = null;
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: isOpen == null
                            ? Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                padding: EdgeInsets.only(top: 10, bottom: 10),
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
                        itemCount: iconList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              iconList.forEach((element) {
                                element['bgColor'] = '';
                              });
                              iconList[index]['bgColor'] =
                                  iconList[index]['bgColor'] == 'white'
                                      ? ''
                                      : 'white';
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Container(
                              color: iconList[index]['bgColor'] == ''
                                  ? Color(0xffEAEDF2)
                                  : Colors.white,
                              child: Row(
                                mainAxisAlignment: isOpen == null
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    margin: isOpen == null
                                        ? EdgeInsets.only(bottom: 10, top: 10)
                                        : EdgeInsets.only(
                                            bottom: 10, top: 10, left: 10),
                                    constraints: BoxConstraints.expand(
                                        height: size.width * 63.0,
                                        width: size.width * 62.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            iconList[index]['image']),
                                        centerSlice: Rect.fromLTRB(
                                            270.0, 180.0, 1360.0, 730.0),
                                      ),
                                    ),
                                    child: Container(
                                      width: size.width * 25,
                                      height: size.width * 25,
                                      child:
                                          Image.asset(iconList[index]['icon']),
                                    ),
                                  ),
                                  isOpen == null
                                      ? Container()
                                      : Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            iconList[index]['details'],
                                            style: TextStyle(
                                                color: Color(0xff343434),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HiddenAccountItem extends StatefulWidget {
  HiddenAccountItem({this.mapData});
  final Map mapData;
  @override
  _HiddenAccountItemState createState() => _HiddenAccountItemState();
}

class _HiddenAccountItemState extends State<HiddenAccountItem> {
  Color _generateColor(String stateName) {
    Color bgStateColor = Color(0xffCCCCCC);
    switch (stateName) {
      case '无隐患':
        bgStateColor = Color(0xffCCCCCC);
        break;
      case '一般隐患':
        bgStateColor = Color(0xffFBAB00);
        break;
      case '重大隐患':
        bgStateColor = Color(0xffEC1111);
        break;
      default:
    }
    return bgStateColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // _setOnClickListener(widget.mapData['button']);
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        widget.mapData['title'],
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        widget.mapData['labelText'],
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffEFEFEF),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '排查人：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                widget.mapData['investigationPerson'],
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                '(',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                widget.mapData['investigationPosition'],
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                ')',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '排查时间：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                widget.mapData['investigationTime'],
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '确认人：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                widget.mapData['confirmPerson'],
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                '(',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                widget.mapData['confirmPosition'],
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                ')',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '确认时间：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                widget.mapData['confirmTime'],
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Container(
                            height: size.width * 46,
                            width: size.width * 160,
                            decoration: BoxDecoration(
                              // color: Color(0xffCCCCCC),
                              color: _generateColor(widget.mapData['grade']),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Center(
                              child: Text(
                                widget.mapData['grade'],
                                style: TextStyle(
                                    color: Color(0xffF5F5F5),
                                    fontSize: size.width * 22),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 30,
                          ),
                          Container(
                            height: size.width * 46,
                            width: size.width * 160,
                            decoration: BoxDecoration(
                              color: Color(0xff4CAF50),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Center(
                              child: Text(
                                widget.mapData['state'],
                                style: TextStyle(
                                    color: Color(0xffF5F5F5),
                                    fontSize: size.width * 22),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ))));
  }
}
