import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMyAnnualPlan extends StatefulWidget {
  @override
  _EduMyAnnualPlanState createState() => _EduMyAnnualPlanState();
}

class _EduMyAnnualPlanState extends State<EduMyAnnualPlan> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('我参与的年度学习计划'),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: size.width * 20),
          child: MyRefres(
            child: (index, list) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, "/home/education/eduMyAnnualYearPlan",
                      arguments: {
                        'year': list[index]['plannedYear'],
                      });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 10),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 10)),
                      boxShadow: [
                            BoxShadow(
                                color: Color(0xff0059FF).withOpacity(0.1),
                                blurRadius: 1.0,
                                spreadRadius: 1.0)
                          ]
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/ndxxjh@2xlist.png',
                        height: size.width * 70,
                        width: size.width * 70,
                      ),
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Text(
                        list[index]['plannedYear'].toString() + '年度学习计划',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 30),
                      ),
                      Spacer(),
                      Text(
                        '查看',
                        style: TextStyle(
                            color: Color(0xff236DFF),
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 22),
                      )
                    ],
                  ),
                )),
            listParam: "records",
            page: true,
            // throwFunc: _throwFunc,
            url: Interface.getPlanYearList,
            // queryParameters: queryParameters,
            method: 'get'),
        ),
    );
  }
}
