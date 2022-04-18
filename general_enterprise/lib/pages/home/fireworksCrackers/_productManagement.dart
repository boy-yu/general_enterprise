import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ProductManagement extends StatefulWidget {
  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MyRefres(
          child: (index, data) => GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 
                "/fireworksCrackers/productDetails",
                arguments: {
                  'id': data[index]['id']
                }
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: size.width * 30,
                  right: size.width * 30,
                  left: size.width * 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0),
                  ]),
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 30, horizontal: size.width * 30),
              child: Row(
                children: [
                  Text(
                    data[index]['name'],
                    style: TextStyle(
                        fontSize: size.width * 26,
                        color: Color(0xff7487A4),
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
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
                              text: data[index]['num'].toString(),
                              style: TextStyle(fontSize: size.width * 40)),
                          TextSpan(
                              text: '件',
                              style: TextStyle(fontSize: size.width * 20)),
                        ]),
                  )
                ],
              ),
            ),
          ),
          listParam: "records",
          page: true,
          url: Interface.getWarehousingProductList,
          method: 'get'),
    );
  }
}
