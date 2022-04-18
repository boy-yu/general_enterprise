import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class HiddenDangerHome extends StatefulWidget {
  @override
  _HiddenDangerHomeState createState() => _HiddenDangerHomeState();
}

class _HiddenDangerHomeState extends State<HiddenDangerHome> {
  List<HiddenDangerInterface> hiddenDanger = [];
  int choose = -1;

  @override
  void initState() {
    super.initState();
    _init();
    _getData();
  }

  void _init() {
    hiddenDanger = [];
    hiddenDanger.add(HiddenDangerInterface(
      title: '现场管理类',
      contexts: ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      context: '作业场所、设施设备、防护、保险、信号等装置装备',
      image: 'assets/images/bg_site_management.png',
      icon: 'assets/images/icon_hidden_scene.png',
      name: '现场',
    ));
    hiddenDanger.add(HiddenDangerInterface(
      title: '基础管理类',
      contexts: ['安全规章制度', '安全培训教育', '应急管理'],
      context: '安全规章制度、安全培训教育、应急管理',
      image: 'assets/images/bg_basic_management.png',
      icon: 'assets/images/icon_hidden_base.png',
      name: '基础',
    ));
  }

  Map data = {  
    "totalNum": 0,
    "processingNum": 0
  };

  _getData(){
    myDio.request(
      type: 'get', 
      url: Interface.getTotalStatistics, 
    ).then((value) {
      if (value is Map) {
        data = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView(
      children: [
        Column(
          children: hiddenDanger
              .asMap()
              .keys
              .map((index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home/baseHidden',
                          arguments: {
                            "leftBar": hiddenDanger,
                            "title": hiddenDanger[index].title
                          });
                    },
                    child: Container(
                      height: size.width * 280,
                      margin: EdgeInsets.only(
                          right: size.width * 30,
                          top: size.width * 30,
                          left: size.width * 30),
                      padding: EdgeInsets.all(size.width * 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12, //阴影颜色
                                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                                blurRadius: 5.0, //阴影大小
                                spreadRadius: 0.0 //阴影扩散程度
                                ),
                          ]),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hiddenDanger[index].title,
                                style: TextStyle(
                                    color: Color(0xff393B3D),
                                    fontSize: size.width * 34,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: size.width * 29,
                              ),
                              Container(
                                  width: size.width * 300,
                                  child: Text(
                                    hiddenDanger[index].context,
                                    style: TextStyle(
                                        color: Color(0xffA0A2A3),
                                        fontSize: size.width * 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              Text(
                                '查看详情 >',
                                style: TextStyle(
                                    color: Color(0xff2F6EFD),
                                    fontSize: size.width * 22),
                              )
                            ],
                          ),
                          Spacer(),
                          Image.asset(
                            hiddenDanger[index].image,
                            height: size.width * 194,
                            width: size.width * 194,
                          ),
                          // Stack(
                          //   children: [
                          //     Image.asset(
                          //       hiddenDanger[index].image,
                          //       height: size.width * 194,
                          //       width: size.width * 194,
                          //     ),
                          //     GestureDetector(
                          //         onTap: () {
                          //           choose = index;
                          //           Navigator.pushNamed(
                          //               context, '/home/Queryhistory',
                          //               arguments: {
                          //                 "callback": _getHistory,
                          //                 "listTitle": [
                          //                   '排查人',
                          //                   '所在工位',
                          //                   '排查时间',
                          //                   '排查项',
                          //                   '排查状态'
                          //                 ],
                          //                 "layer": 'item',
                          //                 "listTable": [
                          //                   'reportingUser',
                          //                   'reportingDepartment',
                          //                   'reportingTime',
                          //                   'keyParameterIndex',
                          //                   'status'
                          //                 ],
                          //                 "showRiskAccountDialogDrop": false,
                          //                 "title": hiddenDanger[index]
                          //                     .title
                          //                     .toString(),
                          //                 "dropList": dropList,
                          //                 'noTime': false
                          //               }).then((value) {
                          //             dropList.forEach((element) {
                          //               element.forEach((_element) {
                          //                 _element['value'] = '';
                          //                 _element['title'] =
                          //                     _element['saveTitle'];
                          //               });
                          //             });
                          //           });
                          //         },
                          //         child: Image.asset(
                          //           'assets/images/hiddenHistory@2x.png',
                          //           height: size.width * 44,
                          //           width: size.width * 44,
                          //         ))
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context, 
              '/hiddenDanger/hiddenDangerGovernLedger', 
            );
          },
          child: Container(
            height: size.width * 280,
            margin: EdgeInsets.only(
                right: size.width * 30,
                top: size.width * 30,
                left: size.width * 30),
            padding: EdgeInsets.all(size.width * 40),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12, //阴影颜色
                    offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影大小
                    spreadRadius: 0.0 //阴影扩散程度
                  ),
                ]),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '隐患治理台账',
                      style: TextStyle(
                          color: Color(0xff393B3D),
                          fontSize: size.width * 34,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 29,
                    ),
                    Container(
                      width: size.width * 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '全厂发现的隐患历史共计',
                                  style: TextStyle(
                                    color: Color(0xffA0A2A3),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                TextSpan(
                                  text: '${data['totalNum']}条',
                                  style: TextStyle(
                                    color: Color(0xff3073FE),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '现存在隐患',
                                  style: TextStyle(
                                    color: Color(0xffA0A2A3),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                TextSpan(
                                  text: '${data['processingNum']}条',
                                  style: TextStyle(
                                    color: Color(0xffFF4040),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                TextSpan(
                                  text: '正在处理中',
                                  style: TextStyle(
                                    color: Color(0xffA0A2A3),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ],
                      )
                    ),
                    Spacer(),
                    Text(
                      '查看详情 >',
                      style: TextStyle(
                          color: Color(0xff2F6EFD), fontSize: size.width * 22),
                    )
                  ],
                ),
                Spacer(),
                Image.asset(
                  'assets/images/bg_ledger_icon.png',
                  height: size.width * 194,
                  width: size.width * 194,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
