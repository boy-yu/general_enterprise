import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class StudyPlanTextbookLedgerList extends StatefulWidget {
  StudyPlanTextbookLedgerList({this.title, this.id});
  final String title;
  final int id;
  @override
  _StudyPlanTextbookLedgerListState createState() =>
      _StudyPlanTextbookLedgerListState();
}

class _StudyPlanTextbookLedgerListState
    extends State<StudyPlanTextbookLedgerList> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  List compulsoryList = []; // 必修
  List electiveList = []; // 选修
  List myExaminationList = []; // 台账

  init() {
    myDio.request(
        type: "get",
        url: Interface.getMyListPlanById,
        queryParameters: {'planId': widget.id}).then((value) {
      if (value is Map) {
        compulsoryList = value['compulsoryList'];
        electiveList = value['electiveList'];
        myExaminationList = value['myExaminationList'];
      }
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(widget.title.toString()),
        child: Transtion(
            ListView(
              children: [
                compulsoryList.isNotEmpty
                    ? Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/icon_textbook_type.png',
                                  width: size.width * 30,
                                  height: size.width * 30,
                                ),
                                SizedBox(
                                  width: size.width * 30,
                                ),
                                Text(
                                  '必修教材',
                                  style: TextStyle(
                                      fontSize: size.width * 28,
                                      color: Color(0xffA3A3A3),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                                children: compulsoryList
                                    .asMap()
                                    .keys
                                    .map((index) => InkWell(
                                          onTap: () {
                                            //  必修教材
                                            Navigator.of(context).pushNamed(
                                                '/home/education/study',
                                                arguments: {
                                                  'id': compulsoryList[index]
                                                      ['resourcesId'],
                                                  'submitStudyRecords': {
                                                    "planId": widget.id,
                                                    "resourcesId": compulsoryList[index]['resourcesId'],
                                                    "type": 2
                                                  }
                                                }).then((value) {
                                                  init();
                                              // 返回值
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.width * 15),
                                            padding: EdgeInsets.symmetric(
                                                vertical: size.width * 20,
                                                horizontal: size.width * 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0)
                                                ]),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  compulsoryList[index]
                                                      ['coverUrl'],
                                                  height: size.width * 139,
                                                  width: size.width * 209,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 350,
                                                          child: Text(
                                                              compulsoryList[
                                                                      index]
                                                                  ['title'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff333333),
                                                                  fontSize:
                                                                      size.width *
                                                                          28,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 20,
                                                        ),
                                                        Text(
                                                          compulsoryList[index][
                                                                      'status'] ==
                                                                  1
                                                              ? '已完成'
                                                              : '未完成',
                                                          style: TextStyle(
                                                            color: compulsoryList[
                                                                            index]
                                                                        [
                                                                        'status'] ==
                                                                    1
                                                                ? Color(
                                                                    0xff78C78D)
                                                                : Color(
                                                                    0xff666666),
                                                            fontSize:
                                                                size.width * 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.width * 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 350,
                                                          child: Text(
                                                              compulsoryList[
                                                                      index][
                                                                  'introduction'],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          22,
                                                                  color: Color(
                                                                      0xff999999)),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 20,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    true,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return ShowDialog(
                                                                      child:
                                                                          Center(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          size.width *
                                                                              500,
                                                                      width: size
                                                                              .width *
                                                                          690,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(size.width * 10))),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: size.width *
                                                                                20,
                                                                            vertical:
                                                                                size.width * 10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.clear,
                                                                                    size: size.width * 40,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              compulsoryList[index]['title'],
                                                                              style: TextStyle(fontSize: size.width * 36, color: Color(0xff0059FF), fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.width * 30,
                                                                            ),
                                                                            Text(
                                                                              '学习计划主要内容：${compulsoryList[index]['introduction']}',
                                                                              style: TextStyle(fontSize: size.width * 30, color: Color(0xff9D9D9D)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ));
                                                                });
                                                          },
                                                          child: Text(
                                                            '[详情]',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff1D3DEB),
                                                                fontSize:
                                                                    size.width *
                                                                        20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.width * 10,
                                                    ),
                                                    Text(
                                                      '本教材包含${compulsoryList[index]['classHours']}个课时',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 16,
                                                          color: Color(
                                                              0xff16CAA2)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          ],
                        ),
                      )
                    : Container(),
                electiveList.isNotEmpty
                    ? SizedBox(
                        height: size.width * 20,
                      )
                    : Container(),
                electiveList.isNotEmpty
                    ? Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/icon_textbook_type.png',
                                  width: size.width * 30,
                                  height: size.width * 30,
                                ),
                                SizedBox(
                                  width: size.width * 30,
                                ),
                                Text(
                                  '选修教材',
                                  style: TextStyle(
                                      fontSize: size.width * 28,
                                      color: Color(0xffA3A3A3),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                                children: electiveList
                                    .asMap()
                                    .keys
                                    .map((index) => InkWell(
                                      onTap: () {
                                            //  选修教材
                                            Navigator.of(context).pushNamed(
                                                '/home/education/study',
                                                arguments: {
                                                  'id': electiveList[index]
                                                      ['resourcesId'],
                                                  'submitStudyRecords': {
                                                    "planId": widget.id,
                                                    "resourcesId": compulsoryList[index]['resourcesId'],
                                                    "type": 1
                                                  }     
                                                }).then((value) {
                                                  init();
                                              // 返回值
                                            });
                                          },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 15),
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 20,
                                              horizontal: size.width * 20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 20)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 1.0,
                                                    spreadRadius: 1.0)
                                              ]),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                electiveList[index]['coverUrl'],
                                                height: size.width * 139,
                                                width: size.width * 209,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: size.width * 350,
                                                        child: Text(
                                                            electiveList[index]
                                                                ['title'],
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff333333),
                                                                fontSize:
                                                                    size.width *
                                                                        28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 20,
                                                      ),
                                                      Text(
                                                        electiveList[index][
                                                                    'status'] ==
                                                                1
                                                            ? '已完成'
                                                            : '未完成',
                                                        style: TextStyle(
                                                          color: electiveList[
                                                                          index]
                                                                      [
                                                                      'status'] ==
                                                                  1
                                                              ? Color(
                                                                  0xff78C78D)
                                                              : Color(
                                                                  0xff666666),
                                                          fontSize:
                                                              size.width * 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: size.width * 350,
                                                        child: Text(
                                                            electiveList[index][
                                                                'introduction'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        22,
                                                                color: Color(
                                                                    0xff999999)),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  true,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ShowDialog(
                                                                    child:
                                                                        Center(
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        size.width *
                                                                            500,
                                                                    width:
                                                                        size.width *
                                                                            690,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(size.width *
                                                                                10))),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: size.width *
                                                                              20,
                                                                          vertical:
                                                                              size.width * 10),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Spacer(),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.clear,
                                                                                  size: size.width * 40,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            electiveList[index]['title'],
                                                                            style: TextStyle(
                                                                                fontSize: size.width * 36,
                                                                                color: Color(0xff0059FF),
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                size.width * 30,
                                                                          ),
                                                                          Text(
                                                                            '学习计划主要内容：${electiveList[index]['introduction']}',
                                                                            style:
                                                                                TextStyle(fontSize: size.width * 30, color: Color(0xff9D9D9D)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ));
                                                              });
                                                        },
                                                        child: Text(
                                                          '[详情]',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff1D3DEB),
                                                              fontSize:
                                                                  size.width *
                                                                      20),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Text(
                                                    '本教材包含${electiveList[index]['classHours']}个课时',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 16,
                                                        color:
                                                            Color(0xff16CAA2)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                    )
                                      )
                                    .toList()),
                          ],
                        ),
                      )
                    : Container(),
                myExaminationList.isNotEmpty
                    ? SizedBox(
                        height: size.width * 20,
                      )
                    : Container(),
                myExaminationList.isNotEmpty
                    ? Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Column(
                            children: myExaminationList
                                .asMap()
                                .keys
                                .map((index) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 20,
                                          vertical: size.width * 30),
                                      margin: EdgeInsets.only(
                                          bottom: size.width * 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 18)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 1.0,
                                                blurRadius: 1.0),
                                          ]),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '第${myExaminationList[index]['stage']}阶段考试台账',
                                                style: TextStyle(
                                                    color: Color(0xff0A0A0A),
                                                    fontSize: size.width * 36,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: size.width * 5,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 28),
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                          text: '合格分数线：',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff0A0A0A))),
                                                      TextSpan(
                                                          text:
                                                              myExaminationList[
                                                                          index]
                                                                      [
                                                                      'passLine']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3EC87C))),
                                                      TextSpan(
                                                          text: '分',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff0A0A0A))),
                                                      myExaminationList[index]
                                                                  ['score'] !=
                                                              null
                                                          ? TextSpan(
                                                              text: ' | 得分： ',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff0A0A0A)))
                                                          : TextSpan(text: ''),
                                                      myExaminationList[index]['score'] != null && myExaminationList[index]['score'] != -1000
                                                          ? TextSpan(
                                                              text: myExaminationList[index]['score'].toString(),
                                                              style: TextStyle(
                                                                color: Color(0xff2E42F5)
                                                              )
                                                            )
                                                          : TextSpan(
                                                              text: '待考',
                                                              style: TextStyle(
                                                                color: Color(0xff2E42F5)
                                                              )
                                                            ),
                                                    ]),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          myExaminationList[index]['score'] != null && myExaminationList[index]['score'] != -1000
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        "/home/education/eduCheckExamLedgerDetails",
                                                        arguments: {
                                                          'examinationId':
                                                              myExaminationList[
                                                                      index][
                                                                  'examinationId']
                                                        });
                                                  },
                                                  child: Container(
                                                    height: size.width * 52,
                                                    width: size.width * 106,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF717171),
                                                            width:
                                                                size.width * 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        8))),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '查看',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff717171),
                                                          fontSize:
                                                              size.width * 30),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ))
                                .toList()),
                      )
                    : Container(),
              ],
            ),
            show));
  }
}
