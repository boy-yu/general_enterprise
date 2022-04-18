import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class WarehouseDetails extends StatefulWidget {
  WarehouseDetails({this.data});
  final Map data;
  @override
  _WarehouseDetailsState createState() => _WarehouseDetailsState();
}

class _WarehouseDetailsState extends State<WarehouseDetails> {
  @override
  void initState() {
    super.initState();
    _getList();
  }

  List productList = [];

  _getList(){
    myDio.request(
      type: 'get', 
      url: Interface.getWarehousingProductListByWarehouseId, 
      queryParameters: {
        'id': widget.data['id'],
    }).then((value) {
      if(value is List){
        print(value);
        productList = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.data['name'].toString()),
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '面积',
                      style: TextStyle(
                        color: Color(0xff5A5A5B),
                        fontSize: size.width * 30
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.data['acreage'].toString() + '㎡',
                      style: TextStyle(
                        color: Color(0xffC1C1C1),
                        fontSize: size.width * 30
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffE4E4E4),
                  margin: EdgeInsets.symmetric(vertical: size.width * 25),
                ),
                Row(
                  children: [
                    Text(
                      '储存量',
                      style: TextStyle(
                        color: Color(0xff5A5A5B),
                        fontSize: size.width * 30
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.data['reserve'].toString() + 'g',
                      style: TextStyle(
                        color: Color(0xffC1C1C1),
                        fontSize: size.width * 30
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffE4E4E4),
                  margin: EdgeInsets.symmetric(vertical: size.width * 25),
                ),
                Row(
                  children: [
                    Text(
                      '仓库安全员',
                      style: TextStyle(
                        color: Color(0xff5A5A5B),
                        fontSize: size.width * 30
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.data['warehouseSecurityOfficer'].toString(),
                      style: TextStyle(
                        color: Color(0xffC1C1C1),
                        fontSize: size.width * 30
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffE4E4E4),
                  margin: EdgeInsets.symmetric(vertical: size.width * 25),
                ),
                Row(
                  children: [
                    Text(
                      '联系电话',
                      style: TextStyle(
                        color: Color(0xff5A5A5B),
                        fontSize: size.width * 30
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.data['telephone'].toString(),
                      style: TextStyle(
                        color: Color(0xffC1C1C1),
                        fontSize: size.width * 30
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(size.width * 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/cahnpinchucun2@2x.png",
                      height: size.width * 32,
                      width: size.width * 32,
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    Text(
                      '产品储存量：共' + productList.length.toString() + '件',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28
                      ),
                    )
                  ],
                ),
                productList.isNotEmpty ? ListView.builder(
                  shrinkWrap: true, 
                  physics:NeverScrollableScrollPhysics(),
                  itemCount: productList.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      padding: EdgeInsets.only(left: size.width * 30, top: size.width * 20, bottom: size.width * 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 1.0
                          )
                        ]
                      ),
                      child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '产品名称：${productList[index]['name']}',
                                    style: TextStyle(
                                      color: Color(0xff7487A4),
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 26
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/tiaoma@2x.png",
                                        height: size.width * 24,
                                        width: size.width * 36,
                                      ),
                                      SizedBox(
                                        width: size.width * 5,
                                      ),
                                      Text(
                                        productList[index]['barCode'].toString(),
                                        style: TextStyle(
                                          color: Color(0xff7487A4),
                                          fontSize: size.width * 24
                                        ),
                                      ),
                                    ],
                                  )
                                  
                                ],
                              ),
                              Spacer(),
                              Row(
                                  children: [
                                    Image.asset(
                                "assets/images/huowuchucun@2x.png",
                                height: size.width * 32,
                                width: size.width * 32,
                              ),
                              SizedBox(
                                width: size.width * 15,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Color(0xff3172FE)),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: productList[index]['stock'].toString(),
                                          style: TextStyle(fontSize: size.width * 40)),
                                      TextSpan(
                                          text: '件',
                                          style: TextStyle(fontSize: size.width * 20)),
                                    ]),
                              ),
                                  ],
                                ),
                              SizedBox(
                                width: size.width * 20,
                              )
                            ],
                          ),
                    );
                  }
                ) : Container(),
              ],
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 
              "/fireworksCrackers/warehousingDeliveryRecord",
              arguments: {
                'id': widget.data['id'],
                // 'type': 'warehouse'
              }
            );
          },
          child: Container(
              padding: EdgeInsets.all(size.width * 30),
              child: Image.asset(
                "assets/images/icon_chuku_jilu.png",
                height: size.width * 40,
                width: size.width * 40,
              )),
        ),
      ],
    );
  }
}