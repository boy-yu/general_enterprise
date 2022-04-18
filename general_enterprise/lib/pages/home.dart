import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/myCustomColor.dart';
// import 'package:enterprise/pages/home/education/education.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class IndexIcons extends StatefulWidget {
  @override
  _IndexIcons createState() => _IndexIcons();
}

class _IndexIcons extends State<IndexIcons> with TickerProviderStateMixin {
  List roundUi = [];
  List<Widget> data = [];
  double _verClickValue = 0.0;
  ScrollController _controller = ScrollController();
  String month = '', day = '', weekDay = '';

  // List functionList = ['rwbgrew', 'etreh', 'mownnirne'];
  List<String> menuList = [];
  
  List homeOneIconList = [
      {
        'name': '安全作业',
        'icon': 'assets/images/icon_home_work.png',
        'unIcon': 'assets/images/un_icon_home_work.png',
        'router': "/home/work",
      },
      {
        'name': '隐患排查',
        'icon': 'assets/images/icon_home_hidden.png',
        'unIcon': 'assets/images/un_icon_home_hidden.png',
        'router': "/home/hiddenDanger",
      },
      {
        'name': '巡检点检',
        'icon': 'assets/images/icon_home_spot.png',
        'unIcon': 'assets/images/un_icon_home_spot.png',
        'router': "/home/spotCheck"
      },
      {
        'name': '企业清单',
        'icon': 'assets/images/icon_home_productList.png',
        'unIcon': 'assets/images/un_icon_home_productList.png',
        'router': "/index/productList"
      },
      {
        'name': '教育培训',
        'icon': 'assets/images/icon_home_education.png',
        'unIcon': 'assets/images/un_icon_home_education.png',
        'router': "/home/education/education"
      },
    ];

  List homeTwoIconList = [
      {
        'name': '总览',
        'icon': 'assets/images/zonglan@2x.png',
        'unIcon': 'assets/images/un_zonglan@2x.png',
        'router': "/home/overview"
      },
      {
        'name': '我的清单',
        'icon': 'assets/images/qindan@2x.png',
        'unIcon': 'assets/images/un_qindan@2x.png',
        'router': '/index/checkList'
      },
      {
        'name': '风险管控',
        'icon': 'assets/images/fenxian@2x.png',
        'unIcon': 'assets/images/un_fenxian@2x.png',
        'router': "/home/risk"
      },
      {
        'name': '封闭化管理',
        'icon': 'assets/images/fengbihua@2x.png',
        'unIcon': 'assets/images/un_fengbihua@2x.png',
        'router': '/home/closedManagement/closedManagement'
      },
    ];

  List homeThreeIconList = [
      {
        'name': '待办项',
        'icon': 'assets/images/sc@2x.png',
        'unIcon': 'assets/images/un_sc@2x.png',
        'router': "/index/waitWork"
      },
      // {
      //   'name': '生产标准化',
      //   'icon': 'assets/images/icon_home_Standardization.png',
      //   'unIcon': 'assets/images/un_icon_home_Standardization.png',
      //   'router': ""
      // },
      {
        'name': '企业合规性',
        'icon': 'assets/images/icon_home_compliance.png',
        'unIcon': 'assets/images/un_icon_home_compliance.png',
        'router': "/legitimate/legitimate"
      },
      {
        'name': '重大危险源',
        'icon': 'assets/images/icon_home_major_hazard.png',
        'unIcon': 'assets/images/un_icon_home_major_hazard.png',
        'router': "/index/bigDanger"
      },
      {
        'name': '应急救援',
        'icon': 'assets/images/icon_home_emergency.png',
        'unIcon': 'assets/images/un_icon_home_emergency.png',
        'router': "/emergencyRescue/emergencyRescueHome"
      },
      {
        'name': '两单两卡',
        'icon': 'assets/images/icon_home_twoSingleCard.png',
        'unIcon': 'assets/images/icon_home_twoSingleCard.png',
        'router': "/twoSingleCard/twoSingleCard"
      },
      {
        'name': '消防管理',
        'icon': 'assets/images/icon_home_fire_management.png',
        'unIcon': 'assets/images/un_icon_home_fire_management.png',
        'router': '/fireControl/fireControl'
      },
      // {
      //   'name': '物联感知',
      //   'icon': 'assets/images/icon_home_perception.png',
      //   'unIcon': 'assets/images/un_icon_home_perception.png',
      //   'router': ""
      // },
      {
        'name': '产品出入库',
        'icon': 'assets/images/churukuguanli@2x.png',
        'unIcon': 'assets/images/un_churukuguanli@2x.png',
        'router': '/fireworksCrackers/fireworksCrackers'
      },
    ];


  @override
  void initState() {
    super.initState();
    _initMsg();
    _getFunction();
  }

  @override
  void didUpdateWidget(covariant IndexIcons oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getFunction();
  }

  _getAppFunctionMenu() {
    myDio.request(
          type: 'get',
          url: Interface.getAppFunctionMenu,
    ).then((value)  {
      if(value is List){
        menuList = value.cast<String>();
        myprefs.setStringList('appFunctionMenu', menuList);
        setState(() {
          _getFunction();
        });
      }
    });
  }

  _getFunction() {
    if(myprefs.getStringList('appFunctionMenu') != null){
      menuList = myprefs.getStringList('appFunctionMenu');
    }else{
      _getAppFunctionMenu();
    }

    data = [
      IconRow(
          homeOneIconList: homeOneIconList,
          homeTwoIconList: homeTwoIconList,
          homeThreeIconList: homeThreeIconList,
          menuList: menuList), //  首页三排菜单
      menuList.contains('企业清单') ? IndexUi() : Container(), //  清单履职天数
      ChartTitle(title: '安全生产清单'),
      menuList.contains('企业清单')
          ? SafetyProductListUi()
          : Container(
              width: double.infinity,
              height: size.width * 300,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/image_not_yet_module.png',
                    width: size.width * 200,
                    height: size.width * 200,
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Text(
                    '暂未购买该模块',
                    style: TextStyle(fontSize: size.width * 24),
                  ),
                ],
              )),
      ChartTitle(title: '安全作业'),
      menuList.contains('安全作业')
          ? IndexWorkUi()
          : Container(
              width: double.infinity,
              height: size.width * 300,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/image_not_yet_module.png',
                    width: size.width * 200,
                    height: size.width * 200,
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Text(
                    '暂未购买该模块',
                    style: TextStyle(fontSize: size.width * 24),
                  ),
                ],
              )),
      ChartTitle(title: '风险管控'),
      menuList.contains('风险管控')
          ? IndexRiskUi()
          : Container(
              width: double.infinity,
              height: size.width * 300,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/image_not_yet_module.png',
                    width: size.width * 200,
                    height: size.width * 200,
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Text(
                    '暂未购买该模块',
                    style: TextStyle(fontSize: size.width * 24),
                  ),
                ],
              )),
    ];
    if (mounted) {
      setState(() {});
    }
  }

  _initMsg() {
    DateTime date = DateTime.now();
    month = date.month.toString();
    day = date.day.toString();
    List<String> week = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    weekDay = week[date.weekday - 1];
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future refresh() async {
    return Future.value(0);
  }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Refre(
            child: (child, _state, end, updata) {
              if (data.length == 8) {
                data.insert(1, child);
              } else {
                data[1] = child;
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (_controller.offset == 0.0) {
                          end();
                        }
                      },
                      onVerticalDragUpdate: (details) {
                        if (_controller.offset == 0.0) {
                          _state(details);
                        }

                        if (details.localPosition.dy - _verClickValue < 0) {
                          _verClickValue = details.localPosition.dy;
                          _controller.jumpTo(_controller.offset + 2);
                        } else {
                          if (_controller.offset - 2 > 0) {
                            _verClickValue = details.localPosition.dy;
                            _controller.jumpTo(_controller.offset - 2);
                          } else {
                            _controller.jumpTo(0);
                          }
                        }
                      },
                      onVerticalDragStart: (details) {
                        _verClickValue = details.localPosition.dy;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.bottomCenter,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/indexBarBgNew1.png')),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: !_controller.hasClients
                                        ? size.width * 107
                                        : (size.width * 107 -
                                                    _controller.offset <=
                                                0
                                            ? 0
                                            : size.width * 107 -
                                                _controller.offset),
                                    left: size.width * 67),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text('$month-$day',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 60)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 40),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                'assets/images/icon_home_gift.png',
                                                height: size.width * 28,
                                                width: size.width * 28),
                                            Text(weekDay,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: size.width * 24))
                                          ]),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        await Permission.camera.request();
                                        String barcode = await scanner.scan();
                                        // successToast(barcode.substring(0 ,4) ?? '');
                                        if (barcode == '9527') {
                                          Fluttertoast.showToast(
                                              msg: '请扫描纸质个人档案二维码');
                                        } else {
                                          if (barcode.substring(0, 4) ==
                                              'lwk:') {
                                            // 教育培训个人档案纸质扫码
                                            Navigator.pushNamed(
                                                context, '/personalImage',
                                                arguments: {
                                                  "barcode": barcode,
                                                });
                                          } else {
                                            if (barcode is String) {
                                              List<String> routerStr = [
                                                'riskFourList',
                                                'riskHistoryList',
                                                'myInspectionList',
                                                'code',
                                                'webControl'
                                              ];
                                              List<String> _router = [
                                                '/home/risk/riskFour',
                                                '/home/risk/riskDetails',
                                                '/index/checkList',
                                                'login',
                                                '/home/education/WebActiveControl'
                                              ];
                                              if (barcode != null &&
                                                  barcode.indexOf('|') > -1) {
                                                int _index = routerStr.indexOf(
                                                    barcode.split('|')[1]);
                                                if (_index > -1) {
                                                  if (_router[_index] ==
                                                      'login') {
                                                    myDio.request(
                                                        type: 'post',
                                                        url: Interface.scanCode,
                                                        data: {
                                                          "code": barcode
                                                              .split('|')[0],
                                                          "jsonObject": {}
                                                        }).then((value) {
                                                      print(value);
                                                    });
                                                  } else {
                                                    Navigator.pushNamed(context,
                                                        _router[_index],
                                                        arguments: {
                                                          "qrMessage": barcode
                                                              .split('|')[0],
                                                          "title": "扫码结果"
                                                        });
                                                  }
                                                }
                                              } else if (barcode
                                                      .indexOf('webControl') >
                                                  -1) {
                                                int _index = 4;
                                                myDio.request(
                                                    type: 'post',
                                                    url: Interface.scanCode,
                                                    data: {
                                                      "code": barcode,
                                                      "jsonObject": {}
                                                    }).then((value) {
                                                  print(value);
                                                });
                                                Navigator.pushNamed(
                                                    context, _router[_index],
                                                    arguments: {
                                                      "qrMessage": barcode,
                                                      "title": "扫码结果"
                                                    });
                                              }
                                            }
                                          }
                                        }
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.all(size.width * 30),
                                          child: Image.asset(
                                              'assets/images/icon_scan.png',
                                              height: size.width * 32,
                                              width: size.width * 32)),
                                    )
                                  ],
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 75),
                                margin: EdgeInsets.symmetric(
                                    vertical: size.width * 10),
                                child: Text(
                                    myprefs.getString('enterpriseName') ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28))),
                          ],
                        ),
                      ),
                    ),
                    myprefs.getString('token') != null
                        ? Expanded(
                            child: ListView.builder(
                            controller: _controller,
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.only(top: 0),
                            itemBuilder: (context, index) => data[index],
                            itemCount: data.length,
                          ))
                        : Container(),
                  ]);
            },
            onRefresh: refresh)
        : Center(
            child: Image.asset(
              'assets/images/loading.gif',
              width: 120,
              height: 120,
            ),
          );
  }
}

class SafetyProductListUi extends StatefulWidget {
  @override
  _SafetyProductListUiState createState() => _SafetyProductListUiState();
}

class _SafetyProductListUiState extends State<SafetyProductListUi> {
  List data = [
    {
      'icon': 'assets/images/icon_safety_product_list_main.png',
      'name': '主体责任清单        ',
      'currentNum': 0,
      'totalNum': 28,
    },
    {
      'icon': 'assets/images/icon_safety_product_list_today.png',
      'name': '日常工作清单        ',
      'currentNum': 0,
      'totalNum': 28,
    },
    {
      'icon': 'assets/images/icon_safety_product_list_post.png',
      'name': '岗位责任清单        ',
      'currentNum': 0,
      'totalNum': 28,
    },
    {
      'icon': 'assets/images/icon_safety_product_list_risk.png',
      'name': '重大风险管控清单',
      'currentNum': 0,
      'totalNum': 28,
    },
  ];

  _getIndex() {
    myDio
        .request(type: 'get', url: Interface.getIndexResopnSafeLIst)
        .then((value) {
      if (value is Map) {
        data[0]['currentNum'] = value['listMainProportion']['completedNum'];
        data[0]['totalNum'] = value['listMainProportion']['totalNum'];
        data[1]['currentNum'] =
            value['listDailyRiskProportion']['completedNum'];
        data[1]['totalNum'] = value['listDailyRiskProportion']['totalNum'];
        data[2]['currentNum'] =
            value['listJobRolesDutyProportion']['completedNum'];
        data[2]['totalNum'] = value['listJobRolesDutyProportion']['totalNum'];
        data[3]['currentNum'] =
            value['listMajorRiskProportion']['completedNum'];
        data[3]['totalNum'] = value['listMajorRiskProportion']['totalNum'];
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
            children: data
                .map((e) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 25, horizontal: size.width * 20),
                    child: Row(children: [
                      Container(
                          height: size.width * 60,
                          width: size.width * 60,
                          margin: EdgeInsets.only(right: size.width * 27),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff56E0FF),
                                    Color(0xff2182FF)
                                  ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff46BEFF).withOpacity(0.3),
                                    offset: Offset(0.0, 9.0),
                                    blurRadius: 8.0)
                              ]),
                          alignment: Alignment.center,
                          child: Image.asset(e['icon'],
                              height: size.width * 30, width: size.width * 26)),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(e['name'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff8F8F8F),
                                      fontSize: size.width * 26,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: size.width * 20,
                              ),
                              Text(
                                e['currentNum'].toString(),
                                style: TextStyle(
                                    color: Color(0xff8F8F8F),
                                    fontSize: size.width * 26),
                              )
                            ]),
                            Row(
                              children: [
                                ProgressComp(
                                    value: e['currentNum'] == 0
                                        ? 0
                                        : e['currentNum'] / e['totalNum'],
                                    width: size.width * 445,
                                    height: size.width * 8,
                                    frColor: Color(0xff0485FF),
                                    bgColor: Color(0xffEDF7FF)),
                                SizedBox(width: size.width * 70),
                                Text(e['totalNum'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff8F8F8F),
                                        fontSize: size.width * 26))
                              ],
                            )
                          ])
                    ])))
                .toList()));
  }
}

class IndexUi extends StatefulWidget {
  @override
  _IndexUiState createState() => _IndexUiState();
}

class _IndexUiState extends State<IndexUi> {
  @override
  void initState() {
    super.initState();
    _getIndex();
  }

  Map values = {"days": 20};
  _getIndex() {
    myDio
        .request(
            type: 'get', url: Interface.getIndexResopnSafeLIst, mounted: false)
        .then((value) {
      if (value is Map) {
        setState(() {
          values = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: size.width * 20),
        child: Column(children: [
          Container(
              color: Colors.white,
              child: Row(children: [
                SizedBox(width: size.width * 30),
                Padding(
                    padding: EdgeInsets.all(size.width * 25),
                    child: Image.asset("assets/images/icon_prodect_notice.png",
                        width: size.width * 28, height: size.width * 28)),
                Container(
                    width: size.width * 1,
                    height: size.width * 43,
                    color: Color(0xffDBDBDB)),
                SizedBox(width: size.width * 10),
                Container(
                    margin: EdgeInsets.all(size.width * 20),
                    decoration: BoxDecoration(
                        color: Color(0xff47D900), shape: BoxShape.circle),
                    width: size.width * 10,
                    height: size.width * 10),
                Row(children: [
                  Text('清单已履职',
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: size.width * 5),
                  Text((values['days'] ?? 0).toString(),
                      style: TextStyle(
                          color: Color(0xff47D900),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: size.width * 5),
                  Text('天',
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold))
                ])
              ])),
          SizedBox(height: size.width * 10)
        ]));
  }
}

class IndexRiskUi extends StatefulWidget {
  IndexRiskUi({Key key}) : super(key: key);

  @override
  _IndexRiskUiState createState() => _IndexRiskUiState();
}

class _IndexRiskUiState extends State<IndexRiskUi> {
  List<TogglePicType> titleBar = [
    TogglePicType(
        title: '风险控制情况',
        data: [
          XAxisSturct(names: '受控项', color: Color(0xff4DC996), nums: 0),
          XAxisSturct(names: '不受控项', color: Color(0xffF7464A), nums: 0)
        ],
        totalNum: 0),
    TogglePicType(
        title: '异常处置情况',
        data: [
          XAxisSturct(names: '待确认', color: Color(0xffFB681E), nums: 0),
          XAxisSturct(names: '待审批', color: Color(0xffFCC95C), nums: 0),
          XAxisSturct(names: '待整改', color: Color(0xffFBAC51), nums: 0),
        ],
        totalNum: 0),
  ];

  int choosed = 0;
  dynamic titleBarQueryParameters;

  // List<Color> _generateColor() {
  //   List<Color> _list = [];
  //   titleBar[choosed]['data'].forEach((e) {
  //     _list.add(e['color']);
  //   });
  //   return _list;
  // }

  String totalNum;
  Future<TogglePicTypedata> _getWorkState() async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    final value = await myDio.request(
        type: 'get', url: Interface.getImplementationStatistics);
    if (value is Map) {
      value.forEach((key, value) {
        if (key == 'totalNum') {
          totalNum = value.toString();
        }
        if (key == 'controlledNum') {
          _data.data[0].nums = value * 1.0;
        } else if (key == 'uncontrolledNum') {
          _data.data[1].nums = value * 1.0;
        }
      });
      _data.totalNum = value['totalNum'];
    }
    return _data;
  }

  Future<TogglePicTypedata> _getWorkPercen() async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[1].data);
    final value = await myDio.request(
      type: 'get',
      url: Interface.getDisposalDiddenDangersStatistics,
    );

    if (value is Map) {
      value.forEach((key, value) {
        _data.totalNum += value;
        if (key == 'confirmedNum') {
          _data.data[0].nums = value * 1.0;
          // titleBar[1]['data']
          //     .add({'name': '待确认', 'color': Color(0xffFB681E), 'value': value});
        } else if (key == 'approveNum') {
          _data.data[1].nums = value * 1.0;
          // titleBar[1]['data']
          //     .add({'name': '待审批', 'color': Color(0xffFCC95C), 'value': value});
        } else {
          _data.data[2].nums = value * 1.0;
          // titleBar[1]['data']
          //     .add({'name': '待整改', 'color': Color(0xffFBAC51), 'value': value});
        }
      });
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)]),
        child: Column(children: [
          CustomEchart().togglePic(
              centerChild: '总数',
              data: titleBar,
              onpress: (index) async {
                if (index == 0)
                  return await _getWorkState();
                else
                  return await _getWorkPercen();
              }),
          SizedBox(height: size.width * 20)
        ]));
  }
}

class IndexWorkUi extends StatefulWidget {
  IndexWorkUi({Key key}) : super(key: key);
  @override
  _IndexWorkUiState createState() => _IndexWorkUiState();
}

class _IndexWorkUiState extends State<IndexWorkUi> {
  List<TogglePicType> titleBar = [
    TogglePicType(
        title: '作业状态实时统计',
        data: [
          XAxisSturct(names: '未进行', color: Color(0xff596BFF), nums: 0),
          XAxisSturct(names: '已完成', color: Color(0xff24ABFD), nums: 0),
          XAxisSturct(names: '进行中', color: Color(0xff40E8FE), nums: 0),
          XAxisSturct(names: '已终断', color: Colors.grey, nums: 0),
        ],
        totalNum: 0),
    TogglePicType(
        title: '八大特殊作业的占比',
        data: [
          XAxisSturct(names: '临时用电', color: Color(0xffFAF16A), nums: 0),
          XAxisSturct(names: '盲板抽堵', color: Color(0xffFEB46E), nums: 0),
          XAxisSturct(names: '受限空间', color: Color(0xffAEF850), nums: 0),
          XAxisSturct(names: '吊装作业', color: Color(0xff74E887), nums: 0),
          XAxisSturct(names: '高处作业', color: Color(0xff6E95F1), nums: 0),
          XAxisSturct(names: '断路作业', color: Color(0xff24ABFD), nums: 0),
          XAxisSturct(names: '动土作业', color: Color(0xff40E8FE), nums: 0),
          XAxisSturct(names: '动火作业', color: Color(0xff596BFF), nums: 0),
        ],
        totalNum: 0),
  ];
  dynamic queryParameters;
  int choosed = 0;

  Future<TogglePicTypedata> _getWorkState() async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    final value =
        await myDio.request(type: 'get', url: Interface.workTypeToday);
    if (value is Map) {
      _data.data[0].nums = value['undoneNum'] * 1.0;
      _data.data[1].nums = value['completedNum'] * 1.0;
      _data.data[2].nums = value['processingNum'] * 1.0;
      _data.data[3].nums = value['interruptNum'] * 1.0;

      value.forEach((key, values) {
        _data.totalNum += values;
      });
    }
    return _data;
  }

  Future<TogglePicTypedata> _getWorkPercen() async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[1].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getWorkPercen,
        queryParameters: queryParameters);

    if (value is List && value.isNotEmpty) {
      // titleBar[1]['totalNum'] = 0.0;
      _data.data.forEach((ele) {
        value.forEach((element) {
          if (ele.names == element['workName']) {
            titleBar[1].totalNum += element['value'];
            ele.nums = element['value'] * 1.0;
            _data.totalNum += ele.nums.toInt();
          }
        });
      });
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)]),
        child: Column(children: [
          CustomEchart().togglePic(
              centerChild: '总数',
              data: titleBar,
              onpress: (index) async {
                if (index == 0) {
                  return await _getWorkState();
                } else {
                  return await _getWorkPercen();
                }
              }),
          SizedBox(height: size.width * 20)
        ]));
  }
}

class IconRow extends StatefulWidget {
  IconRow(
      {this.homeOneIconList,
      this.homeTwoIconList,
      this.homeThreeIconList,
      this.menuList});
  final List homeOneIconList;
  final List homeTwoIconList;
  final List homeThreeIconList;
  final List menuList;
  @override
  _IconRowState createState() => _IconRowState();
}

class _IconRowState extends State<IconRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topRight,
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/indexBarBgNew2.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.homeOneIconList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: size.width * 88),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.homeOneIconList
                        .asMap()
                        .keys
                        .map((index) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (!widget.menuList.contains(
                                  widget.homeOneIconList[index]['name'])) {
                                Fluttertoast.showToast(msg: '暂未购买该模块');
                              } else {
                                if ('/home/work' ==
                                        widget.homeOneIconList[index]
                                            ['router'] &&
                                    PeopleStructure.state) {
                                  successToast('通讯录正在加载，请稍后重试');
                                  return;
                                } else if ('/index/productList' ==
                                        widget.homeOneIconList[index]
                                            ['router'] &&
                                    PeopleStructure.state) {
                                  successToast('通讯录正在加载，请稍后重试');
                                  return;
                                }
                                Navigator.pushNamed(context,
                                    widget.homeOneIconList[index]['router'],
                                    arguments: {});
                              }
                            },
                            child: Column(children: [
                              Image.asset(
                                  widget.menuList.contains(
                                          widget.homeOneIconList[index]['name'])
                                      ? widget.homeOneIconList[index]['icon']
                                      : widget.homeOneIconList[index]['unIcon'],
                                  width: size.width * 48,
                                  height: size.width * 48),
                              SizedBox(height: size.width * 10),
                              Text(widget.homeOneIconList[index]['name'],
                                  style: TextStyle(
                                      color: widget.menuList.contains(widget
                                              .homeOneIconList[index]['name'])
                                          ? Colors.white
                                          : Color(0xffabbafb),
                                      fontSize: size.width * 24))
                            ])))
                        .toList(),
                  ),
                )
              : Container(),
          widget.homeTwoIconList.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(
                      top: size.width * 44,
                      left: size.width * 20,
                      right: size.width * 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.homeTwoIconList
                          .asMap()
                          .keys
                          .map(
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 30),
                              child: GestureDetector(
                                    onTap: () {
                                      if (!widget.menuList.contains(widget
                                          .homeTwoIconList[index]['name'])) {
                                        Fluttertoast.showToast(msg: '暂未购买该模块');
                                      } else {
                                        if (widget.homeTwoIconList[index]
                                                    ['router'] ==
                                                '/index/checkList' &&
                                            PeopleStructure.state) {
                                          successToast('通讯录正在加载，请稍后重试');
                                          return;
                                        }
                                        if (widget.homeTwoIconList[index]
                                                ['router'] ==
                                            '') {
                                          Fluttertoast.showToast(msg: '敬请期待');
                                        } else {
                                          Navigator.pushNamed(
                                              context,
                                              widget.homeTwoIconList[index]
                                                  ['router'],
                                              arguments: {});
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          widget.menuList.contains(
                                                  widget.homeTwoIconList[index]
                                                      ['name'])
                                              ? widget.homeTwoIconList[index]
                                                  ['icon']
                                              : widget.homeTwoIconList[index]
                                                  ['unIcon'],
                                          width: size.width * 77,
                                          height: size.width * 66,
                                        ),
                                        Text(
                                          widget.homeTwoIconList[index]['name'],
                                          style: TextStyle(
                                              color: widget.menuList.contains(
                                                      widget.homeTwoIconList[
                                                          index]['name'])
                                                  ? Color(0xff333333)
                                                  : Color(0xffadadad),
                                              fontSize: size.width * 26,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                            ),
                          )
                          .toList()))
              : Container(),
          SizedBox(height: size.width * 30),
          widget.homeThreeIconList.isNotEmpty
              ? Container(
                  height: size.width * 130,
                  alignment: Alignment.center,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: size.width * 10),
                  child: ListView.builder(
                      itemCount: widget.homeThreeIconList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return widget.homeThreeIconList[index]['name'] != '两单两卡'
                            ? GestureDetector(
                                onTap: () {
                                  if (!widget.menuList.contains(widget
                                      .homeThreeIconList[index]['name'])) {
                                    Fluttertoast.showToast(msg: '暂未购买该模块');
                                  } else {
                                    if (widget.homeThreeIconList[index]
                                            ['router'] ==
                                        '') {
                                      Fluttertoast.showToast(msg: '敬请期待');
                                    } else {
                                      Navigator.pushNamed(
                                          context,
                                          widget.homeThreeIconList[index]
                                              ['router'],
                                          arguments: {});
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 25),
                                  child: widget.homeThreeIconList[index]
                                              ['name'] ==
                                          '待办项'
                                      ? Stack(children: [
                                          context
                                                      .watch<Counter>()
                                                      .notity
                                                      .length >
                                                  0
                                              ? Positioned(
                                                  right: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle),
                                                    width: 7,
                                                    height: 7,
                                                  ))
                                              : Container(),
                                          Column(children: [
                                            Image.asset(
                                              widget.menuList.contains(
                                                      widget.homeThreeIconList[
                                                          index]['name'])
                                                  ? widget.homeThreeIconList[
                                                      index]['icon']
                                                  : widget.homeThreeIconList[
                                                      index]['unIcon'],
                                              width: size.width * 68,
                                              height: size.width * 68,
                                            ),
                                            Text(
                                                widget.homeThreeIconList[index]
                                                    ['name'],
                                                style: TextStyle(
                                                    color: widget.menuList
                                                            .contains(widget
                                                                    .homeThreeIconList[
                                                                index]['name'])
                                                        ? Color(0xff2A2A2A)
                                                        : Color(0xffadadad),
                                                    fontSize: size.width * 24))
                                          ])
                                        ])
                                      : Column(
                                          children: [
                                            Image.asset(
                                                widget.menuList.contains(widget
                                                            .homeThreeIconList[
                                                        index]['name'])
                                                    ? widget.homeThreeIconList[
                                                        index]['icon']
                                                    : widget.homeThreeIconList[
                                                        index]['unIcon'],
                                                width: size.width * 68,
                                                height: size.width * 68),
                                            Text(
                                              widget.homeThreeIconList[index]
                                                  ['name'],
                                              style: TextStyle(
                                                  color: widget.menuList.contains(
                                                          widget.homeThreeIconList[
                                                              index]['name'])
                                                      ? Color(0xff2A2A2A)
                                                      : Color(0xffadadad),
                                                  fontSize: size.width * 24),
                                            )
                                          ],
                                        ),
                                ),
                              )
                            : widget.menuList.contains('两单两卡')
                                ? GestureDetector(
                                    onTap: () {
                                      if (!widget.menuList.contains(widget
                                          .homeThreeIconList[index]['name'])) {
                                        Fluttertoast.showToast(msg: '暂未购买该模块');
                                      } else {
                                        if (widget.homeThreeIconList[index]
                                                ['router'] ==
                                            '') {
                                          Fluttertoast.showToast(msg: '敬请期待');
                                        } else {
                                          Navigator.pushNamed(
                                              context,
                                              widget.homeThreeIconList[index]
                                                  ['router'],
                                              arguments: {});
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 25),
                                      child: widget.homeThreeIconList[index]
                                                  ['name'] ==
                                              '待办项'
                                          ? Stack(children: [
                                              context
                                                          .watch<Counter>()
                                                          .notity
                                                          .length >
                                                      0
                                                  ? Positioned(
                                                      right: 0,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                        width: 7,
                                                        height: 7,
                                                      ))
                                                  : Container(),
                                              Column(children: [
                                                Image.asset(
                                                  widget.menuList.contains(widget
                                                              .homeThreeIconList[
                                                          index]['name'])
                                                      ? widget.homeThreeIconList[
                                                          index]['icon']
                                                      : widget.homeThreeIconList[
                                                          index]['unIcon'],
                                                  width: size.width * 68,
                                                  height: size.width * 68,
                                                ),
                                                Text(
                                                    widget.homeThreeIconList[
                                                        index]['name'],
                                                    style: TextStyle(
                                                        color: widget.menuList
                                                                .contains(widget
                                                                            .homeThreeIconList[
                                                                        index]
                                                                    ['name'])
                                                            ? Color(0xff2A2A2A)
                                                            : Color(0xffadadad),
                                                        fontSize:
                                                            size.width * 24))
                                              ])
                                            ])
                                          : Column(
                                              children: [
                                                Image.asset(
                                                    widget.menuList.contains(
                                                            widget.homeThreeIconList[
                                                                index]['name'])
                                                        ? widget.homeThreeIconList[
                                                            index]['icon']
                                                        : widget.homeThreeIconList[
                                                            index]['unIcon'],
                                                    width: size.width * 68,
                                                    height: size.width * 68),
                                                Text(
                                                  widget.homeThreeIconList[
                                                      index]['name'],
                                                  style: TextStyle(
                                                      color: widget.menuList
                                                              .contains(widget
                                                                      .homeThreeIconList[
                                                                  index]['name'])
                                                          ? Color(0xff2A2A2A)
                                                          : Color(0xffadadad),
                                                      fontSize: size.width * 24),
                                                )
                                              ],
                                            ),
                                    ),
                                  )
                                : Container();
                      }),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ChartTitle extends StatefulWidget {
  ChartTitle({this.title, this.data});
  final String title;
  final Map data;
  @override
  _ChartTitleState createState() => _ChartTitleState();
}

class _ChartTitleState extends State<ChartTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.width * 20),
      padding: EdgeInsets.all(size.width * 20),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: size.width * 27,
            width: size.width * 5,
            margin: EdgeInsets.only(right: size.width * 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff5046FF),
                  Color(0xff416DFF),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

/*
 *  柱状统计图 
 */
class HomeEducationBar extends StatefulWidget {
  HomeEducationBar(
      {this.width = 30.0,
      this.height = 250.0,
      this.yWidth = 20.0,
      this.yAxis,
      this.color,
      this.yAxisList,
      this.xAxisList, this.showsTitle});
  final double width, height, yWidth, yAxis;
  final List<Color> color;
  final List yAxisList;
  final List<MutipleXAxisSturct> xAxisList;
  final int showsTitle;
  @override
  _HomeEducationBarState createState() => _HomeEducationBarState();
}

class _HomeEducationBarState extends State<HomeEducationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size.width * 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(
                  bottom: size.width * 20, left: size.width * 20),
              constraints: BoxConstraints(minWidth: widget.width),
              height: widget.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.yAxisList
                    .map(
                      (e) => Container(
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                              color: Color(0xff616B7B),
                              fontSize: size.width * 14),
                        ),
                      ),
                    )
                    .toList(),
              )),
          Expanded(
            child: Container(
              height: widget.height,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HomeEducationClickBar(
                    height: widget.height,
                    yAxisList: widget.yAxisList,
                    xAxisList: widget.xAxisList,
                    color: widget.color,
                    index: index,
                    yWidth: widget.yWidth,
                    showsTitle: widget.showsTitle,
                  );
                },
                itemCount: widget.xAxisList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeEducationClickBar extends StatefulWidget {
  HomeEducationClickBar(
      {this.height,
      this.yWidth,
      @required this.index,
      @required this.yAxisList,
      @required this.xAxisList,
      this.color, this.showsTitle});
  final double height, yWidth;
  final int index, showsTitle;
  final List yAxisList;
  final List<MutipleXAxisSturct> xAxisList;
  final List<Color> color;
  @override
  _HomeEducationClickBarState createState() => _HomeEducationClickBarState();
}

class _HomeEducationClickBarState extends State<HomeEducationClickBar>
    with TickerProviderStateMixin {
  bool showsTitle = false;
  List<double> height = [];
  List<AnimationController> _animationList = [];
  List<Animation> _curveList = [];
  Animation _curve;
  List<Color> color = [];
  @override
  void dispose() {
    _animationList.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  _initDate() {
    if (widget.color is List) {
      color = widget.color;
    }

    bool addtionColor = false;
    if (color.length < widget.xAxisList[widget.index].nums.length) {
      addtionColor = true;
      color = [];
    }
    widget.xAxisList[widget.index].nums.forEach((element) {
      double tempHeight = widget.yAxisList[0] == 0
          ? 0
          : widget.height / widget.yAxisList[0] * element;
      height.add(tempHeight);
      _animationList.add(
          AnimationController(vsync: this, duration: Duration(seconds: 3)));
      _curveList.add(_curve);
      if (addtionColor) {
        color.add(color.length % 2 == 0 ? themeColor : Color(0xffFFA100));
      }
    });
    for (var i = 0; i < _animationList.length; i++) {
      _curveList[i] =
          Tween(begin: 0.0, end: height[i]).animate(_animationList[i])
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
      _animationList[i].forward();
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.showsTitle == 1){
      showsTitle = true;
    }
    _initDate();
  }

  @override
  void didUpdateWidget(covariant HomeEducationClickBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initDate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            showsTitle = !showsTitle;
            if (mounted) {
              setState(() {});
            }
            setState(() {});
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.xAxisList[widget.index].nums
                  .asMap()
                  .keys
                  .map<Widget>((i) {
                return Column(
                  children: [
                    showsTitle
                        ? Center(
                            child: Text(
                              widget.xAxisList[widget.index].nums[i].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 12),
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * 5),
                      decoration: BoxDecoration(
                          color: widget.xAxisList[widget.index].color.length > i
                              ? widget.xAxisList[widget.index].color[i]
                              : color[i],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * 5.0),
                              topRight: Radius.circular(size.width * 5.0))),
                      height: _curveList[i].value,
                      width: size.width * 20,
                    )
                  ],
                );
              }).toList(),
            ),
            Container(
              constraints: BoxConstraints(minWidth: widget.yWidth * 2 + 20.0),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xffF4F4F4)))),
            ),
            SizedBox(
              height: size.width * 8,
            ),
            Container(
              width: size.width * 120,
              alignment: Alignment.center,
              child: Text(widget.xAxisList[widget.index].names.toString(),
                  style: TextStyle(fontSize: size.width * 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ));
  }
}
