import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class YearPlanDetails extends StatefulWidget {
  YearPlanDetails({this.id});
  final int id;
  @override
  _YearPlanDetailsState createState() => _YearPlanDetailsState();
}

class _YearPlanDetailsState extends State<YearPlanDetails> with TickerProviderStateMixin {
  bool show = false;
  TabController _tabTrainController;

  @override
  void initState() {
    super.initState();
    _getYearDetails();
  }

  List stage = [];

  _getYearDetails(){
    myDio.request(
      type: "get",
      url: Interface.getPlanDetailed + widget.id.toString(),
    ).then((value) {
      if (value is Map) {
        data = value;
        stage = data['stage'];
        _tabTrainController = TabController(vsync: this, length: stage.length);
        _tabTrainController.addListener(() {
          setState(() {});
        });
        setState(() {
          show = true;
        });
      }
    });
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('年度线上计划详情'),
      child: Container(
        color: Colors.white,
        child: Transtion(
          data.isNotEmpty ? ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 25),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee),
                  borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, 
                      blurRadius: 1.0, 
                      spreadRadius: 1.0
                    ),
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(size.width * 10)),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 25, vertical: size.width * 20),
                      child: Text(
                        '基本信息',
                        style: TextStyle(
                          color: Color(0xff404040),
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 2,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 25, vertical: size.width * 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '学习计划名称：',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: data['name'].toString()),
                                ]),
                          ),
                          SizedBox(
                            height: size.width * 15,
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '培训内容：',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: data['context'].toString()),
                                ]),
                          ),
                          SizedBox(
                            height: size.width * 15,
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '培训目的：',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: data['aim'].toString()),
                                ]),
                          ),
                          SizedBox(
                            height: size.width * 15,
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '发起时间：',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: DateTime.fromMillisecondsSinceEpoch(data['createDate']).toString().substring(0, 19).toString()
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: size.width * 15,
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '发起部门：',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: data['sponsorDepartment'].toString()
                                    ),
                                ]),
                          ),
                          SizedBox(
                            height: size.width * 15,
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '发起人：',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: data['sponsorName'].toString()
                                    ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 25, vertical: size.width * 20),
                      child: Text(
                        '阶段详情',
                        style: TextStyle(
                            color: Color(0xff404040),
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(size.width * 10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _tabTrainController,
                            isScrollable: true,
                            tabs: stage
                                .asMap()
                                .keys
                                .map((index) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: size.width * 10),
                                    child: Text('第${(index + 1)}阶段',
                                        style: TextStyle(
                                            color: index == _tabTrainController.index
                                                ? Color(0xff306CFD)
                                                : placeHolder,
                                            fontSize: size.width * 28,
                                            fontWeight: FontWeight.bold))))
                                .toList()),
                          Container(
                            height: size.width * 800,
                            child: TabBarView(
                                controller: _tabTrainController,
                                children: stage
                                        .asMap()
                                        .keys
                                        .map((index) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: size.width * 20,
                                                ),
                                                Text(
                                                  '培训',
                                                  style: TextStyle(
                                                    color: Color(0xff404040),
                                                    fontSize: size.width * 24,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                // 已完成培训的人员列表
                                                GestureDetector(
                                                  onTap: () {
                                                    if (stage[index]['completedPeople'].isNotEmpty) {
                                                      Navigator.pushNamed(
                                                        context, "/home/education/offLineYearPersonList",
                                                        arguments: {
                                                          "type": 1,
                                                          "data": stage[index]['completedPeople']
                                                        });
                                                    } else {
                                                      Fluttertoast.showToast(msg: '暂无已完成培训人员');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.width * 26,
                                                        vertical: size.width * 20),
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: size.width * 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              size.width * 10)),
                                                      border: Border.all(
                                                          color: Color(0xffE6E6E6),
                                                          width: size.width * 2), //边框
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/icon_edu_detail_readly_end.png',
                                                          height: size.width * 40,
                                                          width: size.width * 40,
                                                        ),
                                                        SizedBox(
                                                          width: size.width * 24,
                                                        ),
                                                        Text(
                                                          '已完成培训的人员列表',
                                                          style: TextStyle(
                                                              color: Color(0xff404040),
                                                              fontSize: size.width * 24,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Spacer(),
                                                        Text('>')
                                                      ],
                                                    )),
                                                ),
                                                // 未完成培训的人员列表
                                                GestureDetector(
                                                  onTap: () {
                                                    if (stage[index]['unPeople'].isNotEmpty) {
                                                      Navigator.pushNamed(
                                                        context, "/home/education/offLineYearPersonList",
                                                        arguments: {
                                                          "type": 2,
                                                          "data": stage[index]['unPeople']
                                                        });
                                                    } else {
                                                      Fluttertoast.showToast(msg: '暂无未完成培训人员');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.width * 26,
                                                        vertical: size.width * 20),
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: size.width * 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              size.width * 10)),
                                                      border: Border.all(
                                                          color: Color(0xffE6E6E6),
                                                          width: size.width * 2), //边框
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/icon_edu_detail_no_readly.png',
                                                          height: size.width * 40,
                                                          width: size.width * 40,
                                                        ),
                                                        SizedBox(
                                                          width: size.width * 24,
                                                        ),
                                                        Text(
                                                          '未完成培训的人员列表',
                                                          style: TextStyle(
                                                              color: Color(0xff404040),
                                                              fontSize: size.width * 24,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Spacer(),
                                                        Text('>')
                                                      ],
                                                    )),
                                                ),
                                                // 相关教材
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        "/home/education/myDemandStyduPlan",
                                                        arguments: {
                                                          "title": "相关教材",
                                                          'data': stage[index]['resourcesList'],
                                                        });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.width * 26,
                                                        vertical: size.width * 20),
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: size.width * 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              size.width * 10)),
                                                      border: Border.all(
                                                          color: Color(0xffE6E6E6),
                                                          width: size.width * 2), //边框
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/iconedu__text_book_type_two.png',
                                                          height: size.width * 34,
                                                          width: size.width * 40,
                                                        ),
                                                        SizedBox(
                                                          width: size.width * 24,
                                                        ),
                                                        Text(
                                                          '相关教材',
                                                          style: TextStyle(
                                                              color: Color(0xff404040),
                                                              fontSize: size.width * 24,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Spacer(),
                                                        Text('>')
                                                      ],
                                                    )),
                                                ),
                                                Container(
                                                  height: size.width * 1,
                                                  color: Color(0xffeeeeee),
                                                  width: double.infinity,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: size.width * 10),
                                                ),
                                                
                                                Row(
                                                  children: [
                                                    Text(
                                                      '考核',
                                                      style: TextStyle(
                                                        color: Color(0xff404040),
                                                        fontSize: size.width * 24,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              fontSize: size.width * 24),
                                                          children: <InlineSpan>[
                                                            TextSpan(
                                                                text: '最高分：',
                                                                style: TextStyle(
                                                                    color: Color(0xff404040),
                                                                    fontWeight:
                                                                        FontWeight.bold)),
                                                            TextSpan(
                                                                text: stage[index]['max'].toString() + '分',
                                                                style: TextStyle(
                                                                    color:
                                                                        Color(0xff3074FF))),
                                                          ]),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 30,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              fontSize: size.width * 24),
                                                          children: <InlineSpan>[
                                                            TextSpan(
                                                                text: '平均分：',
                                                                style: TextStyle(
                                                                    color: Color(0xff404040),
                                                                    fontWeight:
                                                                        FontWeight.bold)),
                                                            TextSpan(
                                                                text: stage[index]['avg'].toString() + '分',
                                                                style: TextStyle(
                                                                    color:
                                                                        Color(0xff3074FF))),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                                // 通过考核人员列表
                                                GestureDetector(
                                                  onTap: () {
                                                    if (stage[index]['completeList'].isNotEmpty) {
                                                      Navigator.pushNamed(
                                                        context, "/home/education/examinePersonList",
                                                        arguments: {
                                                          "type": 1,
                                                          "data": stage[index]['completeList'],
                                                          "planId": data['id'],
                                                          "stage": index + 1,
                                                          "year": 'year'
                                                        });
                                                    } else {
                                                      Fluttertoast.showToast(msg: '暂无通过考核人员');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.width * 26,
                                                        vertical: size.width * 20),
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: size.width * 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              size.width * 10)),
                                                      border: Border.all(
                                                          color: Color(0xffE6E6E6),
                                                          width: size.width * 2), //边框
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/icon_edu_detail_readly_end.png',
                                                          height: size.width * 40,
                                                          width: size.width * 40,
                                                        ),
                                                        SizedBox(
                                                          width: size.width * 24,
                                                        ),
                                                        Text(
                                                          '通过考核人员列表',
                                                          style: TextStyle(
                                                              color: Color(0xff404040),
                                                              fontSize: size.width * 24,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Spacer(),
                                                        Text('>')
                                                      ],
                                                    )),
                                                ),
                                                SizedBox(
                                                  height: size.width * 20,
                                                ),
                                                // 未通过考核人员列表
                                                GestureDetector(
                                                  onTap: () {
                                                    if (stage[index]['unList'].isNotEmpty) {
                                                      Navigator.pushNamed(
                                                        context, "/home/education/examinePersonList",
                                                        arguments: {
                                                          "type": 2,
                                                          "data": stage[index]['unList'],
                                                          "planId": data['id'],
                                                          "stage": index + 1,
                                                          "year": 'year'
                                                        });
                                                    } else {
                                                      Fluttertoast.showToast(msg: '暂无未通过考核人员');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: size.width * 26,
                                                        vertical: size.width * 20),
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: size.width * 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              size.width * 10)),
                                                      border: Border.all(
                                                          color: Color(0xffE6E6E6),
                                                          width: size.width * 2), //边框
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/icon_edu_detail_no_readly.png',
                                                          height: size.width * 40,
                                                          width: size.width * 40,
                                                        ),
                                                        SizedBox(
                                                          width: size.width * 24,
                                                        ),
                                                        Text(
                                                          '未通过考核人员列表',
                                                          style: TextStyle(
                                                              color: Color(0xff404040),
                                                              fontSize: size.width * 24,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Spacer(),
                                                        Text('>')
                                                      ],
                                                    )),
                                                ),
                                              ],
                                            ))
                                        .toList()),
                          )
                        ],
                      ),
                    ),
                  ]
                )
              ),
            ],
          ) : Container(),
        show
      ),
      ),
    );
  }
}