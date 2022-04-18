import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduMyPlanList extends StatefulWidget {
  EduMyPlanList({this.planId});
  final int planId;
  @override
  _EduMyPlanListState createState() => _EduMyPlanListState();
}

class _EduMyPlanListState extends State<EduMyPlanList> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text("学习计划台账列表"),
      child: MyRefres(
        child: (index, list) => EduMyPlanitem(data: list[index], planId: widget.planId), 
        url: Interface.getMyExaminationBookListByPlanId, 
        queryParameters: {'planId': widget.planId},
        method: 'get'
      )
    );
  }
}

class EduMyPlanitem extends StatelessWidget {
  EduMyPlanitem({this.data, this.planId});
  final Map data;
  final int planId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "第${data['stage']}阶段考试台账",
                style: TextStyle(
                    fontSize: size.width * 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: size.width * 28),
                    children: <InlineSpan>[
                      TextSpan(text: '合格分数线：', style: TextStyle(color: Color(0xff0D0D0D))),
                      TextSpan(text: data['passLine'].toString(), style: TextStyle(color: Color(0xff29C076))),
                      TextSpan(text: '   | 得分：  ', style: TextStyle(color: Color(0xff0D0D0D))),
                      data['score'] != null && data['score'] != -1000
                                                          ? TextSpan(
                                                              text: data['score'].toString(),
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
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              if(data['score'] != null && data['score'] != -1000){
                Navigator.pushNamed(
                  context, "/home/education/eduCheckExamLedgerDetails", 
                  arguments: {
                    'planId': planId,
                    'userId': data['userId'],
                    'stage': data['stage'],
                    'year': ''
                  }
                );
              }else{
                Fluttertoast.showToast(msg: '暂无考试台账');
              }
            },
            child: Container(
              width: size.width * 106,
              height: size.width * 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                border: Border.all(width: size.width * 1, color: Color(0xff666666)),
              ),
              alignment: Alignment.center,
              child: Text(
                '查看',
                style: TextStyle(
                  color: Color(0xff666666),
                  fontSize: size.width * 30
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
