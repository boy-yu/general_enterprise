import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DemandAssessMent extends StatefulWidget {
  DemandAssessMent({this.planId});
  final int planId;
  @override
  _DemandAssessMentState createState() => _DemandAssessMentState();
}

class _DemandAssessMentState extends State<DemandAssessMent> {
  void show(BuildContext context, List list) async {
    String name;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: size.width * 800,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: list
                            .asMap()
                            .keys
                            .map((index) => GestureDetector(
                              onTap: (){
                                name = '';
                                if(list[index]['choose'] == null){
                                  list[index]['choose'] = 1;
                                  name = list[index]['name'];
                                  for (int i = 0; i < list.length; i++) {
                                    if(i != index){
                                      list[i]['choose'] = null;
                                    }
                                  }
                                }else{
                                  name = '';
                                  list[index]['choose'] = null;
                                }
                                state(() {});
                              },
                              child: Container(
                                width: size.width * 550,
                                height: size.width * 50,
                                padding:
                                    EdgeInsets.symmetric(horizontal: size.width * 20),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 20,
                                    vertical: size.width * 10),
                                decoration: BoxDecoration(
                                  color: list[index]['choose'] == null ? Color(0xffF3F4F8) : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1, color: list[index]['choose'] == null ? placeHolder : Color(0xff346AFE))),
                                alignment: Alignment.center,
                                child: Text(
                                    list[index]['name'].toString() + '   人数：' + list[index]['list'].length.toString(),
                                    style: TextStyle(
                                        fontSize: size.width * 24,
                                        color: Color(0xff333333)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)
                              ),
                            )
                      ).toList()),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(name == ''){
                        Fluttertoast.showToast(msg: '请选择要查看的部门');
                      }else{
                        
                        Navigator.pushNamed(
                          context, "/home/education/eduMyAssessmentDetail", arguments: {
                            'name': name,
                            'data': list
                          });
                      }
                    },
                    child: Container(
                      height: size.width * 74,
                      width: size.width * 320,
                      decoration: BoxDecoration(
                        color: Color(0xff346AFE),
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 36.5))
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '确定',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("考核"),
        child: MyRefres(
            child: (index, list) => Contexts().shadowWidget(
                InkWell(
                  onTap: () {
                    myDio.request(
                      type: "get",
                      url: Interface.getExaminationDetailsById,
                      queryParameters: {
                        'id': list[index]['id']
                    }).then((value) {
                      if (value is List) {
                        show(context, value);
                      }
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "考核结束时间：${DateTime.fromMillisecondsSinceEpoch(list[index]['endTime']).toString().substring(0, 10)}",
                        style: TextStyle(
                            fontSize: size.width * 22,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.width * 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                              "assets/images/study/jieduankaohe@2x@2x.png",
                              width: size.width * 60,
                              height: size.width * 60),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "第${list[index]['stage']}阶段考核",
                                style: TextStyle(
                                    fontSize: size.width * 26,
                                    color: Color(0xff343434),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "合格分数线：${list[index]['passLine']}分",
                                style: TextStyle(
                                    color: placeHolder,
                                    fontSize: size.width * 20),
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                "${list[index]['qualifiedNum']}人",
                                style: TextStyle(
                                    fontSize: size.width * 24,
                                    color: Color(0xff343434),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "合格人数",
                                style: TextStyle(
                                    color: placeHolder,
                                    fontSize: size.width * 20),
                              )
                            ],
                          )),
                          Container(
                            width: size.width * 1,
                            height: size.width * 24,
                            color: Color(0xff999999),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                "${list[index]['unqualifiedNum']}人",
                                style: TextStyle(
                                    fontSize: size.width * 24,
                                    color: Color(0xffFF5B5F),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "不合格人数",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: size.width * 20),
                              )
                            ],
                          )),
                          Container(
                            width: size.width * 1,
                            height: size.width * 24,
                            color: Color(0xff999999),
                          ),
                          Column(
                            children: [
                              Text(
                                "${list[index]['averageScore']}分",
                                style: TextStyle(
                                    fontSize: size.width * 24,
                                    color: Color(0xff343434),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "平均分",
                                style: TextStyle(
                                    color: placeHolder,
                                    fontSize: size.width * 20),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      CustomEchart().progressComp(
                          value: list[index]['qualifiedNum'] +
                                      list[index]['unqualifiedNum'] ==
                                  0
                              ? 0.0
                              : list[index]['qualifiedNum'] /
                                  (list[index]['qualifiedNum'] +
                                      list[index]['unqualifiedNum']),
                          width: MediaQuery.of(context).size.width - 20,
                          height: size.width * 8,
                          frColor: Color(0xff0485FF),
                          bgColor: Color(0xffEDF7FF)),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "合格率",
                            style: TextStyle(
                                fontSize: size.width * 18,
                                color: Color(0xff3D4966)),
                          ),
                          Text(
                            "${list[index]['qualifiedNum'] + list[index]['unqualifiedNum'] == 0 ? 0.0 : list[index]['qualifiedNum'] / (list[index]['qualifiedNum'] + list[index]['unqualifiedNum']) * 100}%",
                            style: TextStyle(
                                fontSize: size.width * 18,
                                color: Color(0xff3D4966)),
                          ),
                          Container()
                        ],
                      )
                    ],
                  ),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(10)),
            // data: [1, 2, 3],
            page: true,
            url: Interface.getExaminationDetailsByPlanId,
            queryParameters: {'planId': widget.planId},
            method: "get"));
  }
}
