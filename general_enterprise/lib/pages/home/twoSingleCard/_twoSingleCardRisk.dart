import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class TwoSingleCardRisk extends StatefulWidget {
  @override
  _TwoSingleCardRiskState createState() => _TwoSingleCardRiskState();
}

class _TwoSingleCardRiskState extends State<TwoSingleCardRisk> {
  @override
  void initState() {
    super.initState();
    _getDataTotal();
  }

  int total = 0;

  _getDataTotal(){
    myDio.request(
          type: 'get',
          url: Interface.getTwoCardsRiskList,
    ).then((value)  {
      if(value is Map){
        total = value['total'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: size.width * 20,
              right: size.width * 20,
              top: size.width * 20),
          padding: EdgeInsets.symmetric(
              vertical: size.width * 15, horizontal: size.width * 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0),
              ]),
          child: Row(
            children: [
              Text(
                '岗位风险清单总数：',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                total.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2A60F7)
                ),
              ),
            ],
          )
        ),
        Expanded(
          child: MyRefres(
              child: (index, list) => Container(
                  margin: EdgeInsets.only(
                      left: size.width * 20,
                      right: size.width * 20,
                      top: size.width * 20),
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 15, horizontal: size.width * 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 10)),
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
                        padding: EdgeInsets.all(size.width * 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(
                              width: size.width * 1, color: Color(0xff2A60F7)),
                        ),
                        child: Text(
                          list[index]['name'],
                          style: TextStyle(
                            color: Color(0xff2A60F7),
                            fontSize: size.width * 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 5,
                      ),
                      Text(
                        '风险描述：${list[index]['description']}',
                        style: TextStyle(fontSize: size.width * 24),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black12,
                        height: size.width * 1,
                        margin: EdgeInsets.symmetric(vertical: size.width * 5),
                      ),
                      Text(
                        '管控措施：${list[index]['controlMeasures']}',
                        style: TextStyle(fontSize: size.width * 24),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black12,
                        height: size.width * 1,
                        margin: EdgeInsets.symmetric(vertical: size.width * 5),
                      ),
                      Text(
                        '负责部门：${list[index]['departmentName']}',
                        style: TextStyle(fontSize: size.width * 24),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black12,
                        height: size.width * 1,
                        margin: EdgeInsets.symmetric(vertical: size.width * 5),
                      ),
                      Text(
                        '风险分析对象：${list[index]['riskPoint']}',
                        style: TextStyle(fontSize: size.width * 24),
                      ),
                      SizedBox(
                        height: size.width * 5,
                      ),
                      Text(
                        '风险分析单元：${list[index]['riskUnit']}',
                        style: TextStyle(fontSize: size.width * 24),
                      ),
                      SizedBox(
                        height: size.width * 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '管控周期：${list[index]['cycle']}小时/次',
                            style: TextStyle(
                              fontSize: size.width * 24,
                              color: Color(0xff2A60F7),
                            ),
                          ),
                          Spacer(),
                          Text(
                            '管控方式：${list[index]['controlMeans']}',
                            style: TextStyle(
                              fontSize: size.width * 24,
                              color: Color(0xff2A60F7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              // queryParameters: {"sign": 1},
              page: true,
              listParam: "records",
              url: Interface.getTwoCardsRiskList,
              method: 'get'),
        )
      ],
    );
  }
}
