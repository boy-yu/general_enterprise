import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StyduPlanDetail extends StatefulWidget {
  StyduPlanDetail({this.planId, this.source});
  final int planId;
  final int source;
  @override
  _StyduPlanDetailState createState() => _StyduPlanDetailState();
}

class _StyduPlanDetailState extends State<StyduPlanDetail> {
  bool show = false;
  // 当前时间
  int currentTimeMillis;

  // 选中状态
  int isChecked = -1;

  @override
  void initState() {
    super.initState();
    isChecked = widget.source;
    currentTimeMillis = DateTime.now().millisecondsSinceEpoch;

    _getViewPlanDetailsData();
  }

  Map data = {};

  List educationTrainingPlanExaminationList = [];
  List trainList = [];

  _getViewPlanDetailsData() {
    myDio.request(
        type: "get",
        url: Interface.getViewPlanDetails,
        queryParameters: {'id': widget.planId, 'type': widget.source}).then((value) {
      if (value is Map) {
        data = value;
        if (data['trainingAssessment'] != null) {
          educationTrainingPlanExaminationList =
              data['trainingAssessment']['stage'];
        }
        if (data['educationTrainingPlanDetails'] != null) {
          trainList = data['educationTrainingPlanDetails']['stage'];
        }
        setState(() {
          show = true;
        });
      }
    });
  }

  Widget _getWidget() {
    // 1：需求调研 2：教育培训 3：培训考核
    switch (isChecked) {
      case 1:
        return DemandResearch(
            data: data['researchDetails'],
            currentTimeMillis: currentTimeMillis);
        break;
      case 2:
        return EducationalTraining(
            data: data['educationTrainingPlanDetails'],
            list: data['educationTrainingPlanDetails']['stage'],
            currentTimeMillis: currentTimeMillis);
        break;
      case 3:
        return TrainingCheck(
            data: data['trainingAssessment'],
            list: data['trainingAssessment']['stage'],
            currentTimeMillis: currentTimeMillis);
        break;
      default:
        return Container();
    }
  }

  _getPlanImage(){
    if(trainList != null && trainList.isNotEmpty){
      if(currentTimeMillis < trainList[trainList.length - 1]['endTime']){
        return 'assets/images/icon_edu_planing.png';
      }else{
        return 'assets/images/icon_edu_planed.png';
      }
    }else{
      if(currentTimeMillis < data['educationTrainingPlanDetails']['endTime']){
        return 'assets/images/icon_edu_planing.png';
      }else{
        return 'assets/images/icon_edu_planed.png';
      }
    }
  }

  _getDetImage(){
    if(data['trainingAssessment'] == null){
      return 'assets/images/icon_edu_detwill.png';
    }else{
      if(educationTrainingPlanExaminationList != null && educationTrainingPlanExaminationList.isNotEmpty){
        if(currentTimeMillis < educationTrainingPlanExaminationList[educationTrainingPlanExaminationList.length -1]['endTime']){
          return 'assets/images/icon_edu_deting.png';
        }else{
          return 'assets/images/icon_edu_deted.png';
        }
      }else{
        if(currentTimeMillis < data['trainingAssessment']['endTime']){
          return 'assets/images/icon_edu_deting.png';
        }else{
          return 'assets/images/icon_edu_deted.png';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(isChecked == 1 ? '需求调研' : '学习计划(在线)'),
        child: Transtion(
            data.isNotEmpty
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 20, vertical: size.width * 40),
                    child: Column(
                      children: [
                        data['researchDetails'] == null
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          isChecked = 2;
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                          _getPlanImage(),
                                          
                                          width: size.width * 69,
                                          height: size.width * 69,
                                        ),
                                      ),
                                      Container(
                                        height: size.width * 8,
                                        width: size.width * 182,
                                        decoration: BoxDecoration(
                                            color: data['trainingAssessment'] ==
                                                    null
                                                ? Color(0xffEDF0F5)
                                                : Color(0xff3177FE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 4))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (data['trainingAssessment'] ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg: '暂无培训考核记录');
                                          } else {
                                            isChecked = 3;
                                            setState(() {});
                                          }
                                        },
                                        child: Image.asset(
                                          _getDetImage(),
                                          
                                          width: size.width * 69,
                                          height: size.width * 69,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '教育培训',
                                        style: TextStyle(
                                            color: isChecked == 2
                                                ? Color(0xff3177FE)
                                                : Color(0xff666666),
                                            fontSize: size.width * 22,
                                            fontWeight: isChecked == 2
                                                ? FontWeight.bold
                                                : null),
                                      ),
                                      Container(
                                        height: size.width * 8,
                                        width: size.width * 182,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 4))),
                                      ),
                                      Text(
                                        '培训考核',
                                        style: TextStyle(
                                            color: isChecked == 3
                                                ? Color(0xff3177FE)
                                                : Color(0xff666666),
                                            fontSize: size.width * 22,
                                            fontWeight: isChecked == 3
                                                ? FontWeight.bold
                                                : null),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          isChecked = 1;
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                          currentTimeMillis <
                                                  data['researchDetails']
                                                      ['endTime']
                                              ? 'assets/images/icon_edu_needing.png'
                                              : 'assets/images/icon_edu_needed.png',
                                          width: size.width * 69,
                                          height: size.width * 69,
                                        ),
                                      ),
                                      Container(
                                        height: size.width * 8,
                                        width: size.width * 182,
                                        // margin: EdgeInsets.symmetric(horizontal: size.width * 10),
                                        decoration: BoxDecoration(
                                            color:
                                                data['educationTrainingPlanDetails'] ==
                                                        null
                                                    ? Color(0xffEDF0F5)
                                                    : Color(0xff3177FE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 4))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (data[
                                                  'educationTrainingPlanDetails'] ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg: '暂无教育培训记录');
                                          } else {
                                            isChecked = 2;
                                            setState(() {});
                                          }
                                        },
                                        child: Image.asset(
                                          data['educationTrainingPlanDetails'] ==
                                                  null
                                              ? 'assets/images/icon_edu_planwill.png'
                                              : currentTimeMillis <
                                                      trainList[
                                                          trainList.length -
                                                              1]['endTime']
                                                  ? 'assets/images/icon_edu_planing.png'
                                                  : 'assets/images/icon_edu_planed.png',
                                          width: size.width * 69,
                                          height: size.width * 69,
                                        ),
                                      ),
                                      Container(
                                        height: size.width * 8,
                                        width: size.width * 182,
                                        decoration: BoxDecoration(
                                            color: data['trainingAssessment'] ==
                                                    null
                                                ? Color(0xffEDF0F5)
                                                : Color(0xff3177FE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 4))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (data['trainingAssessment'] ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg: '暂无培训考核记录');
                                          } else {
                                            isChecked = 3;
                                            setState(() {});
                                          }
                                        },
                                        child: Image.asset(
                                          data['trainingAssessment'] == null
                                              ? 'assets/images/icon_edu_detwill.png'
                                              : currentTimeMillis <
                                                      educationTrainingPlanExaminationList[
                                                          educationTrainingPlanExaminationList
                                                                  .length -
                                                              1]['endTime']
                                                  ? 'assets/images/icon_edu_deting.png'
                                                  : 'assets/images/icon_edu_deted.png',
                                          width: size.width * 69,
                                          height: size.width * 69,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '需求调研',
                                        style: TextStyle(
                                            color: isChecked == 1
                                                ? Color(0xff3177FE)
                                                : Color(0xff666666),
                                            fontSize: size.width * 22,
                                            fontWeight: isChecked == 1
                                                ? FontWeight.bold
                                                : null),
                                      ),
                                      Text(
                                        '教育培训',
                                        style: TextStyle(
                                            color: isChecked == 2
                                                ? Color(0xff3177FE)
                                                : Color(0xff666666),
                                            fontSize: size.width * 22,
                                            fontWeight: isChecked == 2
                                                ? FontWeight.bold
                                                : null),
                                      ),
                                      Text(
                                        '培训考核',
                                        style: TextStyle(
                                            color: isChecked == 3
                                                ? Color(0xff3177FE)
                                                : Color(0xff666666),
                                            fontSize: size.width * 22,
                                            fontWeight: isChecked == 3
                                                ? FontWeight.bold
                                                : null),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                        SizedBox(
                          height: size.width * 30,
                        ),
                        Expanded(
                          child: _getWidget(),
                        )
                      ],
                    ),
                  )
                : Container(),
            show));
  }
}

class DemandResearch extends StatefulWidget {
  DemandResearch({this.data, this.currentTimeMillis});
  final Map data;
  final int currentTimeMillis;
  @override
  _DemandResearchState createState() => _DemandResearchState();
}

class _DemandResearchState extends State<DemandResearch> {
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
                          )))
                      .toList()),
            )));
  }

  _getTypeImage(int endTime) {
    if (widget.currentTimeMillis < endTime) {
      return 'assets/images/type_plan_detail_ing.png';
    } else {
      return 'assets/images/type_plan_detail_end.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(size.width * 5),
          decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0),
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
                        padding: EdgeInsets.only(top: size.width * 10,left: size.width * 10, right: size.width * 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.data['name'],
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            _getTypeImage(widget.data['endTime']),
                            width: size.width * 75,
                            height: size.width * 75,
                          ))
                    ],
                  )),
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
                                text: '需求调研主题：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: widget.data['theme'].toString()),
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
                                text: widget.data['sponsorDepartment']
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: widget.data['sponsorName'].toString()),
                          ]),
                    ),
                    SizedBox(
                      height: size.width * 15,
                    ),
                    Row(
                      children: [
                        Text("调研部门：",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff404040),
                                fontSize: size.width * 24)),
                        GestureDetector(
                          onTap: () {
                            if (widget.data['isParticipateAll'] != 1) {
                              _click(true, widget.data['departmentList']);
                            }
                          },
                          child: Container(
                            width: size.width * 200,
                            height: size.width * 40,
                            decoration: BoxDecoration(
                                color: Color(0xff3869FC),
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: Text(
                              widget.data['isParticipateAll'] == 1
                                  ? '全厂'
                                  : "共${widget.data['departmentList'].length}个部门",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 20),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 15,
                    ),
                    Row(
                      children: [
                        Text("问卷执行人：",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff404040),
                                fontSize: size.width * 24)),
                        SizedBox(width: size.width * 5),
                        GestureDetector(
                          onTap: () {
                            _click(false, widget.data['principalList']);
                          },
                          child: Container(
                            width: size.width * 100,
                            height: size.width * 40,
                            decoration: BoxDecoration(
                                color: Color(0xff3869FC),
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: Text(
                              "${widget.data['principalList'].length}人",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 20),
                            ),
                          ),
                        )
                      ],
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
                                text: '需求调研发起时间：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: DateTime.fromMillisecondsSinceEpoch(
                                        widget.data['createDate'])
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
                                text: '需求调研截止时间：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: DateTime.fromMillisecondsSinceEpoch(
                                        widget.data['endTime'])
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 25, vertical: size.width * 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(size.width * 10)),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, "/home/education/myDemandStyduPlan",
                            arguments: {
                              "title": "员工自选教材兴趣度",
                              'data': widget.data['educationTrainingResources'],
                            });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 26,
                              vertical: size.width * 20),
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10)),
                            border: Border.all(
                                color: Color(0xffE6E6E6),
                                width: size.width * 2), //边框
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icon_num_detail_btn.png',
                                height: size.width * 40,
                                width: size.width * 40,
                              ),
                              SizedBox(
                                width: size.width * 24,
                              ),
                              Text(
                                '员工自选教材兴趣排名前10',
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text('>')
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.data['pickingList'].isNotEmpty) {
                          Navigator.pushNamed(
                              context, "/home/education/myDemandStyduPlan",
                              arguments: {
                                "title": "问卷负责人选择教材",
                                'data': widget.data['pickingList'],
                              });
                        } else {
                          Fluttertoast.showToast(msg: '暂无相关教材');
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 26,
                              vertical: size.width * 20),
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10)),
                            border: Border.all(
                                color: Color(0xffE6E6E6),
                                width: size.width * 2), //边框
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icon_text_book_detail_btn.png',
                                height: size.width * 40,
                                width: size.width * 40,
                              ),
                              SizedBox(
                                width: size.width * 24,
                              ),
                              Text(
                                '问卷负责人相关教材',
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text('>')
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EducationalTraining extends StatefulWidget {
  EducationalTraining({this.data, this.currentTimeMillis, this.list});
  final Map data;
  final int currentTimeMillis;
  final List list;
  @override
  _EducationalTrainingState createState() => _EducationalTrainingState();
}

class _EducationalTrainingState extends State<EducationalTraining>
    with TickerProviderStateMixin {
  _click(bool type, List list, bool completion, int stage) {
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
                            onTap: () async {
                              // ture: 部门   false:个人
                              if (type) {
                                List<HiddenDangerInterface> _leftbar = [];
                                // id = peoplePageList[index]['departmentId'][_index].id;
                                List data = await PeopleStructure.getListPeople(
                                    list[index]['departmentId']);
                                if (data.isEmpty) {
                                  Fluttertoast.showToast(msg: '该部门下没有人员');
                                  return;
                                }
                                _leftbar =
                                    _leftbar.changeHiddenDangerInterfaceType(
                                  data,
                                  title: 'name',
                                  icon: 'static:photoUrl',
                                  id: 'id',
                                  name: 'name',
                                );
                                _leftbar[0].color = Colors.white;
                                Navigator.pushNamed(
                                    context, '/index/productList/CommonPage',
                                    arguments: {
                                      "leftBar": _leftbar,
                                      "index": 0,
                                      "title": list[index]['name'],
                                      "widgetType": 'DepartmentTrainDetails',
                                      "planId": widget.data['id'],
                                      "stage": stage,
                                    });
                              } else {
                                // completion:  ture: 完成   false:未完成
                                if (completion) {
                                  // 完成 => 试卷详情页面
                                  // print(list[index]['id']);
                                  // print(widget.data['id']);
                                  // print(stage);
                                  Navigator.pushNamed(context,
                                      "/home/education/eduCheckExamLedgerDetails",
                                      arguments: {
                                        'userId': list[index]['id'],
                                        'planId': widget.data['id'],
                                        'stage': stage,
                                      });
                                }
                              }
                            },
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
                                                ? list[index]['departmentName']
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

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.list.length);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  _getTypeImage(int endTime) {
    if (widget.currentTimeMillis < endTime) {
      return 'assets/images/type_plan_detail_ing.png';
    } else {
      return 'assets/images/type_plan_detail_end.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(size.width * 5),
          decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0),
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
                        padding: EdgeInsets.only(top: size.width * 10,left: size.width * 10, right: size.width * 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.data['name'],
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            widget.list != null && widget.list.isNotEmpty ? _getTypeImage(widget.list[widget.list.length - 1]['endTime']) : _getTypeImage(widget.data['endTime']),
                            width: size.width * 75,
                            height: size.width * 75,
                          ))
                    ],
                  )),
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
                                text: '培训主题：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: widget.data['theme'].toString()),
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
                                text: widget.data['sponsorDepartment']
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: widget.data['sponsorName'].toString()),
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 
                                widget.list.isNotEmpty && widget.list != null 
                                ? (widget.list[0]['completedDepartment'].length +widget.list[0]['unDepartment'].length).toString() + '个部门'
                                : "无",
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: DateTime.fromMillisecondsSinceEpoch(
                                        widget.data['createDate'])
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
                    horizontal: size.width * 25, vertical: size.width * 20),
                child: Text(
                  '培训计划阶段',
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
                        controller: _tabController,
                        isScrollable: true,
                        tabs: widget.list
                            .asMap()
                            .keys
                            .map((index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 10),
                                child: Text('第${(index + 1)}次培训',
                                    style: TextStyle(
                                        color: index == _tabController.index
                                            ? Color(0xff306CFD)
                                            : placeHolder,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold))))
                            .toList()),
                    // trainList 培训计划
                    Container(
                      height: size.width * 800,
                      child: TabBarView(
                          controller: _tabController,
                          children: widget.list
                              .asMap()
                              .keys
                              .map((index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.width * 20,
                                      ),
                                      //已完成培训的部门列表
                                      GestureDetector(
                                        onTap: () {
                                          if (widget
                                              .list[index]
                                                  ['completedDepartment']
                                              .isNotEmpty) {
                                            _click(
                                                true,
                                                widget.list[index]
                                                    ['completedDepartment'],
                                                true,
                                                index + 1);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: '暂无已完成培训部门');
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
                                          if (widget.list[index]['unDepartment']
                                              .isNotEmpty) {
                                            _click(
                                                true,
                                                widget.list[index]
                                                    ['unDepartment'],
                                                false,
                                                index + 1);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: '暂无未完成培训部门');
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
                                          if (widget
                                              .list[index]['completedPeople']
                                              .isNotEmpty) {
                                            _click(
                                                false,
                                                widget.list[index]
                                                    ['completedPeople'],
                                                true,
                                                index + 1);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: '暂无已完成培训人员');
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
                                          if (widget.list[index]['unPeople']
                                              .isNotEmpty) {
                                            _click(
                                                false,
                                                widget.list[index]['unPeople'],
                                                false,
                                                index + 1);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: '暂无未完成培训人员');
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
                                                'data': widget.list[index]
                                                    ['resourcesList'],
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
                                                  text: '培训计划参训人数：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: widget.list[index]
                                                          ['totalPeopleNum']
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
                                                  text: '培训实际参训人数：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: widget.list[index]
                                                          ['completedPeopleNum']
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
                                                  text: '培训未参训人数：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: widget.list[index]
                                                          ['unPeopleNum']
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
                                                  text: '学习截止时间：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              widget.list[index]
                                                                      [
                                                                      'endTime'] +
                                                                  86399000)
                                                      .toString()
                                                      .substring(0, 19),
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff3074FF))),
                                            ]),
                                      ),
                                    ],
                                  ))
                              .toList()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TrainingCheck extends StatefulWidget {
  TrainingCheck({this.data, this.currentTimeMillis, this.list});
  final Map data;
  final int currentTimeMillis;
  final List list;
  @override
  _TrainingCheckState createState() => _TrainingCheckState();
}

class _TrainingCheckState extends State<TrainingCheck>
    with TickerProviderStateMixin {
  TabController _tabController;
  List departmentList = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: widget.list.length);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  _getTypeImage(int endTime) {
    if (widget.currentTimeMillis < endTime) {
      return 'assets/images/type_plan_detail_ing.png';
    } else {
      return 'assets/images/type_plan_detail_end.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(size.width * 5),
          decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0),
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
                        padding: EdgeInsets.only(top: size.width * 10,left: size.width * 10, right: size.width * 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.data['name'],
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            widget.list.isNotEmpty && widget.list != null ? _getTypeImage(widget.list[widget.list.length - 1]['endTime']) : _getTypeImage(widget.data['endTime']),
                            width: size.width * 75,
                            height: size.width * 75,
                          ))
                    ],
                  )),
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
                                text: '培训主题：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: widget.data['theme'].toString()),
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
                                text: widget.data['sponsorDepartment']
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: widget.data['sponsorName'].toString()),
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
                                text: DateTime.fromMillisecondsSinceEpoch(
                                        widget.data['createDate'])
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
                    horizontal: size.width * 25, vertical: size.width * 20),
                child: Text(
                  '培训考核阶段',
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
                        controller: _tabController,
                        isScrollable: true,
                        tabs: widget.list
                            .asMap()
                            .keys
                            .map((index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 10),
                                child: Text('第${(index + 1)}次考核',
                                    style: TextStyle(
                                        color: index == _tabController.index
                                            ? Color(0xff306CFD)
                                            : placeHolder,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold))))
                            .toList()),
                    // educationTrainingPlanExaminationList 培训考核
                    Container(
                      height: size.width * 430,
                      child: TabBarView(
                          controller: _tabController,
                          children: widget.list
                              .asMap()
                              .keys
                              .map((index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.width * 20,
                                      ),
                                      //通过考核人员
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              "/home/education/examinePersonList",
                                              arguments: {
                                                "type": 1,
                                                "data": widget.list[index]
                                                    ['completedPeople'],
                                                "planId": widget.data['id'],
                                                "stage": index + 1,
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
                                                  'assets/images/icon_edu_detail_readly_end.png',
                                                  height: size.width * 40,
                                                  width: size.width * 40,
                                                ),
                                                SizedBox(
                                                  width: size.width * 24,
                                                ),
                                                Text(
                                                  '通过考核人员',
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
                                      // 未通过考核人员
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              "/home/education/examinePersonList",
                                              arguments: {
                                                "type": 2,
                                                "data": widget.list[index]
                                                    ['unPeople'],
                                                "planId": widget.data['id'],
                                                "stage": index + 1,
                                                "endTime": widget.list[index]['endTime']
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
                                                  'assets/images/icon_edu_detail_no_readly.png',
                                                  height: size.width * 40,
                                                  width: size.width * 40,
                                                ),
                                                SizedBox(
                                                  width: size.width * 24,
                                                ),
                                                Text(
                                                  '未通过考核人员',
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
                                          Container(
                                            width: size.width * 300,
                                            child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 24),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                        text: '平均分：',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff404040),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: widget.list[index]
                                                                ['avg']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff3074FF))),
                                                  ]),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: size.width * 24),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: '最高分：',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff404040),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text: widget.list[index]
                                                              ['max']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff3074FF))),
                                                ]),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.width * 14,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: size.width * 300,
                                            child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 24),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                        text: '通过人数：',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff404040),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: widget.list[index]
                                                                ['completedNum']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff3074FF))),
                                                  ]),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: size.width * 24),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: '未通过人数：',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff404040),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text: widget.list[index]
                                                              ['unPeopleNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff3074FF))),
                                                ]),
                                          ),
                                        ],
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
                                                  text: '考核结束时间：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              widget.list[index]
                                                                  ['endTime'])
                                                      .toString()
                                                      .substring(0, 19),
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff3074FF))),
                                            ]),
                                      ),
                                    ],
                                  ))
                              .toList()),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
