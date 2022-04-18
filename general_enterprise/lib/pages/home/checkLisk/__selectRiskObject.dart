
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SelectRiskObject extends StatefulWidget {
  @override
  _SelectRiskObjectState createState() => _SelectRiskObjectState();
}

class _SelectRiskObjectState extends State<SelectRiskObject> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('选择风险分析对象'),
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(
                  context, 
                  '/index/checkList/___appendUnplannedRisk', 
                  // arguments: {
                  //   "leftBar": leftBar,
                  //   "title": leftBar[nextIndex].title,
                  //   "qrMessage": qrMsg,
                  //   "choosed": nextIndex
                  // }
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
                margin: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                      blurRadius: 3.0, //阴影模糊程度
                      // spreadRadius: 5.0 //阴影扩散程度
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 60,
                      width: size.width * 60,
                      decoration: BoxDecoration(
                        color: Color(0xffFF1D1C),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        data[index]['title'],
                        style: TextStyle(
                          fontSize: size.width * 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    Text(
                      '风险分析对象：${data[index]['riskObject'].toString()}',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 24
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}