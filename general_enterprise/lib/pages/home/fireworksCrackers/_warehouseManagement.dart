import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class WarehouseManagement extends StatefulWidget {
  @override
  _WarehouseManagementState createState() => _WarehouseManagementState();
}

class _WarehouseManagementState extends State<WarehouseManagement> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MyRefres(
          child: (index, data) => InkWell(
            onTap: (){
              Navigator.pushNamed(context, 
                "/fireworksCrackers/warehouseDetails",
                arguments: {
                  'data': data[index]
                }
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 30),
              padding: EdgeInsets.all(size.width * 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1.0,
                    spreadRadius: 1.0
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data[index]['name'].toString() + '(' + (data[index]['acreage'] == '' ? '0' : data[index]['acreage']) + 'm²)',
                        style: TextStyle(
                          fontSize: size.width * 26,
                          color: Color(0xff7487A4),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        width: size.width * 15,
                      ),
                      data[index]['status'] == 1 ? Container(
                        width: size.width * 70,
                        height: size.width * 30,
                        decoration: BoxDecoration(
                          color: Color(0xffFF3030),
                          borderRadius: BorderRadius.all(Radius.circular(size.width * 4))
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '超量',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 20
                          ),
                        ),
                      ) : Container(),
                      Spacer(),
                      Image.asset(
                        "assets/images/cangkuchucun@2x.png",
                        width: size.width * 30,
                        height: size.width * 30,
                      ),
                      SizedBox(
                        width: size.width * 10,
                      ),
                      Text(
                        data[index]['reserve'].toString() + 'g',
                        style: TextStyle(
                          color: Color(0xff445CFE),
                          fontSize: size.width * 30
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Text(
                    '仓库安全员：' + (data[index]['warehouseSecurityOfficer'].toString() == '' ? '无' : data[index]['warehouseSecurityOfficer'].toString()) + '(${data[index]['telephone']})',
                    style: TextStyle(
                      fontSize: size.width * 22,
                      color: Color(0xff7487A4),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
          // listParam: "records",
          page: true,
          url: Interface.getWarehousingWarehouseList,
          method: 'get'),
    );
  }
}