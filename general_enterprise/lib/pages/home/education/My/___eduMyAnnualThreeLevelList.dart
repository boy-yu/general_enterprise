import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMyAnnualThreeLevelList extends StatefulWidget {
  EduMyAnnualThreeLevelList({this.id});
  final int id;
  @override
  _EduMyAnnualThreeLevelListState createState() =>
      _EduMyAnnualThreeLevelListState();
}

class _EduMyAnnualThreeLevelListState extends State<EduMyAnnualThreeLevelList> {
  PageController _controller;

  List workData = [
    {
      "index": 0,
      "title": "在线计划",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false
    },
    {
      "index": 1,
      "title": "现场计划",
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
    if (item['title'] == '在线计划')
      _widget = YearStudyPlan(id: widget.id);
    // else if (item['title'] == '现场计划') _widget = MyOfflinePlan(id: widget.id);
    else if (item['title'] == '现场计划') _widget = YearOfflinePlan(id: widget.id);
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
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: size.width * 20),
            child: _changeTitle(size.width, workData[index]),
          ),
        itemCount: workData.length,
      ),
    );
  }
}

class YearStudyPlan extends StatefulWidget {
  YearStudyPlan({this.id});
  final int id;
  @override
  _YearStudyPlanState createState() => _YearStudyPlanState();
}

class _YearStudyPlanState extends State<YearStudyPlan> {
  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => EduYearPlan(data: list[index]),
        url: Interface.getPlanYearSubDetailsList + widget.id.toString(),
        method: 'get');
  }
}

class YearOfflinePlan extends StatefulWidget {
  YearOfflinePlan({this.id});
  final int id;
  @override
  _YearOfflinePlanState createState() => _YearOfflinePlanState();
}

class _YearOfflinePlanState extends State<YearOfflinePlan> {
  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => EduOffLineYearPlan(data: list[index]),
        listParam: "records",
                    page: true,
        url: Interface.getOfflineYearList + widget.id.toString(),
        method: 'get');
  }
}

class EduYearPlan extends StatelessWidget {
  EduYearPlan({this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/home/education/yearPlanDetails",
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
                      'assets/images/ndxxjh@2xlist.png',
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
                            color: Color(0xffffecf2),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '起',
                            style: TextStyle(
                                color: Color(0xfff66c99),
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
                            color: Color(0xffffecf2),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '止',
                            style: TextStyle(
                                color: Color(0xfff66c99),
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
        );
  }
}

class EduOffLineYearPlan extends StatelessWidget {
  EduOffLineYearPlan({this.data});
  final Map data;

  _getState(int startDate, int endDate){
    if(DateTime.now().millisecondsSinceEpoch < startDate){
      return '未开始';
    }else if(startDate <= DateTime.now().millisecondsSinceEpoch && DateTime.now().millisecondsSinceEpoch < endDate){
      return '进行中';
    }else{
      return '台账';
    }
  }

  _getStateColor(int startDate, int endDate){
    if(DateTime.now().millisecondsSinceEpoch < startDate){
      return Color(0xff999999);
    }else if(startDate <= DateTime.now().millisecondsSinceEpoch && DateTime.now().millisecondsSinceEpoch < endDate){
      return Color(0xffFF6600);
    }else{
      return Color(0xff236DFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/home/education/offLineYearPlanDetails",
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
                      'assets/images/ndxxjh@2xlist.png',
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
                            data['title'].toString(),
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
                      _getState(data['startDate'], data['endDate']),
                      style: TextStyle(
                          color: _getStateColor(data['startDate'], data['endDate']),
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
                            color: Color(0xffffecf2),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '起',
                            style: TextStyle(
                                color: Color(0xfff66c99),
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
                            color: Color(0xffffecf2),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '止',
                            style: TextStyle(
                                color: Color(0xfff66c99),
                                fontSize: size.width * 18),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 10,
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  data['endDate'])
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
        );
  }
}
