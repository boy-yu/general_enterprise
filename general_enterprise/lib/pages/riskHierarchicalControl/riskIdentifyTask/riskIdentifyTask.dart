import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskIdentifyTask extends StatefulWidget {
  @override
  State<RiskIdentifyTask> createState() => _RiskIdentifyTaskState();
}

class _RiskIdentifyTaskState extends State<RiskIdentifyTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
          color: Color(0xffF8FAFF),
          child: MyRefres(
              child: (index, list) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/riskIdentifyTask/riskIdentifyTaskIncident',
                          arguments: {'index': index, 'data': list});
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: size.width * 32,
                          right: size.width * 32,
                          top: size.width * 32),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 16),
                              bottomLeft: Radius.circular(size.width * 16),
                              bottomRight: Radius.circular(size.width * 16)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff7F8A9C).withOpacity(0.05),
                                spreadRadius: size.width * 2,
                                blurRadius: size.width * 8)
                          ]),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xffFFCA0E).withOpacity(0.12),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(size.width * 16)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 32,
                                vertical: size.width * 16),
                            child: Text(
                              list[index]['riskUnitName'].toString(),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(size.width * 16), bottomRight: Radius.circular(size.width * 16)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 32,
                                vertical: size.width * 16),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 280,
                                  child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '责任人：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['hazardLiablePerson'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                                ),
                                RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '责任部门：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['hazardDep'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                              ],
                            )
                          ),
                          SizedBox(
                            height: size.width * 16,
                          )
                        ],
                      ),
                    ),
                  ),
              // page: true,
              url: Interface.getRiskTemplateTwoListAllTask,
              // listParam: "records",
              method: 'get'
              // data: data,
              ),
        );
  }
}
