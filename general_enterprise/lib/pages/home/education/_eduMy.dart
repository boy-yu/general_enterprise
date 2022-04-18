import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EduMy extends StatefulWidget {
  @override
  _EduMyState createState() => _EduMyState();
}

class _EduMyState extends State<EduMy> {
  bool show = false;
  SharedPreferences prefs;
  int isEducationInitiate = -1;

  _init() async {
    prefs = await SharedPreferences.getInstance();
    isEducationInitiate = prefs.getInt('isEducationInitiate');
    setState(() {
      show = true;
    });
  }

  int userId = -1;

  @override
  void initState() {
    super.initState();
    userId = myprefs.getInt('userId');
    _init();
    _getTitleData();
    _getMyPlanExaminationBookList();
    // _getPersonData();
    _getClassHours();
  }

  Map investigation = {
    "name": "",
    "departmentNum": 0,
    "validTime": 0,
    "id": -1,
    "endTime": 0,
    "createDate": 0
  };

  Map myResourcesCompletionStatistics = {
    "myTotalNum": 0,
    "totalNum": 0,
    "totalClassHours": 0,
    "myTotalClassHours": 0
  };

  _getTitleData() {
    myDio
        .request(
      type: "get",
      url: Interface.getMyResourcesCompletionStatistics,
    )
        .then((value) {
      if (value is Map) {
        myResourcesCompletionStatistics = value;
      }
      setState(() {});
    });
  }

  List myExamData = [];

  Map trainingPlanSponsor = {
    "num": 0,
    "name": "",
    "studyDeadline": 0,
    "id": -1,
    "createDate": 0
  };

  // 取消收藏
  // _deleteFavoritesResources(int resourcesId) {
  //   myDio.request(
  //       type: "delete",
  //       url: Interface.postDeleteFavoritesResources,
  //       data: {'resourcesId': resourcesId}).then((value) {
  //     Fluttertoast.showToast(msg: '取消收藏成功');
  //     _getmyCollectData();
  //   });
  // }

  Map myPlanExaminationBookList = {
    "avgScore": 0,
    "name": "",
    "theme": "",
    "id": -1
  };

  _getMyPlanExaminationBookList() {
    myDio.request(
        type: "get",
        url: Interface.getMyPlanExaminationBookList,
        queryParameters: {'current': 1, 'size': 1}).then((value) {
      if (value['records'] is List) {
        if (value['records'].isNotEmpty) {
          myPlanExaminationBookList = value['records'][0];
        }
      }
      setState(() {});
    });
  }

  Map personalFileData = {
    "industryName": "",
    // 考试测评
    "yearExaminatioEvaluation": [],
    "specialty": "",
    "education": "",
    "offlineTotalClassHours": 0,
    // 线下培训
    "yearOfflineClassHours": [],
    "certificate": "",
    "onLineTotalClassHours": 0,
    "type": "人员",
    "learningDetails": [],
    "offlineCurrentMonthClassHours": 0,
    "onLineCurrentMonthClassHours": 0,
    "identityNum": "",
    "photoUrl": "",
    "organizationCode": "",
    // 线上培训
    "yearOnLineClassHours": [],
    "nickname": "",
    "position": "",
    "enterName": ""
  };

  // _getPersonData() {
  //   myDio.request(
  //       type: "get",
  //       url: Interface.getPersonalFile,
  //       queryParameters: {'id': userId}).then((value) {
  //     if (value is Map) {
  //       personalFileData = value;
  //       if (mounted) {
  //         setState(() {});
  //       }
  //     }
  //   });
  // }

  _getClassHours(){
    myDio.request(
        type: "get",
        url: Interface.getClassHours,
        queryParameters: {'userId': userId}).then((value) {
      if (value is Map) {
        classHoursData = value;
        print(classHoursData);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Map classHoursData = {};

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('我的'),
      child: Transtion(
          Container(
            color: Colors.white,
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.width * 162,
                              width: size.width * 335,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '学习计划培训教材',
                                    style: TextStyle(
                                        color: Color(0xff222222),
                                        fontSize: size.width * 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text:
                                                  myResourcesCompletionStatistics[
                                                          'totalNum']
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: size.width * 48,
                                                  color: Color(0xff3368FA))),
                                          TextSpan(
                                              text: "本",
                                              style: TextStyle(
                                                  fontSize: size.width * 24,
                                                  color: Color(0xff999999))),
                                        ]),
                                    textDirection: TextDirection.ltr,
                                  ),
                                  Text(
                                    '总学时：${myResourcesCompletionStatistics['totalClassHours']}',
                                    style: TextStyle(
                                        fontSize: size.width * 24,
                                        color: Color(0xff3368FA)),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: size.width * 162,
                                width: size.width * 335,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '历史完成',
                                          style: TextStyle(
                                              color: Color(0xff222222),
                                              fontSize: size.width * 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        myResourcesCompletionStatistics[
                                                                'myTotalNum']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 48,
                                                        color:
                                                            Color(0xff3368FA))),
                                                TextSpan(
                                                    text: "本",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 24,
                                                        color:
                                                            Color(0xff999999))),
                                              ]),
                                          textDirection: TextDirection.ltr,
                                        ),
                                        Text(
                                          '总学时：${myResourcesCompletionStatistics['myTotalClassHours']}',
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              color: Color(0xff3368FA)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            left: size.width * 355,
                            top: size.width * 50,
                            child: Column(
                              children: [
                                Container(
                                  height: size.width * 10,
                                  width: size.width * 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xffDBDBDB),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 5))),
                                ),
                                SizedBox(
                                  height: size.width * 40,
                                ),
                                Container(
                                  height: size.width * 10,
                                  width: size.width * 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xffDBDBDB),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 5))),
                                ),
                              ],
                            ))
                      ],
                    )),
                // 培训需求调研
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/home/education/eduTrain");
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 10),
                          padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
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
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/pxxq@2x.png',
                            width: size.width * 64,
                            height: size.width * 64,
                          ),
                          SizedBox(
                            width: size.width * 30,
                          ),
                          Text(
                            '我的培训需求调研',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right
                          )
                        ],
                      ),
                  )
                ),
                // 我的学习计划
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/home/education/eduMySponsorPlan");
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 10),
                          padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
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
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/xxjh@2x.png',
                            width: size.width * 64,
                            height: size.width * 64,
                          ),
                          SizedBox(
                            width: size.width * 30,
                          ),
                          Text(
                            '我的学习计划',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right
                          )
                        ],
                      ),
                  )
                ),
                // 我参与的年度学习计划
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/home/education/eduMyAnnualPlan");
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 10),
                          padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
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
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/ndxxjh@2x.png',
                            width: size.width * 64,
                            height: size.width * 64,
                          ),
                          SizedBox(
                            width: size.width * 30,
                          ),
                          Text(
                            '我参与的年度学习计划',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          // Text(
                          //   '10个',
                          //   style: TextStyle(
                          //     color: Color(0xff333333),
                          //     fontSize: size.width * 26,
                          //     fontWeight: FontWeight.bold
                          //   ),
                          // ),
                          Icon(
                            Icons.keyboard_arrow_right
                          )
                        ],
                      ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 20, vertical: size.width * 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            "/home/education/eduMyStudyPlanHistoryList");
                      },
                      child: Text(
                        '我的考核记录>',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                //  我的考核记录
                myPlanExaminationBookList.isNotEmpty
                    ? EduPlayItem(data: myPlanExaminationBookList)
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 10),
                        height: size.width * 171,
                        width: double.infinity,
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
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/komg@2x.png',
                              height: size.width * 108,
                              width: size.width * 92,
                            ),
                            SizedBox(
                              width: size.width * 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '您还没有考核记录',
                                  style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 26,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: size.width * 5.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 20, vertical: size.width * 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            '/home/education/eduMyTrainFile',
                            // arguments: {
                            //   'personalFileData': personalFileData
                            // }
                            ).then((value) {
                          // 返回值
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            '个人安全教育培训信息档案>',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                // 个人档案
                classHoursData.isNotEmpty ? Container(
                    height: size.width * 123,
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 20, vertical: size.width * 10),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 20, horizontal: size.width * 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 20)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1.0,
                              color: Color(0xff0059FF).withOpacity(0.1),
                              spreadRadius: 1.0)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: size.width * 65,
                              height: size.width * 60,
                              padding: EdgeInsets.only(top: size.width * 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/icon_edu_per_record.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.topCenter,
                              child: Text(
                                '线上',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 20),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                        text: '总学时:  ',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: classHoursData[
                                                    'onlineClassHoursTotal']
                                                .toString() +
                                            '学时',
                                        style: TextStyle(
                                            color: Color(0xff3869FC),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                                SizedBox(
                                  height: size.width * 12,
                                ),
                                RichText(
                                  text: TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                        text: '本    月:  ',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: classHoursData['onlineClassHoursMonth']
                                                .toString() +
                                            '学时',
                                        style: TextStyle(
                                            color: Color(0xff3869FC),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width * 65,
                              height: size.width * 60,
                              padding: EdgeInsets.only(top: size.width * 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/icon_edu_per_record.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.topCenter,
                              child: Text(
                                '线下',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 20),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                        text: '总学时:  ',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: classHoursData[
                                                    'offlineClassHoursTotal']
                                                .toString() +
                                            '学时',
                                        style: TextStyle(
                                            color: Color(0xff3869FC),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                                SizedBox(
                                  height: size.width * 12,
                                ),
                                RichText(
                                  text: TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                        text: '本    月:  ',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: classHoursData[
                                                    'offlineClassHoursMonth']
                                                .toString() +
                                            '学时',
                                        style: TextStyle(
                                            color: Color(0xff3869FC),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )) : Container(),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: size.width * 20, vertical: size.width * 10),
                //   child: InkWell(
                //         onTap: () {
                //           Navigator.pushNamed(
                //                   context, "/home/education/eduCollectList")
                //               .then((value) {
                //             _getmyCollectData();
                //           });
                //         },
                //         child: Text(
                //           '我的收藏>',
                //           style: TextStyle(
                //               color: Color(0xff333333),
                //               fontSize: size.width * 26,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       )
                // ),
                // myCollectData.isNotEmpty
                //     ? Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: size.width * 20,
                //             vertical: size.width * 10),
                //         child:
                //         Column(
                //           children: myCollectData
                //                 .map(
                //                   (e) => Container(
                //                         margin: EdgeInsets.symmetric(vertical: size.width * 10),
                //                         decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                //                           boxShadow: [
                //                             BoxShadow(
                //                               color: Colors.black12,
                //                               blurRadius: 1.0,
                //                               spreadRadius: 1.0
                //                             ),
                //                           ],
                //                         ),
                //                         child: Row(
                //                           crossAxisAlignment: CrossAxisAlignment.start,
                //                           children: [
                //                             GestureDetector(
                //                               onTap: (){
                //                                 Navigator.of(context).pushNamed(
                //                                     '/home/education/study',
                //                                     arguments: {
                //                                       'id': e['id'],
                //                                     }).then((value) {
                //                                   // 返回值
                //                                 });
                //                               },
                //                               child: Container(
                //                                 height: size.width * 166,
                //                                 width: size.width * 277,
                //                                 decoration:BoxDecoration(
                //                                   borderRadius: BorderRadius.horizontal(left: Radius.circular(size.width * 10)),
                //                                   image: DecorationImage(
                //                                     fit: BoxFit.cover,
                //                                     image: NetworkImage(e['coverUrl'],),
                //                                   ),
                //                                 ),
                //                                 alignment: Alignment.bottomCenter,
                //                                 child: Container(
                //                                   width: double.infinity,
                //                                   height: size.width * 40,
                //                                   decoration:BoxDecoration(
                //                                     color: Colors.black.withOpacity(0.3),
                //                                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(size.width * 10)),
                //                                   ),
                //                                   alignment: Alignment.center,
                //                                   child: Text(
                //                                     '开始学习',
                //                                     style: TextStyle(
                //                                       color: Colors.white,
                //                                       fontSize: size.width * 26,
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                             Padding(
                //                               padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 10),
                //                               child: Column(
                //                                 crossAxisAlignment: CrossAxisAlignment.start,
                //                                 children: [
                //                                   Row(
                //                                     crossAxisAlignment: CrossAxisAlignment.end,
                //                                     children: [
                //                                       Container(
                //                                         width: size.width * 325,
                //                                         child: Text(
                //                                           e['title'],
                //                                           style: TextStyle(
                //                                             fontSize:size.width * 26,
                //                                             color:Color(0xff333333),
                //                                             fontWeight:FontWeight.bold
                //                                           ),
                //                                           maxLines: 2,
                //                                           overflow: TextOverflow.ellipsis
                //                                         ),
                //                                       ),
                //                                       SizedBox(
                //                                         width: size.width * 20,
                //                                       ),
                //                                       GestureDetector(
                //                                         onTap: (){
                //                                           // 取消收藏
                //                                           _deleteFavoritesResources(e['id']);
                //                                         },
                //                                         child: Image.asset(
                //                                           'assets/images/icon_edu_shoucang_isxx@2x.png',
                //                                           width: size.width * 34,
                //                                           height: size.width * 34,
                //                                         ),
                //                                       )
                //                                     ]
                //                                   ),
                //                                   SizedBox(
                //                                     height: size.width * 10,
                //                                   ),
                //                                   Row(
                //                                     crossAxisAlignment: CrossAxisAlignment.end,
                //                                     children: [
                //                                       Container(
                //                                         width: size.width * 300,
                //                                         child: Text(
                //                                           e['introduction'],
                //                                           style: TextStyle(
                //                                             fontSize: size.width * 22,
                //                                             color: Color(0xff666666),
                //                                           ),
                //                                           maxLines: 2,
                //                                           overflow: TextOverflow.ellipsis
                //                                         ),
                //                                       ),
                //                                       SizedBox(
                //                                         width: size.width * 10,
                //                                       ),
                //                                       GestureDetector(
                //                                         onTap: (){
                //                                           showDialog(
                //                                             context: context,
                //                                             barrierDismissible: true,
                //                                             builder: (BuildContext context) {
                //                                               return ShowDialog(
                //                                                   child: Center(
                //                                                 child: Container(
                //                                                   height: size.width * 500,
                //                                                   width: size.width * 690,
                //                                                   decoration: BoxDecoration(
                //                                                       color: Colors.white,
                //                                                       borderRadius: BorderRadius
                //                                                           .all(Radius.circular(
                //                                                               size.width * 10))),
                //                                                   child: Padding(
                //                                                     padding: EdgeInsets.symmetric(
                //                                                         horizontal:
                //                                                             size.width * 20,
                //                                                         vertical:
                //                                                             size.width * 10),
                //                                                     child: Column(
                //                                                       children: [
                //                                                         Row(
                //                                                           children: [
                //                                                             Spacer(),
                //                                                             InkWell(
                //                                                               onTap: () {
                //                                                                 Navigator.of(
                //                                                                         context)
                //                                                                     .pop();
                //                                                               },
                //                                                               child: Icon(
                //                                                                 Icons.clear,
                //                                                                 size: size.width *
                //                                                                     40,
                //                                                                 color:
                //                                                                     Colors.black,
                //                                                               ),
                //                                                             )
                //                                                           ],
                //                                                         ),
                //                                                         Text(
                //                                                           e['title'],
                //                                                           style: TextStyle(
                //                                                               fontSize:
                //                                                                   size.width * 36,
                //                                                               color: Color(
                //                                                                   0xff0059FF),
                //                                                               fontWeight:
                //                                                                   FontWeight
                //                                                                       .bold),
                //                                                         ),
                //                                                         SizedBox(
                //                                                           height: size.width * 30,
                //                                                         ),
                //                                                         Text(
                //                                                           e['introduction'].toString(),
                //                                                           style: TextStyle(
                //                                                               fontSize:
                //                                                                   size.width * 30,
                //                                                               color: Color(
                //                                                                   0xff9D9D9D)),
                //                                                         ),
                //                                                       ],
                //                                                     ),
                //                                                   ),
                //                                                 ),
                //                                               ));
                //                                             });
                //                                         },
                //                                         child: Text(
                //                                           '[详情]',
                //                                           style: TextStyle(
                //                                             color: Color(0xff3869FC),
                //                                             fontSize: size.width * 24
                //                                           ),
                //                                         ),
                //                                       )
                //                                     ],
                //                                   )
                //                                 ],
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                 )
                //                 .toList()),
                //             // children: myCollectData
                //             //     .asMap()
                //             //     .keys
                //             //     .map((index) => Padding(
                //             //           padding: EdgeInsets.only(
                //             //               bottom: size.width * 20),
                //             //           child: Row(
                //             //             children: [
                //             //               Image.network(
                //             //                 myCollectData[index]['coverUrl'],
                //             //                 height: size.width * 128,
                //             //                 width: size.width * 180,
                //             //               ),
                //             //               SizedBox(
                //             //                 width: size.width * 20,
                //             //               ),
                //             //               Column(
                //             //                 crossAxisAlignment:
                //             //                     CrossAxisAlignment.start,
                //             //                 children: [
                //             //                   Text(
                //             //                     myCollectData[index]['title'],
                //             //                     style: TextStyle(
                //             //                         color: Color(0xff333333),
                //             //                         fontSize: size.width * 24,
                //             //                         fontWeight:
                //             //                             FontWeight.bold),
                //             //                   ),
                //             //                   SizedBox(
                //             //                     height: size.width * 10,
                //             //                   ),
                //             //                   Row(
                //             //                     crossAxisAlignment:
                //             //                         CrossAxisAlignment.end,
                //             //                     children: [
                //             //                       Container(
                //             //                         width: size.width * 300,
                //             //                         child: Text(
                //             //                             myCollectData[index]
                //             //                                 ['introduction'],
                //             //                             style: TextStyle(
                //             //                                 fontSize:
                //             //                                     size.width * 20,
                //             //                                 color: Color(
                //             //                                     0xff666666)),
                //             //                             maxLines: 2,
                //             //                             overflow: TextOverflow
                //             //                                 .ellipsis),
                //             //                       ),
                //             //                       SizedBox(
                //             //                         width: size.width * 10,
                //             //                       ),
                //             //                       InkWell(
                //             //                         onTap: () {
                //             //                           showDialog(
                //             //                               context: context,
                //             //                               barrierDismissible:
                //             //                                   true,
                //             //                               builder: (BuildContext
                //             //                                   context) {
                //             //                                 return ShowDialog(
                //             //                                     child: Center(
                //             //                                   child: Container(
                //             //                                     height:
                //             //                                         size.width *
                //             //                                             500,
                //             //                                     width:
                //             //                                         size.width *
                //             //                                             690,
                //             //                                     decoration: BoxDecoration(
                //             //                                         color: Colors
                //             //                                             .white,
                //             //                                         borderRadius:
                //             //                                             BorderRadius.all(Radius.circular(size.width *
                //             //                                                 10))),
                //             //                                     child: Padding(
                //             //                                       padding: EdgeInsets.symmetric(
                //             //                                           horizontal:
                //             //                                               size.width *
                //             //                                                   20,
                //             //                                           vertical:
                //             //                                               size.width *
                //             //                                                   10),
                //             //                                       child: Column(
                //             //                                         children: [
                //             //                                           Row(
                //             //                                             children: [
                //             //                                               Spacer(),
                //             //                                               InkWell(
                //             //                                                 onTap:
                //             //                                                     () {
                //             //                                                   Navigator.of(context).pop();
                //             //                                                 },
                //             //                                                 child:
                //             //                                                     Icon(
                //             //                                                   Icons.clear,
                //             //                                                   size: size.width * 40,
                //             //                                                   color: Colors.black,
                //             //                                                 ),
                //             //                                               )
                //             //                                             ],
                //             //                                           ),
                //             //                                           Text(
                //             //                                             myCollectData[index]
                //             //                                                 [
                //             //                                                 'title'],
                //             //                                             style: TextStyle(
                //             //                                                 fontSize: size.width *
                //             //                                                     36,
                //             //                                                 color:
                //             //                                                     Color(0xff0059FF),
                //             //                                                 fontWeight: FontWeight.bold),
                //             //                                           ),
                //             //                                           SizedBox(
                //             //                                             height:
                //             //                                                 size.width *
                //             //                                                     30,
                //             //                                           ),
                //             //                                           Text(
                //             //                                             myCollectData[index]
                //             //                                                 [
                //             //                                                 'introduction'],
                //             //                                             style: TextStyle(
                //             //                                                 fontSize: size.width *
                //             //                                                     30,
                //             //                                                 color:
                //             //                                                     Color(0xff9D9D9D)),
                //             //                                           ),
                //             //                                         ],
                //             //                                       ),
                //             //                                     ),
                //             //                                   ),
                //             //                                 ));
                //             //                               });
                //             //                         },
                //             //                         child: Text(
                //             //                           '[详情]',
                //             //                           style: TextStyle(
                //             //                               fontSize:
                //             //                                   size.width * 20,
                //             //                               color: Color(
                //             //                                   0xff1D3DEB)),
                //             //                         ),
                //             //                       ),
                //             //                     ],
                //             //                   )
                //             //                 ],
                //             //               ),
                //             //               Spacer(),
                //             //               InkWell(
                //             //                 onTap: () {
                //             //
                //             //                 },
                //             //                 child: Container(
                //             //                   height: size.width * 32,
                //             //                   width: size.width * 106,
                //             //                   decoration: BoxDecoration(
                //             //                     color: Colors.white,
                //             //                     borderRadius: BorderRadius.all(
                //             //                         Radius.circular(
                //             //                             size.width * 8)),
                //             //                     border: Border.all(
                //             //                         width: size.width * 1,
                //             //                         color: Color(0xff666666)),
                //             //                   ),
                //             //                   alignment: Alignment.center,
                //             //                   child: Text(
                //             //                     '取消收藏',
                //             //                     style: TextStyle(
                //             //                         color: Color(0xff666666),
                //             //                         fontSize: size.width * 18),
                //             //                   ),
                //             //                 ),
                //             //               )
                //             //             ],
                //             //           ),
                //             //         ))
                //             //     .toList()),
                //       )
                //     : Container(
                //             margin: EdgeInsets.symmetric(
                //                 horizontal: size.width * 20,
                //                 vertical: size.width * 10),
                //             height: size.width * 171,
                //             width: double.infinity,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.all(
                //                     Radius.circular(size.width * 20)),
                //                 color: Colors.white,
                //                 boxShadow: [
                //                   BoxShadow(
                //                       color: Color(0xff0059FF).withOpacity(0.1),
                //                       blurRadius: 1.0,
                //                       spreadRadius: 1.0)
                //                 ]),
                //             alignment: Alignment.center,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Image.asset(
                //                   'assets/images/komg@2x.png',
                //                   height: size.width * 108,
                //                   width: size.width * 92,
                //                 ),
                //                 SizedBox(
                //                   width: size.width * 30,
                //                 ),
                //                 Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       '您还没有收藏教材',
                //                       style: TextStyle(
                //                         color: Color(0xff666666),
                //                         fontSize: size.width * 26,
                //                         fontWeight: FontWeight.bold,
                //                         letterSpacing: size.width * 5.0,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             )
                //           ),
              ],
            ),
          ),
          show),
      actions: [
        IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                '/home/education/eduMyHistoryTextbook',
              )
                  .then((value) {
                // 返回值
              });
            }),
      ],
    );
  }
}

class EduPlayItem extends StatelessWidget {
  EduPlayItem({this.data});
  final Map data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/home/education/planList",
              arguments: {'id': data['id']});
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 20, vertical: size.width * 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
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
                    vertical: size.width * 20, horizontal: size.width * 30),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_edu_my_jihua_taizhang.png',
                      height: size.width * 70,
                      width: size.width * 70,
                    ),
                    SizedBox(
                      width: size.width * 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold),
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
                                    text: '考核平均分：',
                                    style: TextStyle(color: Color(0xff666666))),
                                TextSpan(
                                    text:
                                        '${data['avgScore'].toStringAsFixed(1)}分',
                                    style: TextStyle(color: Color(0xff236DFF))),
                              ]),
                        )
                      ],
                    ),
                    Spacer(),
                    Text(
                      '台账',
                      style: TextStyle(
                          color: Color(0xff236DFF),
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
                    vertical: size.width * 15, horizontal: size.width * 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text('学习计划内容：${data['theme']}',
                          style: TextStyle(
                              color: Color(0xff8E8D92),
                              fontSize: size.width * 22,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      width: size.width * 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return ShowDialog(
                                  child: Center(
                                child: Container(
                                  height: size.width * 500,
                                  width: size.width * 690,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 10))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 20,
                                        vertical: size.width * 10),
                                    child: Column(
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
                                          data['name'].toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 36,
                                              color: Color(0xff0059FF),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: size.width * 30,
                                        ),
                                        Text(
                                          data['theme'].toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 30,
                                              color: Color(0xff9D9D9D)),
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
                            color: Color(0xff3869FC),
                            fontSize: size.width * 24),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: size.width * 20, vertical: size.width * 10),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(
        //         vertical: size.width * 20, horizontal: size.width * 30),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
        //       gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: [
        //           Color(0xff4FD0A2),
        //           Color(0xff00C181),
        //         ],
        //       ),
        //     ),
        //     child: Row(
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               data['name'],
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: size.width * 30,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               children: [
        //                 Container(
        //                     width: size.width * 400,
        //                     child: Text('学习计划主要内容：${data['theme']}',
        //                         style: TextStyle(
        //                             fontSize: size.width * 24,
        //                             color: Colors.white),
        //                         maxLines: 2,
        //                         overflow: TextOverflow.ellipsis)),
        //                 SizedBox(
        //                   width: size.width * 20,
        //                 ),
        //                 InkWell(
        //                   onTap: () {
        //                     showDialog(
        //                         context: context,
        //                         barrierDismissible: true,
        //                         builder: (BuildContext context) {
        //                           return ShowDialog(
        //                               child: Center(
        //                             child: Container(
        //                               height: size.width * 500,
        //                               width: size.width * 690,
        //                               decoration: BoxDecoration(
        //                                   color: Colors.white,
        //                                   borderRadius: BorderRadius.all(
        //                                       Radius.circular(size.width * 10))),
        //                               child: Padding(
        //                                 padding: EdgeInsets.symmetric(
        //                                     horizontal: size.width * 20,
        //                                     vertical: size.width * 10),
        //                                 child: Column(
        //                                   children: [
        //                                     Row(
        //                                       children: [
        //                                         Spacer(),
        //                                         InkWell(
        //                                           onTap: () {
        //                                             Navigator.of(context).pop();
        //                                           },
        //                                           child: Icon(
        //                                             Icons.clear,
        //                                             size: size.width * 40,
        //                                             color: Colors.black,
        //                                           ),
        //                                         )
        //                                       ],
        //                                     ),
        //                                     Text(
        //                                       data['name'],
        //                                       style: TextStyle(
        //                                           fontSize: size.width * 36,
        //                                           color: Color(0xff0059FF),
        //                                           fontWeight: FontWeight.bold),
        //                                     ),
        //                                     SizedBox(
        //                                       height: size.width * 30,
        //                                     ),
        //                                     Text(
        //                                       '学习计划主要内容：${data['theme']}',
        //                                       style: TextStyle(
        //                                           fontSize: size.width * 30,
        //                                           color: Color(0xff9D9D9D)),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ));
        //                         });
        //                   },
        //                   child: Text(
        //                     '[简介]',
        //                     style: TextStyle(
        //                         fontSize: size.width * 20,
        //                         color: Color(0xff1D3DEB)),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Text(
        //               '考核平均分：${data['avgScore']}分',
        //               style: TextStyle(
        //                   color: Colors.white, fontSize: size.width * 22),
        //             )
        //           ],
        //         ),
        //         Spacer(),
        //         Container(
        //           height: size.width * 47,
        //           width: size.width * 132,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius:
        //                 BorderRadius.all(Radius.circular(size.width * 23)),
        //           ),
        //           alignment: Alignment.center,
        //           child: Text(
        //             '台账',
        //             style: TextStyle(
        //                 color: Color(0xff00C181), fontSize: size.width * 22),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

class EduMyStylePlan extends StatelessWidget {
  EduMyStylePlan({this.data});
  final Map data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.pushNamed(context, "/home/education/styduPlanDetail",
          //     arguments: {'planId': data['id']});
              Navigator.pushNamed(
                  context, "/home/education/styduPlanDetail",
                              arguments: {
                                'planId': data['id'],
                                'source': 2
                              });
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 20, vertical: size.width * 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
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
                    vertical: size.width * 20, horizontal: size.width * 30),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_edu_my_xuexi_jihua.png',
                      height: size.width * 70,
                      width: size.width * 70,
                    ),
                    SizedBox(
                      width: size.width * 15,
                    ),
                    Container(
                      width: size.width * 420,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold),
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
                                    style: TextStyle(color: Color(0xff666666))),
                                TextSpan(
                                    text: data['sponsorDepartment'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff666666),
                                    )),
                              ]),
                        )
                      ],
                    ),
                    ),
                    Spacer(),
                    Text(
                      DateTime.now().millisecondsSinceEpoch <
                              data['studyDeadline']
                          ? '进行中'
                          : '台账',
                      style: TextStyle(
                          color: DateTime.now().millisecondsSinceEpoch <
                                  data['studyDeadline']
                              ? Color(0xffFF6600)
                              : Color(0xff236DFF),
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
                    vertical: size.width * 15, horizontal: size.width * 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: size.width * 30,
                          width: size.width * 30,
                          decoration: BoxDecoration(
                            color: Color(0xffeef0fd),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '起',
                            style: TextStyle(
                                color: Color(0xff5A68E7),
                                fontSize: size.width * 18),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 10,
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  data['createDate'])
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
                            color: Color(0xffeef0fd),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '止',
                            style: TextStyle(
                                color: Color(0xff5A68E7),
                                fontSize: size.width * 18),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 10,
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  data['studyDeadline'])
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
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: size.width * 20, vertical: size.width * 10),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(
        //         vertical: size.width * 20, horizontal: size.width * 30),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
        //       color: Colors.white
        //     ),
        //     child: Row(
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               data['name'],
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: size.width * 30,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               data['isParticipateAll'] == 1 ? '全厂' : '参训部门：${data['num']}个部门',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: size.width * 28,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //             Text(
        //               '计划发起时间：${DateTime.fromMillisecondsSinceEpoch(data['createDate']).toString().substring(0, 19)}',
        //               style: TextStyle(
        //                   color: Colors.white, fontSize: size.width * 22),
        //             ),
        //             Text(
        //               '计划结束时间：${DateTime.fromMillisecondsSinceEpoch(data['studyDeadline']).toString().substring(0, 19)}',
        //               style: TextStyle(
        //                   color: Colors.white, fontSize: size.width * 22),
        //             )
        //           ],
        //         ),
        //         Spacer(),
        //         Container(
        //           height: size.width * 47,
        //           width: size.width * 132,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius:
        //                 BorderRadius.all(Radius.circular(size.width * 23)),
        //           ),
        //           alignment: Alignment.center,
        //           child: Text(
        //             DateTime.now().millisecondsSinceEpoch < data['studyDeadline']
        //                 ? '进行中'
        //                 : '台账',
        //             style: TextStyle(
        //                 color: Color(0xffF58635), fontSize: size.width * 22),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
