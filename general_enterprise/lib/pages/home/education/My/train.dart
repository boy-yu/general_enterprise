import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
// import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/education/My/_examinePersonList.dart';
// import 'package:enterprise/pages/home/education/My/demand.dart';
// import 'package:enterprise/pages/home/productList/__postListDetails.dart';
// import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class EduTrain extends StatefulWidget {
  @override
  _EduTrainState createState() => _EduTrainState();
}

class _EduTrainState extends State<EduTrain> {
  ThrowFunc _throwFunc = new ThrowFunc();

  String _getText(int endTime) {
    // endTime 截止时间
    if (DateTime.now().millisecondsSinceEpoch <= endTime) {
      return '调研中';
    } else {
      return '已完成';
    }
  }

  Color _getResearchColor(int endTime) {
    // endTime 截止时间
    if (DateTime.now().millisecondsSinceEpoch < endTime) {
      return Color(0xff236DFF);
    } else {
      return Color(0xff666666);
    }
  }

  List dropList = [
    {
      'title': '我参与的',
      'data': [
        {
          'name': '我发起的',
        },
        {
          'name': '我参与的',
        },
      ],
      'value': '',
      'saveTitle': '我参与的'
    },
  ];

  List dropList1 = [
    {
      'title': '选择部门',
      'data': [],
      'value': '',
      'saveTitle': '查看全部'
    },
  ];

  int type = 2;

  Map queryParameters = {'type': 2};

  @override
  void initState() {
    super.initState();
    _getMyDepartment();
  }

  _getMyDepartment(){
    myDio.request(
        type: "get",
        url: Interface.getTrainMyDepartment,
        queryParameters: {'type': type}).then((value) {
      if (value is List) {
        dropList1[0]['data'] = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("培训需求调研"),
        child: Container(
          color: Colors.white,
          child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 培训类型
                  Expanded(
                    child: DropDown(
                      dropList,
                      0,
                      callbacks: (val) {
                        print(val);
                        if(val['status'] == '我发起的'){
                          type = 1;
                        }else{
                          type = 2;
                        }
                        queryParameters = {
                          'type': type
                        };
                        dropList1 = [
                          {
                            'title': '选择部门',
                            'data': [],
                            'value': '',
                            'saveTitle': '查看全部'
                          },
                        ];
                        _getMyDepartment();
                        _throwFunc.run(argument: queryParameters);
                        setState(() {});
                      },
                    ),
                  ),
                  // 培训方式
                  Expanded(
                    child: TrainDropDown(
                      dropList1,
                      0,
                      callbacks: (val) {
                        if(val['sponsorDepartment'] == '查看全部'){
                          queryParameters = {
                            'type': type
                          };
                        }else{
                          queryParameters = {
                            'type': type,
                            'departmentId': val['departmentId']
                          };
                        }
                        _throwFunc.run(argument: queryParameters);
                      },
                    ),
                  ),
                ]),
            Expanded(
                child: MyRefres(
                    child: (index, list) => InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, "/home/education/eduTrainDetail",
                          //     arguments: {
                          //       'state': _getText(list[index]['endTime'], list[index]['validTime']),
                          //       'id': list[index]['id']
                          //     }).then((value) => {
                          //       _throwFunc.run()
                          //     });
                          Navigator.pushNamed(
                              context, "/home/education/styduPlanDetail",
                              arguments: {
                                'planId': list[index]['id'],
                                'source': 1
                              });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 20,
                              vertical: size.width * 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff0059FF).withOpacity(0.1),
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0)
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 20,
                                    horizontal: size.width * 30),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_edu_my_peixun_xuqiu.png',
                                      height: size.width * 70,
                                      width: size.width * 70,
                                    ),
                                    SizedBox(
                                      width: size.width * 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 450,
                                          child: Text(
                                            list[index]['name'],
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.width * 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: size.width * 26,
                                                  fontWeight: FontWeight.bold),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: '发起部门：',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff666666))),
                                                TextSpan(
                                                    text: list[index]['sponsorDepartment'].toString(),
                                                    style: TextStyle(
                                                      color: Color(0xff666666),
                                                    )),
                                              ]),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      _getText(list[index]['endTime']),
                                      style: TextStyle(
                                          color: _getResearchColor(list[index]['endTime']),
                                          fontSize: size.width * 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Color(0xffE8E8E8),
                                height: size.width * 1,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 15,
                                    horizontal: size.width * 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: size.width * 30,
                                          width: size.width * 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFFF6E9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '起',
                                            style: TextStyle(
                                                color: Color(0xffFFAA25),
                                                fontSize: size.width * 18),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 10,
                                        ),
                                        Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  list[index]['createDate'])
                                              .toString()
                                              .substring(0, 19),
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 22),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: size.width * 30,
                                          width: size.width * 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFFF6E9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '止',
                                            style: TextStyle(
                                                color: Color(0xffFFAA25),
                                                fontSize: size.width * 18),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 10,
                                        ),
                                        Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  list[index]['endTime'])
                                              .toString()
                                              .substring(0, 19),
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 22),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                        ),
                    listParam: "records",
                    page: true,
                    throwFunc: _throwFunc,
                    url: Interface.getEducationTrainingResearchSponsorList,
                    queryParameters: queryParameters,
                    method: 'get'))
          ],
        ),
        ));
  }
}

// class EduTrainItem extends StatelessWidget {
//   EduTrainItem({this.data});
//   final Map data;

//   String _getText(int endTime, int validTime) {
//     // endTime 截止时间   validTime 有效期
//     if (DateTime.now().millisecondsSinceEpoch < endTime) {
//       return '调研中';
//     } else if (DateTime.now().millisecondsSinceEpoch < validTime) {
//       return '可发起';
//     } else {
//       return '已过期';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           Navigator.pushNamed(context, "/home/education/eduTrainDetail",
//               arguments: {
//                 'state': _getText(data['endTime'], data['validTime']),
//                 'id': data['id']
//               });
//         },
//         child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.width * 20, vertical: size.width * 10),
//             child: Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: size.width * 20, horizontal: size.width * 30),
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius.all(Radius.circular(size.width * 20)),
//                   gradient: LinearGradient(
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                     colors: [
//                       Color(0xffA3AEFF),
//                       Color(0xff5A68E7),
//                     ],
//                   ),
//                 ),
//                 child: Row(children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data['name'],
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: size.width * 30,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         data['isParticipateAll'] == 1 ? '调研部门：全厂' : '调研部门：${data['departmentNum']}个部门',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: size.width * 28,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         '调研有效期：${DateTime.fromMillisecondsSinceEpoch(data['validTime']).toString().substring(0, 10)}',
//                         style: TextStyle(
//                             color: Colors.white, fontSize: size.width * 22),
//                       ),
//                       Text(
//                         '调研发起时间：${DateTime.fromMillisecondsSinceEpoch(data['createDate']).toString().substring(0, 10)}',
//                         style: TextStyle(
//                             color: Colors.white, fontSize: size.width * 22),
//                       ),
//                       Text(
//                         '调研截止时间：${DateTime.fromMillisecondsSinceEpoch(data['endTime']).toString().substring(0, 10)}',
//                         style: TextStyle(
//                             color: Colors.white, fontSize: size.width * 22),
//                       )
//                     ],
//                   ),
//                   Spacer(),
//                   Container(
//                     height: size.width * 47,
//                     width: size.width * 132,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                           BorderRadius.all(Radius.circular(size.width * 23)),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       _getText(data['endTime'], data['validTime']),
//                       style: TextStyle(
//                           color: Color(0xff5A68E7), fontSize: size.width * 22),
//                     ),
//                   )
//                 ]))));
//   }
// }

// class EduTrainDetail extends StatefulWidget {
//   EduTrainDetail({this.state, this.id});
//   final String state;
//   final int id;
//   @override
//   _EduTrainDetailState createState() => _EduTrainDetailState();
// }

// class _EduTrainDetailState extends State<EduTrainDetail> {
//   bool show = false;

//   @override
//   void initState() {
//     super.initState();
//     _getData(widget.id);
//   }

//   Map data = {
//     "educationTrainingResources": [],
//     "isParticipateAll": 0,
//     "name": "",
//     "sponsorName": "",
//     "theme": "",
//     "validTime": 0,
//     "id": -1,
//     "endTime": 0,
//     "departmentList": [],
//     "principalList": [],
//     "createDate": 0,
//     "isPrincipal": null
//   };

//   List votingList = [];
//   List pickingList = [];

//   _getData(int id) {
//     print(id);
//     myDio.request(
//         type: "get",
//         url: Interface.getEducationTrainingResearchById,
//         queryParameters: {'id': id}).then((value) {
//       if (value is Map) {
//         data = value;
//         votingList = data['votingList'];
//         pickingList = data['pickingList'];
//       }
//       setState(() {
//         show = true;
//       });
//     });
//   }

//   _click(bool type, List list) {
//     WorkDialog.myDialog(context, () {}, 2,
//         widget: Container(
//             height: size.width * 600,
//             padding: EdgeInsets.all(10),
//             child: SingleChildScrollView(
//               child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.start,
//                   runAlignment: WrapAlignment.start,
//                   children: list
//                       .asMap()
//                       .keys
//                       .map((index) => Container(
//                           width: size.width * 250,
//                           height: size.width * 50,
//                           padding:
//                               EdgeInsets.symmetric(horizontal: size.width * 20),
//                           margin: EdgeInsets.symmetric(
//                               horizontal: size.width * 20,
//                               vertical: size.width * 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(width: 1, color: placeHolder)),
//                           alignment: Alignment.center,
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 type
//                                     ? 'assets/images/8691619248054_.pic_hd@2x.png'
//                                     : 'assets/images/8681619248047_.pic_hd@2x.png',
//                                 height: size.width * 27,
//                                 width: size.width * 24,
//                               ),
//                               SizedBox(
//                                 width: size.width * 5,
//                               ),
//                               Expanded(
//                                   child: Text(list[index]['name'],
//                                       style: TextStyle(
//                                           fontSize: size.width * 24,
//                                           color: Color(0xff333333)),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis))
//                             ],
//                           )))
//                       .toList()),
//             )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyAppbar(
//         title: Text("需求问卷"),
//         child: Transtion(
//             Column(
//               children: [
//                 Container(
//                   color: Colors.white,
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Text(data['name'],
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: size.width * 40)),
//                       Text(
//                           "发起时间：${DateTime.fromMillisecondsSinceEpoch(data['createDate']).toString().substring(0, 10)}丨发起人：${data['sponsorName']}",
//                           style: TextStyle(
//                               color: Color(0xff535353),
//                               fontSize: size.width * 26))
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "培训需求调研主题：${data['theme']}",
//                         style: TextStyle(fontSize: size.width * 25),
//                       ),
//                       SizedBox(height: size.width * 10),
//                       Row(
//                         children: [
//                           SizedBox(
//                             child: Text(
//                               "调研部门：",
//                               style: TextStyle(fontSize: size.width * 25),
//                             ),
//                             width: size.width * 180,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               if (data['isParticipateAll'] != 1) {
//                                 _click(true, data['departmentList']);
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                   color: themeColor,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Text(
//                                   data['isParticipateAll'] == 1
//                                       ? "全厂"
//                                       : data['departmentList']
//                                               .length
//                                               .toString() +
//                                           '个',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: size.width * 22)),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: size.width * 10),
//                       Row(
//                         children: [
//                           SizedBox(
//                             child: Text(
//                               "问卷执行人：",
//                               style: TextStyle(fontSize: size.width * 25),
//                             ),
//                             width: size.width * 180,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               _click(false, data['principalList']);
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                   color: themeColor,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Text("${data['principalList'].length}人",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: size.width * 22)),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: size.width * 10),
//                       Text(
//                         "需求调研有效期：${DateTime.fromMillisecondsSinceEpoch(data['validTime']).toString().substring(0, 10)}",
//                         style: TextStyle(fontSize: size.width * 25),
//                       ),
//                       Text(
//                         "需求调研开始时间：${DateTime.fromMillisecondsSinceEpoch(data['createDate']).toString().substring(0, 10)}",
//                         style: TextStyle(fontSize: size.width * 25),
//                       ),
//                       Text(
//                         "需求调研截止时间：${DateTime.fromMillisecondsSinceEpoch(data['endTime']).toString().substring(0, 10)}",
//                         style: TextStyle(fontSize: size.width * 25),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Expanded(
//                     child: widget.state == '调研中'
//                         ? Container(
//                             color: Colors.white,
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '相关教材',
//                                   style: TextStyle(
//                                       fontSize: size.width * 26,
//                                       color: Color(0xff333333),
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Expanded(
//                                   child: ListView.builder(
//                                       itemCount:
//                                           data['educationTrainingResources']
//                                               .length,
//                                       itemBuilder: (context, index) {
//                                         return Container(
//                                           padding:
//                                               EdgeInsets.all(size.width * 20),
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: size.width * 10,
//                                               vertical: size.width * 15),
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(
//                                                       size.width * 20)),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                     color: Colors.black12,
//                                                     blurRadius: 1.0,
//                                                     spreadRadius: 1.0)
//                                               ]),
//                                           child: Row(
//                                             children: [
//                                               Image.network(
//                                                 data['educationTrainingResources']
//                                                     [index]['coverUrl'],
//                                                 height: size.width * 139,
//                                                 width: size.width * 209,
//                                               ),
//                                               SizedBox(
//                                                 width: size.width * 20,
//                                               ),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     width: size.width * 400,
//                                                     child: Text(
//                                                       data['educationTrainingResources']
//                                                           [index]['title'],
//                                                       style: TextStyle(
//                                                           fontSize:
//                                                               size.width * 28,
//                                                           color:
//                                                               Color(0xff333333),
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: size.width * 10,
//                                                   ),
//                                                   Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.end,
//                                                     children: [
//                                                       Container(
//                                                         width: size.width * 350,
//                                                         child: Text(
//                                                             data['educationTrainingResources']
//                                                                         [index][
//                                                                     'introduction']
//                                                                 .toString(),
//                                                             style: TextStyle(
//                                                               fontSize:
//                                                                   size.width *
//                                                                       22,
//                                                               color: Color(
//                                                                   0xff999999),
//                                                             ),
//                                                             maxLines: 2,
//                                                             overflow:
//                                                                 TextOverflow
//                                                                     .ellipsis),
//                                                       ),
//                                                       SizedBox(
//                                                         width: size.width * 10,
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () {
//                                                           showDialog(
//                                                               context: context,
//                                                               barrierDismissible:
//                                                                   true,
//                                                               builder:
//                                                                   (BuildContext
//                                                                       context) {
//                                                                 return ShowDialog(
//                                                                     child:
//                                                                         Center(
//                                                                   child:
//                                                                       Container(
//                                                                     height:
//                                                                         size.width *
//                                                                             500,
//                                                                     width:
//                                                                         size.width *
//                                                                             690,
//                                                                     decoration: BoxDecoration(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         borderRadius:
//                                                                             BorderRadius.all(Radius.circular(size.width *
//                                                                                 10))),
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: EdgeInsets.symmetric(
//                                                                           horizontal: size.width *
//                                                                               20,
//                                                                           vertical:
//                                                                               size.width * 10),
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           Row(
//                                                                             children: [
//                                                                               Spacer(),
//                                                                               InkWell(
//                                                                                 onTap: () {
//                                                                                   Navigator.of(context).pop();
//                                                                                 },
//                                                                                 child: Icon(
//                                                                                   Icons.clear,
//                                                                                   size: size.width * 40,
//                                                                                   color: Colors.black,
//                                                                                 ),
//                                                                               )
//                                                                             ],
//                                                                           ),
//                                                                           Text(
//                                                                             data['educationTrainingResources'][index]['title'],
//                                                                             style: TextStyle(
//                                                                                 fontSize: size.width * 36,
//                                                                                 color: Color(0xff0059FF),
//                                                                                 fontWeight: FontWeight.bold),
//                                                                           ),
//                                                                           SizedBox(
//                                                                             height:
//                                                                                 size.width * 30,
//                                                                           ),
//                                                                           Text(
//                                                                             data['educationTrainingResources'][index]['introduction'].toString(),
//                                                                             style:
//                                                                                 TextStyle(fontSize: size.width * 30, color: Color(0xff9D9D9D)),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ));
//                                                               });
//                                                         },
//                                                         child: Text(
//                                                           '[简介]',
//                                                           style: TextStyle(
//                                                               fontSize:
//                                                                   size.width *
//                                                                       20,
//                                                               color: Color(
//                                                                   0xff1D3DEB)),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   SizedBox(
//                                                     height: size.width * 10,
//                                                   ),
//                                                   Text(
//                                                     '本教材包含${data['educationTrainingResources'][index]['classHours']}个课时',
//                                                     style: TextStyle(
//                                                         color:
//                                                             Color(0xff16CAA2),
//                                                         fontSize:
//                                                             size.width * 16),
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                       }),
//                                 )
//                               ],
//                             ))
//                         : SingleChildScrollView(
//                             child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 color: Colors.white,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "员工自选教材兴趣读排名前三",
//                                           style: TextStyle(
//                                               color: placeHolder,
//                                               fontSize: size.width * 26),
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             Navigator.pushNamed(context,
//                                                 "/home/education/myDemandStyduPlan",
//                                                 arguments: {
//                                                   "title": "员工自选教材兴趣度",
//                                                   'data': votingList
//                                                 });
//                                           },
//                                           child: Text(
//                                             "更多>",
//                                             style: TextStyle(
//                                                 color: placeHolder,
//                                                 fontSize: size.width * 26),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     votingList.isNotEmpty
//                                         ? DemandTextBook(
//                                             data: votingList[0],
//                                             padding: EdgeInsets.all(10),
//                                             margin: EdgeInsets.fromLTRB(
//                                                 10, 10, 10, 0))
//                                         : Container(),
//                                     SizedBox(
//                                       height: size.width * 20,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "问卷执行人选择教材   ",
//                                           style: TextStyle(
//                                               color: placeHolder,
//                                               fontSize: size.width * 26),
//                                         ),
//                                         Spacer(),
//                                         InkWell(
//                                           onTap: () {
//                                             Navigator.pushNamed(context,
//                                                 "/home/education/myDemandStyduPlan",
//                                                 arguments: {
//                                                   "title": "问卷执行人选择教材",
//                                                   'data': pickingList,
//                                                 });
//                                           },
//                                           child: Text(
//                                             "更多>",
//                                             style: TextStyle(
//                                                 color: placeHolder,
//                                                 fontSize: size.width * 26),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     pickingList.isNotEmpty
//                                         ? DemandTextBook(
//                                             data: pickingList[0],
//                                             padding: EdgeInsets.all(10),
//                                             margin: EdgeInsets.fromLTRB(
//                                                 10, 10, 10, 0))
//                                         : Container(),
//                                   ],
//                                 )))),
//                 widget.state == '已完成'
//                     ? Container()
//                     : widget.state == '可发起'
//                         ? Text(
//                             '请前往PC端发起学习计划',
//                           )
//                         // ? ElevatedButton(
//                         //     style: ButtonStyle(
//                         //         backgroundColor:
//                         //             MaterialStateProperty.all(themeColor)),
//                         //     onPressed: () {
//                         //       Navigator.pushNamed(context,
//                         //           "/home/education/eduInitiateStudyPlan",
//                         //           arguments: {
//                         //             'researchId': data['id'],
//                         //             'educationTrainingResources':
//                         //                 data['educationTrainingResources']
//                         //           });
//                         //     },
//                         //     child: Text("发起学习计划"))
//                         : ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(themeColor)),
//                             onPressed: () {
//                               myDio.request(
//                                   type: "delete",
//                                   url:
//                                       Interface.deleteEducationTrainingResearch,
//                                   queryParameters: {
//                                     'id': data['id']
//                                   }).then((value) {
//                                 Fluttertoast.showToast(msg: '取消成功');
//                                 Navigator.pop(context, false);
//                               });
//                             },
//                             child: Text("取消此次调研")),
//               ],
//             ),
//             show));
//   }
// }


class TrainDropDown extends StatefulWidget {
  const TrainDropDown(this.list, this.index, {Key key, this.callbacks})
      : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _TrainDropDownState createState() => _TrainDropDownState();
}

class _TrainDropDownState extends State<TrainDropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                widget.list[i]['data'].map<Widget>((_ele) {
                              Color _juegeColor() {
                                Color _color = widget.list[i]['value'] == '' &&
                                        _ele['sponsorDepartment'] == '查看全部'
                                    ? themeColor
                                    : widget.list[i]['value'] == _ele['sponsorDepartment']
                                        ? themeColor
                                        : Colors.white;
                                return _color;
                              }

                              Color _conColors = _juegeColor();
                              return GestureDetector(
                                onTap: () {
                                  widget.list[i]['value'] = _ele['sponsorDepartment'];
                                  if (_ele['sponsorDepartment'] == '查看全部') {
                                    widget.list[i]['title'] =
                                        widget.list[i]['saveTitle'];
                                  } else {
                                    widget.list[i]['title'] = _ele['sponsorDepartment'];
                                  }
                                  widget.callbacks({
                                    'sponsorDepartment': _ele['sponsorDepartment'],
                                    'departmentId': _ele['departmentId'],
                                  });
                                  setState(() {});
                                  // widget.getDataList();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 32),
                                  decoration: BoxDecoration(
                                      color: _conColors,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: underColor))),
                                  child: Center(
                                    child: Text(
                                      _ele['sponsorDepartment'],
                                      style: TextStyle(
                                          fontSize: size.width * 30,
                                          color: _conColors.toString() ==
                                                  'Color(0xff6ea3f9)'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ))
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: size.width * 220,
          height: size.width * 53,
          margin: EdgeInsets.all(size.width * 20.0),
          padding: EdgeInsets.only(
              left: size.width * 20.0, right: size.width * 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: size.width * 1,
              color: Color(0xffDCDCDC),
            ),
            borderRadius: BorderRadius.circular(size.width * 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.list[i]['title'].toString(),
                style: TextStyle(
                    color: Color(0xff898989),
                    fontSize: size.width * 22,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff898989),
                size: size.width * 30,
              ),
            ],
          ),
        ),
      ));
    }).toList());
  }
}

