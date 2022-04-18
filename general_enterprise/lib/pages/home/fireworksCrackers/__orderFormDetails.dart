import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class OrderFormDetails extends StatefulWidget {
  OrderFormDetails({this.id});
  final int id;
  @override
  _OrderFormDetailsState createState() => _OrderFormDetailsState();
}

class _OrderFormDetailsState extends State<OrderFormDetails> {
  List detailList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map data = {
    "consigner": "",
    "clientTelephone": "",
    "orderNumber": "",
    "deliveryTime": "",
    "clientName": "",
    "num": 0,
    "consignerTelephone": "",
    "detail": {
      "": []
    }
  };

  _getData(){
    myDio.request(
      type: 'get',
      url: Interface.getByRecordId + widget.id.toString(),
    ).then((value) {
      if(value is Map){
        data = value;
        detailList.clear();
        data['detail'].forEach((key, value) { 
          detailList.add({'name':key,'list':value});
        });
        setState(() {});
      }                                                
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('订单详情'),
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width * 30,
                ),
                Text(
                  '基本信息：',
                  style: TextStyle(
                      fontSize: size.width * 30,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '客户',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        data['clientName'].toString() + '(${data['clientTelephone']})',
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffE4E4E4),
                  height: size.width * 1,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '出库人',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        data['consigner'].toString() + '(${data['consignerTelephone']})',
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffE4E4E4),
                  height: size.width * 1,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '出库编号',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        data['orderNumber'].toString(),
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffE4E4E4),
                  height: size.width * 1,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '出库时间',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        data['deliveryTime'].toString(),
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Container(
            color: Colors.white,
            child: detailList.isNotEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: new NeverScrollableScrollPhysics(),
              itemCount: detailList.length,
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * 20),
                        child: Text(
                          detailList[index]['name'].toString(),
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffEFEFEF),
                        height: size.width * 1,
                        width: double.infinity,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: new NeverScrollableScrollPhysics(),
                          itemCount: detailList[index]['list'].length,
                          itemBuilder: (context, _index){
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 15),
                              child: Row(
                                children: [
                                  Text(
                                    detailList[index]['list'][_index]['productName'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff7487A4),
                                      fontSize: size.width * 26,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    "assets/images/chuku@2x.png",
                                    height: size.width * 30,
                                    width: size.width * 28,
                                  ),
                                  SizedBox(
                                    width: size.width * 15,
                                  ),
                                  Text(
                                    detailList[index]['list'][_index]['num'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff445CFE),
                                      fontSize: size.width * 30
                                    ),
                                  ),
                                ],
                              )
                            );
                          }
                        )
                    ],
                  ),
                );
              }
            ) : Container(),
          )
        ],
      )
    );
  }
}