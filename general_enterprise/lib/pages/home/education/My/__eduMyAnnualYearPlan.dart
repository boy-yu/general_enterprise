import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMyAnnualYearPlan extends StatefulWidget {
  EduMyAnnualYearPlan({this.year});
  final int year;
  @override
  _EduMyAnnualYearPlanState createState() => _EduMyAnnualYearPlanState();
}

class _EduMyAnnualYearPlanState extends State<EduMyAnnualYearPlan> {
  Map queryParameters;

  @override
  void initState() {
    super.initState();
    queryParameters = {'year': widget.year};
  }

  @override
  Widget build(BuildContext context) {
    print(queryParameters);
    return MyAppbar(
        title: Text(
          (widget.year).toString() + '年度学习计划',
        ),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: size.width * 20),
          child: MyRefres(
            child: (index, list) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, "/home/education/eduMyAnnualThreeLevelList",
                        arguments: {
                          'id': list[index]['id'],
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 20, vertical: size.width * 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 20)),
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
                              vertical: size.width * 20,
                              horizontal: size.width * 30),
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
                                width: size.width * 550,
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "培训内容：${list[index]['context']}",
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Text("培训目的：${list[index]['aim']}",
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 26,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
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
                              vertical: size.width * 15,
                              horizontal: size.width * 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "执行月份：${list[index]['executionTime']}月",
                                style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: size.width * 22),
                              ),
                              Text(
                                "学时：${list[index]['classHour']}学时",
                                style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: size.width * 22),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            // listParam: "records",
            // page: true,
            // throwFunc: _throwFunc,
            url: Interface.getPlanYearSublist,
            queryParameters: queryParameters,
            method: 'get'),
        ),
    );
  }
}
