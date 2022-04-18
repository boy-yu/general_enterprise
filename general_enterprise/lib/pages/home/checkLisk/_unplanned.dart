import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/checkLisk/__inspection.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Unplanned extends StatefulWidget {
  @override
  _UnplannedState createState() => _UnplannedState();
}

class _UnplannedState extends State<Unplanned> {
  List data = [];

  void _onAdd() {
    Navigator.pushNamed(
      context, 
      '/index/checkList/__selectRiskObject', 
      // arguments: {
      //   "leftBar": leftBar,
      //   "title": leftBar[nextIndex].title,
      //   "qrMessage": qrMsg,
      //   "choosed": nextIndex
      // }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('计划外隐患'),
      floatingActionButton: GestureDetector(
        onTap: _onAdd,
        child: Container(
          height: size.width * 108,
          width: size.width * 108,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1E3BEB),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff3174FF),
                  offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                  blurRadius: 5.0, //阴影模糊程度
                  // spreadRadius: 5.0 //阴影扩散程度
                )
              ]
            ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: size.width * 75,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                      margin: EdgeInsets.only(left: size.width * 10),
                      color: themeColor,
                      padding: EdgeInsets.only(
                          left: size.width * 20, right: size.width * 40),
                      child: Text(
                        '计划外隐患',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                ChecklistUnplanned(
                  dataMap: data[index],
                  callback: () {
                    Navigator.pushNamed(context, '/home/hiddenScreening',
                        arguments: {
                          "id": data[index]['fourId'],
                          "type": data[index]['status'],
                          "title": data[index]['riskUnit'],
                          'authority': 1,
                          'data': data[index],
                        }).then((value) {
                      // _getData();
                    });
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ChecklistUnplanned extends StatelessWidget {
  final Function callback;
  final Map dataMap;
  ChecklistUnplanned({this.callback, this.dataMap});
  List status = ['整改中', '待确认', '整改完毕'];
  List status1 = ['整改完毕', '确认隐患', '整改审批'];

  _getColor(int controlOperable){
    switch (controlOperable) {
      case 1:
        return Color(0xffFF7E00);
        break;
      default:
    }
  }
  _getText(int controlOperable){
    return status[controlOperable];
  }
  _getText1(int controlOperable){
    return status1[controlOperable];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.all(size.width * 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, //阴影颜色
                  offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                  blurRadius: 5.0, //阴影大小
                  spreadRadius: 0.0 //阴影扩散程度
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  dataMap['keyParameterIndex'].toString(),
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: size.width * 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Spacer(),
                Container(
                  height: size.width * 46,
                  width: size.width * 114,
                  decoration: BoxDecoration(
                    color: _getColor(dataMap['controlOperable']).withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _getText(dataMap['controlOperable']),
                    style: TextStyle(
                      fontSize: size.width * 24,
                      color: _getColor(dataMap['controlOperable']),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
            Container(
                  height: size.width * 1.0,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  color: Color(0xffEFEFEF),
                ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '风险分析对象：${dataMap['riskPoint'].toString()}',
                      style: TextStyle(
                          fontSize: size.width * 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '风险分析单元：${dataMap['riskUnit'].toString()}',
                      style: TextStyle(
                          fontSize: size.width * 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '风险事件：${dataMap['riskItem'].toString()}',
                      style: TextStyle(
                          fontSize: size.width * 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: size.width * 100,
                  height: size.width * 34,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(width: size.width * 1, color: _getColor(dataMap['controlOperable'])),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _getText1(dataMap['controlOperable']),
                    style: TextStyle(
                      color: _getColor(dataMap['controlOperable']),
                      fontSize: size.width * 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
