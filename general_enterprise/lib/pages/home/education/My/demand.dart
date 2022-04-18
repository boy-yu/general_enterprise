import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduDemandList extends StatefulWidget {
  EduDemandList({this.id});
  final int id;
  @override
  _EduDemandListState createState() => _EduDemandListState();
}

class _EduDemandListState extends State<EduDemandList> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Map data = {
    "votingList": [],
    "sponsorName": "",
    "pickingList": [],
    "departmentList": [],
    "educationTrainingResources": [],
    "isParticipateAll": -1,
    "name": "",
    "theme": "",
    "validTime": 0,
    "id": -1,
    "endTime": 0,
    "principalList": [],
    "createDate": 0,
    "isPrincipal": null
  };

  List votingList = [];
  List pickingList = [];

  _init() {
    myDio.request(
        type: "get",
        url: Interface.getViewPlanDetails,
        queryParameters: {'id': widget.id, 'type': 1}).then((value) {
      if (value is Map) {
        data = value;
        votingList = data['votingList'];
        pickingList = data['pickingList'];
      }
      setState(() {
        show = true;
      });
    });
  }

  _click(bool type, List list) {
    WorkDialog.myDialog(context, () {}, 2,
        widget: Container(
            height: size.width * 600,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: list
                      .asMap()
                      .keys
                      .map((index) => Container(
                          width: size.width * 250,
                          height: size.width * 50,
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 20),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 20,
                              vertical: size.width * 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: placeHolder)),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Image.asset(
                                type
                                    ? 'assets/images/8691619248054_.pic_hd@2x.png'
                                    : 'assets/images/8681619248047_.pic_hd@2x.png',
                                height: size.width * 27,
                                width: size.width * 24,
                              ),
                              SizedBox(
                                width: size.width * 5,
                              ),
                              Expanded(
                                  child: Text(list[index]['name'],
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xff333333)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          )))
                      .toList()),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("需求调研"),
        child: Transtion(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("调研部门：",
                              style: TextStyle(fontSize: size.width * 25)),
                          SizedBox(width: size.width * 30),
                          GestureDetector(
                            onTap: () {
                              if (data['isParticipateAll'] != 1) {
                                _click(true, data['departmentList']);
                              }
                            },
                            child: Container(
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  color: Color(0xff3869FC),
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Text(
                                data['isParticipateAll'] == 1
                                    ? '全厂'
                                    : "共${data['departmentList'].length}个部门",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text("问卷执行人：",
                              style: TextStyle(fontSize: size.width * 25)),
                          SizedBox(width: size.width * 5),
                          GestureDetector(
                            onTap: () {
                              _click(false, data['principalList']);
                            },
                            child: Container(
                              width: size.width * 100,
                              decoration: BoxDecoration(
                                  color: Color(0xff3869FC),
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Text(
                                "${data['principalList'].length}人",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 20),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("员工自选教材兴趣读排名前三",
                            style: TextStyle(
                                fontSize: size.width * 26,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.bold)),
                        Column(
                            children: votingList
                                .asMap()
                                .keys
                                .map(
                                  (index) => DemandTextBook(
                                      data: votingList[index],
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0)),
                                )
                                .toList()),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/home/education/myDemandStyduPlan",
                                arguments: {
                                  "title": "问卷执行人选择教材",
                                  'data': pickingList,
                                });
                          },
                          child: Text("问卷执行人选择教材  >",
                              style: TextStyle(
                                  fontSize: size.width * 26,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.bold)),
                        ),
                        pickingList.isNotEmpty
                            ? DemandTextBook(
                                data: pickingList[0],
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0))
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            show));
  }
}

class EduDemandDetail extends StatefulWidget {
  @override
  _EduDemandDetailState createState() => _EduDemandDetailState();
}

class _EduDemandDetailState extends State<EduDemandDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DemandTextBook extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Map data;
  DemandTextBook({this.padding, this.margin, this.data});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed('/home/education/study', arguments: {});
        },
        child: Contexts().shadowWidget(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: size.width * 210,
                    height: size.width * 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        data['coverUrl'],
                        fit: BoxFit.fill,
                      ),
                    )),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: TextStyle(
                            fontSize: size.width * 26,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.width * 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: size.width * 300,
                            child: Text(data['introduction'].toString(),
                                style: TextStyle(
                                  fontSize: size.width * 22,
                                  color: Color(0xff999999),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: size.width * 10,
                          ),
                          InkWell(
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
                                                Radius.circular(
                                                    size.width * 10))),
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                                data['title'],
                                                style: TextStyle(
                                                    fontSize: size.width * 36,
                                                    color: Color(0xff0059FF),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: size.width * 30,
                                              ),
                                              Text(
                                                data['introduction'].toString(),
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
                                  fontSize: size.width * 20,
                                  color: Color(0xff1D3DEB)),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: size.width * 15,
                      // ),
                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       'assets/images/icon_edu_star.png',
                      //       width: size.width * 30,
                      //       height: size.width * 30,
                      //     ),
                      //     SizedBox(
                      //       width: size.width * 10,
                      //     ),
                      //     Text(
                      //       data['scores'].toString() + '分',
                      //       style: TextStyle(
                      //         color: Color(0xff999999),
                      //         fontSize: size.width * 22,
                      //       ),
                      //     )
                      //   ],
                      // )
                      data['classHours'] != null ? Text("本教材包含${data['classHours']}个课时",
                          style: TextStyle(
                              fontSize: size.width * 22,
                              color: Color(0xff16CAA2))) : Container()
                    ],
                  ),
                )
              ],
            ),
            padding: padding,
            margin: margin));
  }
}
