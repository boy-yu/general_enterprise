import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
// import 'package:enterprise/pages/home/education/My/_examinePersonList.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/productList/_postList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduMyTrainFile extends StatefulWidget {
  EduMyTrainFile({this.personalFileData});
  final Map personalFileData;
  @override
  _EduMyTrainFileState createState() => _EduMyTrainFileState();
}

class _EduMyTrainFileState extends State<EduMyTrainFile> {
  PageController _controller;

  List workData = [
    {
      "index": 0,
      "title": "我的",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false
    },
    {
      "index": 1,
      "title": "企业",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true
    },
  ];

  int choosed = 0;
  int oldPage = 0;

  void initState() {
    super.initState();
    _controller = PageController(initialPage: choosed);
    _controller.addListener(() {
      if (oldPage != _controller.page.toInt()) {
        choosed = _controller.page.toInt();
        oldPage = choosed;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Widget _changeTitle(width, item) {
    Widget _widget;
    if (item['title'] == '我的')
      _widget = EduTrainFileMy(
        personalFileData: widget.personalFileData,
      );
    else if (item['title'] == '企业') _widget = EduTrainFileEnterprise();
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: workData.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                choosed = ele['index'];
                _controller.animateToPage(choosed,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: choosed == ele['index'] ? Colors.white : null,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  ele['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          choosed == ele['index'] ? themeColor : Colors.white,
                      fontSize: size.width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 40, vertical: size.width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) =>
            _changeTitle(size.width, workData[index]),
        itemCount: workData.length,
      ),
    );
  }
}

class EduTrainFileMy extends StatefulWidget {
  EduTrainFileMy({this.personalFileData});
  final Map personalFileData;
  @override
  _EduTrainFileMyState createState() => _EduTrainFileMyState();
}

class _EduTrainFileMyState extends State<EduTrainFileMy> {
  int select = 1;

  Widget _getWidget() {
    switch (select) {
      case 1:
        return TrainingExamEvaluation();
        break;
      case 2:
        return EduMyMessage();
        break;
      case 3:
        return TrainingHoursDetails();
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Color(0xffF6F6F6),
            padding: EdgeInsets.symmetric(vertical: size.width * 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    select = 1;
                    setState(() {});
                  },
                  child: Text(
                    '培训学时明细',
                    style: TextStyle(
                        color:
                            select == 1 ? Color(0xff2758F4) : Color(0xff6B7072),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    select = 2;
                    setState(() {});
                  },
                  child: Text(
                    '个人信息',
                    style: TextStyle(
                        color:
                            select == 2 ? Color(0xff2758F4) : Color(0xff6B7072),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    select = 3;
                    setState(() {});
                  },
                  child: Text(
                    '培训考试测评情况',
                    style: TextStyle(
                        color:
                            select == 3 ? Color(0xff2758F4) : Color(0xff6B7072),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          _getWidget(),
        ],
      ),
    );
  }
}

class TrainingExamEvaluation extends StatefulWidget {
  TrainingExamEvaluation({this.userId});
  final int userId;
  @override
  _TrainingExamEvaluationState createState() => _TrainingExamEvaluationState();
}

class _TrainingExamEvaluationState extends State<TrainingExamEvaluation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/home/education/eduClassHours', arguments: {
              'title': '线上培训情况',
              'userId': widget.userId,
            }).then((value) {
              // 返回值
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 30),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/xianshang@2x.png',
                  height: size.width * 69,
                  width: size.width * 69,
                ),
                SizedBox(
                  width: size.width * 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '线上培训',
                      style: TextStyle(
                          color: Color(0xff373C40),
                          fontSize: size.width * 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/home/education/eduClassHours', arguments: {
              'title': '线下培训情况',
              'userId': widget.userId,
            }).then((value) {
              // 返回值
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 30),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/xianx@2x.png',
                  height: size.width * 69,
                  width: size.width * 69,
                ),
                SizedBox(
                  width: size.width * 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '线下培训',
                      style: TextStyle(
                          color: Color(0xff373C40),
                          fontSize: size.width * 32,
                          fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(
                    //   height: size.width * 15,
                    // ),
                    // RichText(
                    //   text: TextSpan(
                    //       style: TextStyle(fontSize: size.width * 28),
                    //       children: <InlineSpan>[
                    //         TextSpan(
                    //             text: '累计总学时：',
                    //             style: TextStyle(color: Color(0xff8d8d8d))),
                    //         TextSpan(
                    //             text: widget.offlineTotalClassHours.toString() +
                    //                 '学时',
                    //             style: TextStyle(color: Color(0xff3869FC))),
                    //       ]),
                    // )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EduMyMessage extends StatefulWidget {
  @override
  _EduMyMessageState createState() => _EduMyMessageState();
}

class _EduMyMessageState extends State<EduMyMessage> {
  int userId = -1;

  @override
  void initState() {
    super.initState();
    userId = myprefs.getInt('userId');
    _getData();
  }

  _getData() {
    myDio.request(
        type: "get",
        url: Interface.getPersonalTrainingFile,
        queryParameters: {'userId': userId}).then((value) {
      if (value is Map) {
        message = value;
        certificate = message['certificate'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Map message = {};

  List certificate = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bj@2x.png'), fit: BoxFit.cover),
      ),
      alignment: Alignment.topCenter,
      child: message.isNotEmpty
          ? ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.width * 30,
                      bottom: size.width * 100,
                      right: size.width * 30,
                      left: size.width * 30),
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 30, horizontal: size.width * 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 30))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.width * 212,
                            width: size.width * 170,
                            margin: EdgeInsets.only(left: size.width * 20),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 20)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: message['headUrl'] != '' && message['headUrl'] != null
                                    ? NetworkImage(message['headUrl'])
                                    : AssetImage(
                                        'assets/images/image_recent_control.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 45,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/eduxm@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '姓名:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['nickname'] != ''
                                            ? message['nickname']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff4A4A4A),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.width * 30,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/edusfz@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '身份证号:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['identityNum'] != ''
                                            ? message['identityNum']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff4A4A4A),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.width * 30,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/edurenyusn@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '人员类别:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['type'] != '' &&
                                                message['type'] != null
                                            ? message['type']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff4A4A4A),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffBED2FF),
                        margin: EdgeInsets.symmetric(vertical: size.width * 30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 300,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/eduxl@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '学历:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['education'] != ''
                                            ? message['education']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 300,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/eduzy@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '专业:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['specialty'] != ''
                                            ? message['specialty']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/lx@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '联系方式:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 550,
                                    child: Text(
                                        message['telephone'] != ''
                                            ? message['telephone']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/edugw@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '职务岗位:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 550,
                                    child: Text(
                                        message['position'] != ''
                                            ? message['position']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffBED2FF),
                        margin: EdgeInsets.symmetric(vertical: size.width * 30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/edudw@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '工作单位:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 550,
                                    child: Text(
                                        message['enterName'] != ''
                                            ? message['enterName']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/edushxy@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '社会信用代码:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 550,
                                    child: Text(
                                        message['organizationCode'] != ''
                                            ? message['organizationCode']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffBED2FF),
                        margin: EdgeInsets.symmetric(vertical: size.width * 30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/eduhy@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '行业类别:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 550,
                                    child: Text(
                                        message['industryName'] != ''
                                            ? message['industryName']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/zs@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '已持证书:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                certificate.isNotEmpty
                                    ? Column(
                                        children: certificate
                                            .asMap()
                                            .keys
                                            .map((index) => InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        '/legitimate/__licenseDetails',
                                                        arguments: {
                                                          "id":
                                                              certificate[index]
                                                                  ['id'],
                                                          'type': '个人档案',
                                                        });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                size.width *
                                                                    20),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: size.width *
                                                                500,
                                                            child: Text(
                                                                certificate[index]['name'] !=
                                                                        ''
                                                                    ? certificate[
                                                                            index]
                                                                        ['name']
                                                                    : '暂未填写',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    color: Color(
                                                                        0xff838385),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)),
                                                        Text(
                                                          '查看',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff5D8FFF),
                                                              fontSize:
                                                                  size.width *
                                                                      24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                    : Container()
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    ));
  }
}

class TrainingHoursDetails extends StatefulWidget {
  TrainingHoursDetails({this.userId});
  final int userId;
  @override
  _TrainingHoursDetailsState createState() => _TrainingHoursDetailsState();
}

class _TrainingHoursDetailsState extends State<TrainingHoursDetails> {
  final controller = TextEditingController();
  int userId = -1;

  @override
  void initState() {
    super.initState();
    selectDate = DateTime.now();
    if (widget.userId == null) {
      userId = myprefs.getInt('userId');
    } else {
      userId = widget.userId;
    }
    _getData();
  }

  @override
  void didUpdateWidget(TrainingHoursDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userId == null) {
      userId = myprefs.getInt('userId');
    } else {
      userId = widget.userId;
    }
    _getData();
  }

  _getData() {
    myDio.request(
        type: "get",
        url: Interface.getPersonalTrainingFileDetails,
        queryParameters: {
          'userId': userId,
          'time': selectDate.toString().substring(0, 7),
          'type': type,
          'keywords': keywords,
        }).then((value) {
      if (value is List) {
        data = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  List data = [];

  String keywords;

  int type = 1;

  List dropList1 = [
    {
      'title': '线上培训',
      'data': [
        {
          'name': '线上培训',
        },
        {
          'name': '线下培训',
        },
      ],
      'value': '',
      'saveTitle': '线上培训'
    },
  ];

  DateTime selectDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: size.width * 30,
                right: size.width * 30,
                top: size.width * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width * 50)),
              border:
                  Border.all(width: size.width * 1, color: Color(0xff999999)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: size.width * 20,
                ),
                Container(
                  width: size.width * 500,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: '搜索您的关键字',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      keywords = value;
                      _getData();
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 日期筛选
                Expanded(
                  child: InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          pickerTheme: DateTimePickerTheme(
                            showTitle: true,
                            confirm:
                                Text('确定', style: TextStyle(color: Colors.red)),
                            cancel: Text('取消',
                                style: TextStyle(color: Colors.cyan)),
                          ),
                          minDateTime: DateTime.parse("1980-05-21"),
                          initialDateTime: selectDate,
                          dateFormat: "yyyy-MM",
                          pickerMode: DateTimePickerMode.date,
                          locale: DateTimePickerLocale.zh_cn,
                          onConfirm: (dateTime, List<int> index) {
                        selectDate = dateTime;
                        _getData();
                      });
                    },
                    child: Container(
                      // width: size.width * 220,
                      height: size.width * 70,
                      margin: EdgeInsets.all(size.width * 30.0),
                      padding: EdgeInsets.only(
                          left: size.width * 20.0, right: size.width * 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: size.width * 2,
                          color: Color(0xff999999),
                        ),
                        borderRadius: BorderRadius.circular(size.width * 10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            selectDate != null
                                ? selectDate.toString().substring(0, 7)
                                : '选择年份',
                            style: TextStyle(
                    color: Color(0xff898989),
                    fontSize: size.width * 22,
                    fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            'assets/images/icon_my_msg_date.png',
                            height: size.width * 28,
                            width: size.width * 28,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // 培训方式
                Expanded(
                  child: MyTraninFileDropDown(
                    dropList1,
                    0,
                    callbacks: (val) {
                      if (val['status'] == '线上培训') {
                        type = 1;
                      } else if (val['status'] == '线下培训') {
                        type = 2;
                      }
                      _getData();
                    },
                  ),
                ),
              ]),
          Expanded(
            child: data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 30,
                            vertical: size.width * 15),
                        // padding: EdgeInsets.all(size.width * 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Text(
                                  data[index]['title'],
                                  style: TextStyle(
                                    color: Color(0xff404040),
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 28
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: size.width * 57,
                                  width: size.width * 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xff3074FF),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(size.width * 10), bottomLeft: Radius.circular(size.width * 10)),
                                  ),
                                  child: Text(
                                    data[index]['score'] == null ? '测试成绩：无' : '测试成绩：${data[index]['score']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 24
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Color(0xff404040), fontSize: size.width * 24),
                                        children: <InlineSpan>[
                                          TextSpan(text: '授课教师：',style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: data[index]['teacher'] == null ? "无" : data[index]['teacher'].toString()),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Color(0xff404040), fontSize: size.width * 24),
                                        children: <InlineSpan>[
                                          TextSpan(text: '学时：',style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: data[index]['classHours'] == null ? '无' : data[index]['classHours'].toString()),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Color(0xff404040), fontSize: size.width * 24),
                                        children: <InlineSpan>[
                                          TextSpan(text: '平台名称：',style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: data[index]['platformName'].toString()),
                                        ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Color(0xff404040), fontSize: size.width * 24),
                                        children: <InlineSpan>[
                                          TextSpan(text: type == 1 ? '测试时间：' : '签到时间：',style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: DateTime.fromMillisecondsSinceEpoch(data[index]['time']).toString().substring(0, 19)),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : Container(),
          ),
        ],
      ),
    ));
  }
}

// 企业
class EduTrainFileEnterprise extends StatefulWidget {
  @override
  _EduTrainFileEnterpriseState createState() => _EduTrainFileEnterpriseState();
}

class _EduTrainFileEnterpriseState extends State<EduTrainFileEnterprise> {
  PageController _pageController = PageController();
  int page = 0;
  int id = 0;

  List<Map> peoplePageList = [];

  @override
  void initState() {
    super.initState();
    _getData(0);
    _pageController.addListener(() {
      if (_pageController.page.toString().length == 3 &&
          _pageController.page.toString().substring(2, 3) == '0') {
        bool next = page > _pageController.page.toInt();
        page = _pageController.page.toInt();
        if (next) {
          for (var i = peoplePageList.length - 1; i > page; i--) {
            peoplePageList.removeAt(i);
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getData(int ids) {
    if (page < peoplePageList.length - 1) {
      _pageController.animateToPage(++page,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      return;
    }
    PeopleStructure.queryOnlyDepartment(ids).then((value) {
      if (value is List) {
        if (value.isNotEmpty) {
          peoplePageList.add({'departmentId': value});
          page = peoplePageList.length - 1;
          // _getUserDataList(index: page);
          _pageController.animateToPage(page,
              duration: Duration(milliseconds: 200), curve: Curves.linear);
          if (mounted) {
            setState(() {});
          }
        } else {
          Fluttertoast.showToast(msg: '已无下级单位');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: peoplePageList.length,
                itemBuilder: (context, index) => ListView.builder(
                    cacheExtent: 3,
                    itemCount: peoplePageList[index]['departmentId'].length,
                    itemBuilder: (context, _index) => PeopleItem(
                        mapData: peoplePageList[index]['departmentId'][_index],
                        nextCallback: () async {
                          List<HiddenDangerInterface> _leftbar = [];
                          // print('id------------------------------' +
                          //     id.toString());
                          id = peoplePageList[index]['departmentId'][_index].id;
                          List data = await PeopleStructure.getListPeople(id);
                          if (data.isEmpty) {
                            Fluttertoast.showToast(msg: '该部门下没有人员');
                            return;
                          }
                          _leftbar = _leftbar.changeHiddenDangerInterfaceType(
                              data,
                              title: 'name',
                              icon: 'static:photoUrl',
                              id: 'id',
                              name: 'name');
                          _leftbar[0].color = Colors.white;
                          Navigator.pushNamed(
                              context, '/index/productList/CommonPage',
                              arguments: {
                                "leftBar": _leftbar,
                                "index": 0,
                                "title": peoplePageList[index]['departmentId']
                                        [_index]
                                    .name,
                                "widgetType": 'EduPersonFile',
                              });
                        },
                        callback: () {
                          id = peoplePageList[index]['departmentId'][_index].id;
                          _getData(id);
                        })))),
      ],
    );
  }
}

class EduPersonFile extends StatefulWidget {
  EduPersonFile({this.id, this.throwFunc});
  final int id;
  final ThrowFunc throwFunc;
  @override
  _EduPersonFileState createState() => _EduPersonFileState();
}

class _EduPersonFileState extends State<EduPersonFile> {
  @override
  void initState() {
    super.initState();
    _getdata(argument: {"id": widget.id});
    widget.throwFunc.detailInit(_getdata);
  }

  int userId;

  _getdata({dynamic argument}) {
    userId = argument['id'];
    setState(() {});
  }

  int select = 1;

  Widget _getWidget() {
    switch (select) {
      case 1:
        return TrainingExamEvaluation(userId: userId);
        break;
      case 2:
        return EduEnterpriseMessage(userId: userId);
        break;
      case 3:
        return TrainingHoursDetails(userId: userId);
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Color(0xffF6F6F6),
            padding: EdgeInsets.symmetric(vertical: size.width * 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    select = 1;
                    setState(() {});
                  },
                  child: Text(
                    '培训学时明细',
                    style: TextStyle(
                        color:
                            select == 1 ? Color(0xff2758F4) : Color(0xff6B7072),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    select = 2;
                    setState(() {});
                  },
                  child: Text(
                    '个人信息',
                    style: TextStyle(
                        color:
                            select == 2 ? Color(0xff2758F4) : Color(0xff6B7072),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    select = 3;
                    setState(() {});
                  },
                  child: Text(
                    '培训考试测评情况',
                    style: TextStyle(
                        color:
                            select == 3 ? Color(0xff2758F4) : Color(0xff6B7072),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          userId != null ? _getWidget() : Container(),
        ],
      ),
    );
  }
}

class EduEnterpriseMessage extends StatefulWidget {
  EduEnterpriseMessage({this.userId});
  final int userId;
  @override
  _EduEnterpriseMessageState createState() => _EduEnterpriseMessageState();
}

class _EduEnterpriseMessageState extends State<EduEnterpriseMessage> {
  int userId = -1;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _getData();
  }

  @override
  void didUpdateWidget(EduEnterpriseMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    userId = widget.userId;
    _getData();
  }

  _getData() {
    myDio.request(
        type: "get",
        url: Interface.getPersonalTrainingFile,
        queryParameters: {'userId': userId}).then((value) {
      if (value is Map) {
        message = value;
        certificate = message['certificate'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Map message = {};

  List certificate = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bj@2x.png'), fit: BoxFit.cover),
      ),
      alignment: Alignment.topCenter,
      child: message.isNotEmpty
          ? ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.width * 30,
                      bottom: size.width * 100,
                      right: size.width * 30,
                      left: size.width * 30),
                  padding: EdgeInsets.symmetric(
                    vertical: size.width * 30,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 30))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.width * 212,
                            width: size.width * 170,
                            margin: EdgeInsets.only(left: size.width * 20),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 20)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: message['headUrl'] != '' && message['headUrl'] != null
                                    ? NetworkImage(message['headUrl'])
                                    : AssetImage(
                                        'assets/images/image_recent_control.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 45,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/eduxm@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '姓名:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['nickname'] != ''
                                            ? message['nickname']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff4A4A4A),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.width * 30,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/edusfz@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '身份证号:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['identityNum'] != ''
                                            ? message['identityNum']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff4A4A4A),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.width * 30,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/edurenyusn@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '人员类别:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['type'] != '' &&
                                                message['type'] != null
                                            ? message['type']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff4A4A4A),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffBED2FF),
                        margin: EdgeInsets.symmetric(vertical: size.width * 30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 250,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/eduxl@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '学历:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['education'] != ''
                                            ? message['education']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 250,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/eduzy@2x.png',
                                    height: size.width * 60,
                                    width: size.width * 60,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '专业:',
                                        style: TextStyle(
                                            color: Color(0xffB3B3B3),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        message['specialty'] != ''
                                            ? message['specialty']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/lx@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '联系方式:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 420,
                                    child: Text(
                                        message['telephone'] != ''
                                            ? message['telephone']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/edugw@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '职务岗位:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 420,
                                    child: Text(
                                        message['position'] != ''
                                            ? message['position']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffBED2FF),
                        margin: EdgeInsets.symmetric(vertical: size.width * 30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/edudw@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '工作单位:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 420,
                                    child: Text(
                                        message['enterName'] != ''
                                            ? message['enterName']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/edushxy@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '社会信用代码:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 420,
                                    child: Text(
                                        message['organizationCode'] != ''
                                            ? message['organizationCode']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffBED2FF),
                        margin: EdgeInsets.symmetric(vertical: size.width * 30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/eduhy@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '行业类别:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                Container(
                                    width: size.width * 420,
                                    child: Text(
                                        message['industryName'] != ''
                                            ? message['industryName']
                                            : '暂未填写',
                                        style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff838385),
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/zs@2x.png',
                              height: size.width * 60,
                              width: size.width * 60,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '已持证书:',
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 5,
                                ),
                                certificate.isNotEmpty
                                    ? Column(
                                        children: certificate
                                            .asMap()
                                            .keys
                                            .map((index) => InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        '/legitimate/__licenseDetails',
                                                        arguments: {
                                                          "id":
                                                              certificate[index]
                                                                  ['id'],
                                                          'type': '个人档案',
                                                        });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                size.width *
                                                                    20),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: size.width *
                                                                420,
                                                            child: Text(
                                                                certificate[index]['name'] !=
                                                                        ''
                                                                    ? certificate[
                                                                            index]
                                                                        ['name']
                                                                    : '暂未填写',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    color: Color(
                                                                        0xff838385),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)),
                                                        Text(
                                                          '查看',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff5D8FFF),
                                                              fontSize:
                                                                  size.width *
                                                                      24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                    : Container()
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    ));
  }
}

class MyTraninFileDropDown extends StatefulWidget {
  const MyTraninFileDropDown(this.list, this.index, {Key key, this.callbacks})
      : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _MyTraninFileDropDownState createState() => _MyTraninFileDropDownState();
}

class _MyTraninFileDropDownState extends State<MyTraninFileDropDown> {
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
                                        _ele['name'] == '查看全部'
                                    ? themeColor
                                    : widget.list[i]['value'] == _ele['name']
                                        ? themeColor
                                        : Colors.white;
                                return _color;
                              }

                              Color _conColors = _juegeColor();
                              return GestureDetector(
                                onTap: () {
                                  widget.list[i]['value'] = _ele['name'];
                                  if (_ele['name'] == '查看全部') {
                                    widget.list[i]['title'] =
                                        widget.list[i]['saveTitle'];
                                  } else {
                                    widget.list[i]['title'] = _ele['name'];
                                  }
                                  widget.callbacks({
                                    'status': _ele['name'],
                                    'id': _ele['id'],
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
                                      _ele['name'],
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
          height: size.width * 70,
                      margin: EdgeInsets.all(size.width * 30.0),
                      padding: EdgeInsets.only(
                          left: size.width * 20.0, right: size.width * 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: size.width * 2,
                          color: Color(0xff999999),
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
