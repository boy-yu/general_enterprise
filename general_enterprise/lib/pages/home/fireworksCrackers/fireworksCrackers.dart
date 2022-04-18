import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class FireworksCrackers extends StatefulWidget {
  @override
  _FireworksCrackersState createState() => _FireworksCrackersState();
}

class _FireworksCrackersState extends State<FireworksCrackers> {
  List fireworksCrackersList = [
      {"name": "产品出入库", "router": "/fireworksCrackers/fireworksCrackersLeftList", "icon": 'assets/images/fireworks_cracker_ex_warehouse_checked.png'},
      {"name": "产品出库", "router": "/fireworksCrackers/fireworksCrackersLeftList", "icon": 'assets/images/fireworks_cracker_ex_warehouse_checked.png'},
      {"name": "产品管理", "router": "/fireworksCrackers/fireworksCrackersLeftList", "icon": 'assets/images/fireworks_cracker_product_checked.png'},
      {"name": "仓库管理", "router": "/fireworksCrackers/fireworksCrackersLeftList", "icon": 'assets/images/fireworks_cracker_warehouse_checked.png'},
      {"name": "客户订单管理", "router": "/fireworksCrackers/fireworksCrackersLeftList", "icon": 'assets/images/fireworks_cracker_indent_checked.png'},
      {"name": "供应商管理", "router": "/fireworksCrackers/fireworksCrackersLeftList", "icon": 'assets/images/fireworks_cracker_supplier_checked.png'},
    ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MyAppbar(
      title: Text('出入库管理'),
      child: Container(
        color: Colors.white,
        height: height,
        child: ListView.builder(
          itemCount: fireworksCrackersList.length,
          shrinkWrap: true,
          itemBuilder: (builder, index) {
            return Padding(
              padding: EdgeInsets.only(right: size.width * 31, left: size.width * 33, top: size.width * 35.0),
              // InkWell 添加 Material触摸水波效果
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    fireworksCrackersList[index]['router'],
                    arguments: {
                      'index': index,
                    } 
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          fireworksCrackersList[index]['icon'],
                          height: size.width * 42,
                          width: size.width * 42,
                        ),
                        SizedBox(
                          width: size.width * 34,
                        ),
                        Text(
                          fireworksCrackersList[index]['name'],
                          style: TextStyle(
                            color: Color(0xff3C3C3C),
                            fontSize: size.width * 26
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: size.width * 31,
                          width: size.width * 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xff2E6CFD),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '查看',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 20
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 35,
                    ),
                    index != fireworksCrackersList.length - 1 ? Container(
                      color: Color(0xffEFEFEF),
                      height: size.width * 1,
                      width: double.infinity,
                    ) : Container(),
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}