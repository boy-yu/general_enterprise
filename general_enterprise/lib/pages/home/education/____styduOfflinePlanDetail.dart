import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StyduOfflinePlanDetail extends StatefulWidget {
  StyduOfflinePlanDetail({this.planId, this.title});
  final int planId;
  final String title;
  @override
  _StyduOfflinePlanDetailState createState() => _StyduOfflinePlanDetailState();
}

class _StyduOfflinePlanDetailState extends State<StyduOfflinePlanDetail>
    with TickerProviderStateMixin {
  // 当前时间
  int currentTimeMillis;
  bool show = false;

  @override
  void initState() {
    super.initState();
    currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    _getData();
  }

  TabController _tabController;

  _getData() {
    myDio
        .request(
      type: "get",
      url: Interface.getEducationTrainingOfflinePlanDetails +
          widget.planId.toString(),
    )
        .then((value) {
      if (value is Map) {
        data = value;
        list = value['stage'];
        _tabController = TabController(vsync: this, length: list.length);
        _tabController.addListener(() {
          setState(() {});
        });
        setState(() {
          show = true;
        });
      }
    });
  }

  Map data = {};
  List list = [];

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
                      .map((index) => InkWell(
                            child: Container(
                                width: size.width * 250,
                                height: size.width * 50,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 20,
                                    vertical: size.width * 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: placeHolder)),
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
                                        child: Text(
                                            type
                                                ? list[index]['name']
                                                : list[index]['nickname'],
                                            style: TextStyle(
                                                fontSize: size.width * 24,
                                                color: Color(0xff333333)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis))
                                  ],
                                )),
                          ))
                      .toList()),
            )));
  }

  _getTypeImage(int startDate, int endTime) {
    if (currentTimeMillis < startDate) {
      return 'assets/images/type_plan_detail_no_start.png';
    } else if (currentTimeMillis < endTime) {
      return 'assets/images/type_plan_detail_ing.png';
    } else {
      return 'assets/images/type_plan_detail_end.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('线下计划详情'),
      child: Transtion(
          data.isNotEmpty
              ? Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.width * 30,
                            horizontal: size.width * 24),
                        decoration: BoxDecoration(
                            color: Color(0xffeeeeee),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: size.width * 75,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(size.width * 10)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.title,
                                              style: TextStyle(
                                                  color: Color(0xff404040),
                                                  fontSize: size.width * 28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Image.asset(
                                            _getTypeImage(
                                                data['startDate'],
                                                list[list.length - 1]
                                                    ['endTime']),
                                            width: size.width * 75,
                                            height: size.width * 75,
                                          )
                                        )
                                    ],
                                  )),
                              SizedBox(
                                height: size.width * 2,
                              ),
                              Container(
                                color: Colors.white,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 25,
                                    vertical: size.width * 20),
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
                                                text: '培训主题：',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    data['content'].toString()),
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
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: data['sponsorDepartment']
                                                    .toString()),
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
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: data['sponsorName']
                                                    .toString()),
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
                                                text: '培训对象：',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: data['sponsorDepartment']
                                                  .toString(),
                                            )
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
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            data['createDate'])
                                                    .toString()
                                                    .substring(0, 19)),
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
                                                text: '学习开始时间：',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            data['startDate'])
                                                    .toString()
                                                    .substring(0, 19)),
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
                                    horizontal: size.width * 25,
                                    vertical: size.width * 20),
                                child: Text(
                                  '培训计划',
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(size.width * 10)),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TabBar(
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          controller: _tabController,
                                          isScrollable: true,
                                          tabs: list
                                              .asMap()
                                              .keys
                                              .map((index) => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.width * 10),
                                                  child: Text(
                                                      '第${(index + 1)}次培训',
                                                      style: TextStyle(
                                                          color: index ==
                                                                  _tabController
                                                                      .index
                                                              ? Color(
                                                                  0xff306CFD)
                                                              : placeHolder,
                                                          fontSize:
                                                              size.width * 28,
                                                          fontWeight: FontWeight
                                                              .bold))))
                                              .toList()),
                                      // trainList 培训计划
                                      Container(
                                        height: size.width * 1000,
                                        child: TabBarView(
                                            controller: _tabController,
                                            children: list
                                                .asMap()
                                                .keys
                                                .map((index) => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: size.width * 20,
                                                        ),
                                                        //已完成培训的部门列表
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (list[index][
                                                                    'completedDepartment']
                                                                .isNotEmpty) {
                                                              _click(
                                                                  true,
                                                                  list[index][
                                                                      'completedDepartment']);
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          '暂无已完成培训部门');
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
                                                                  '已完成培训的部门列表',
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
                                                        // 未完成培训的部门列表
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (list[index][
                                                                    'incompleteDepartment']
                                                                .isNotEmpty) {
                                                              _click(
                                                                  true,
                                                                  list[index][
                                                                      'incompleteDepartment']);
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          '暂无未完成培训部门');
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
                                                                  '未完成培训的部门列表',
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
                                                        // 已完成培训的人员列表
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (list[index][
                                                                    'completedPeople']
                                                                .isNotEmpty) {
                                                              _click(
                                                                  false,
                                                                  list[index][
                                                                      'completedPeople']);
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          '暂无已完成培训人员');
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
                                                            if (list[index][
                                                                    'incompletePeople']
                                                                .isNotEmpty) {
                                                              _click(
                                                                  false,
                                                                  list[index][
                                                                      'incompletePeople']);
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          '暂无未完成培训人员');
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
                                                            Navigator.pushNamed(
                                                                context,
                                                                "/home/education/myDemandStyduPlan",
                                                                arguments: {
                                                                  "title":
                                                                      "相关教材",
                                                                  'data': list[
                                                                          index]
                                                                      [
                                                                      'allResources'],
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
                                                        SizedBox(
                                                          height: size.width * 20,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训负责人：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: list[index]['mainPeople']
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训地点：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: list[index]['address'].toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训学时：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: list[index]['classHours'].toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训计划参训人数：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: list[index]['allPeopleNum'].toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训实际参训人数：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: list[index]['completedPeopleNum'].toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训未参训人数：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: list[index]['incompletePeopleNum'].toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训开始时间：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: DateTime.fromMillisecondsSinceEpoch(list[index]['startTime']).toString().substring(0, 19),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height: size.width * 14,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize: size.width * 24),
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                    text: '培训结束时间：',
                                                                    style: TextStyle(
                                                                        color: Color(0xff404040),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: DateTime.fromMillisecondsSinceEpoch(list[index]['endTime']).toString().substring(0, 19),
                                                                    style: TextStyle(
                                                                        color:
                                                                            Color(0xff3074FF))),
                                                              ]),
                                                        ),
                                                      ],
                                                    ))
                                                .toList()),
                                      )
                                    ]),
                              ),
                            ]),
                      ),
                    ],
                  ),
                )
              : Container(),
          show),
    );
  }
}
