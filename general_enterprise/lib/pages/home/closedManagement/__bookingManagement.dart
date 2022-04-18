import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/closedManagement/myView/myClosedMagInputBox.dart';
import 'package:enterprise/pages/home/closedManagement/myView/mySureDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class BookingManagement extends StatefulWidget {
  @override
  State<BookingManagement> createState() => _BookingManagementState();
}

class _BookingManagementState extends State<BookingManagement> {
  int type = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          type = 1;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.width * 29,
                              horizontal: size.width * 30),
                          child: Column(
                            children: [
                              Text(
                                '车辆管理',
                                style: TextStyle(
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Container(
                                height: size.width * 4,
                                width: size.width * 104,
                                decoration: BoxDecoration(
                                    color: type == 1
                                        ? Color(0xFF2E6BFB)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 2.0))),
                              )
                            ],
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          type = 2;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.width * 29,
                              horizontal: size.width * 30),
                          child: Column(
                            children: [
                              Text(
                                '人员记录',
                                style: TextStyle(
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Container(
                                height: size.width * 4,
                                width: size.width * 104,
                                decoration: BoxDecoration(
                                    color: type == 1
                                        ? Colors.transparent
                                        : Color(0xFF2E6BFB),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 2.0))),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: type == 1 ? CarRecord() : PerRecord())
        ],
    );
  }
}

class CarRecord extends StatefulWidget {
  @override
  State<CarRecord> createState() => _CarRecordState();
}

class _CarRecordState extends State<CarRecord> {
  int typecar = 1;

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    typecar = 1;
                    setState(() {});
                  },
                  child: Container(
                    width: size.width * 255,
                    height: size.width * 76,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: size.width * 30),
                    decoration: BoxDecoration(
                        color: typecar == 1
                            ? Color(0xFF3072FE).withOpacity(0.1)
                            : Color(0xFFFAFAFB),
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 38))),
                    child: Text(
                      '危险化学品车辆',
                      style: TextStyle(
                          color:
                              typecar == 1 ? Color(0xFF3072FE) : Color(0xFFACACBC),
                          // color: Colors.black,
                          fontSize: size.width * 24),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    typecar = 2;
                    setState(() {});
                  },
                  child: Container(
                    width: size.width * 255,
                    height: size.width * 76,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: size.width * 30),
                    decoration: BoxDecoration(
                        color: typecar == 2
                            ? Color(0xFF3072FE).withOpacity(0.1)
                            : Color(0xFFFAFAFB),
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 38))),
                    child: Text(
                      '普通车辆',
                      style: TextStyle(
                          color:
                              typecar == 2 ? Color(0xFF3072FE) : Color(0xFFACACBC),
                          fontSize: size.width * 24),
                    ),
                  ),
                )
              ],
            ),
          ),
        Expanded(
            child: typecar == 1 ? HazardousChemicalsRecord() : GeneralRecord())
        ],
      );
  }
}

class HazardousChemicalsRecord extends StatefulWidget {
  @override
  State<HazardousChemicalsRecord> createState() =>
      _HazardousChemicalsRecordState();
}

class _HazardousChemicalsRecordState extends State<HazardousChemicalsRecord> {
  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  void initState() {
    super.initState();
    _getGateList();
  }

  List gateList = [];

  _getGateList(){
    myDio.request(
        type: "get",
        url: Interface.getCarEquipmentList,
    ).then((value) {
      if (value is List) {
        gateList = value;
        setState(() {});
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
      child: (index, list) => Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 10))),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 25),
                      child: Text(
                        list[index]['carNo'],
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: size.width * 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        MySureDialog.mySureDialog(
                                context, 
                                (){
                                  _throwFunc.run();
                                },
                                gateList,
                                2,
                                list[index]['id']
                              );
                      },
                      child: Container(
                        // width: size.width * 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(size.width * 10))),
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 22,
                            horizontal: size.width * 23),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icon_kstd@2x.png",
                              height: size.width * 22,
                              width: size.width * 36,
                            ),
                            SizedBox(
                              width: size.width * 9,
                            ),
                            Text(
                              '快速通过',
                              style: TextStyle(
                                color: Color(0xFF3072FE),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1,
                  color: Color(0xFFEEEEEE),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '驾驶员姓名:${list[index]['name']}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '申请时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 19)}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '预计来访时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['visitingTime']).toString().substring(0, 19)}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '危险化学品名称:${list[index]['hazardousMaterial']}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/closedManagement/appointmentManagementAudit',
                            arguments: {'type': '危化品车辆', 'data': list[index], 'gateList': gateList}).then((value) => {
                              _throwFunc.run()
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 24),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 24,
                            vertical: size.width * 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              color: Color(0xFF19B00E),
                              style: BorderStyle.solid,
                              width: size.width * 2),
                          // border: BoxBorder.lerp(a, b, t)
                        ),
                        child: Text(
                          '审核',
                          style: TextStyle(
                            color: Color(0xFF19B00E),
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
      page: true,
      url: Interface.getSubscribeList,
      queryParameters: {
        'type': 2,
        'carType': 1,
        'status': 0
      },
      throwFunc: _throwFunc,
      listParam: "records",
      method: 'get',
    );
  }
}

class GeneralRecord extends StatefulWidget {
  @override
  State<GeneralRecord> createState() => _GeneralRecordState();
}

class _GeneralRecordState extends State<GeneralRecord> {
  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  void initState() {
    super.initState();
    _getGateList();
  }

  List gateList = [];

  _getGateList(){
    myDio.request(
        type: "get",
        url: Interface.getCarEquipmentList,
    ).then((value) {
      if (value is List) {
        gateList = value;
        setState(() {});
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
      child: (index, list) => Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 10))),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 25),
                      child: Text(
                        list[index]['carNo'],
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: size.width * 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        MySureDialog.mySureDialog(
                                context, 
                                (){
                                  _throwFunc.run();
                                },
                                gateList,
                                2,
                                list[index]['id']
                              );
                      },
                      child: Container(
                        // width: size.width * 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(size.width * 10))),
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 22,
                            horizontal: size.width * 23),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icon_kstd@2x.png",
                              height: size.width * 22,
                              width: size.width * 36,
                            ),
                            SizedBox(
                              width: size.width * 9,
                            ),
                            Text(
                              '快速通过',
                              style: TextStyle(
                                color: Color(0xFF3072FE),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1,
                  color: Color(0xFFEEEEEE),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '驾驶员姓名:${list[index]['name']}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '申请时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 19)}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                          Text(
                            '预计来访时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['visitingTime']).toString().substring(0, 19)}',
                            style: TextStyle(
                                fontSize: size.width * 24,
                                color: Color(0xFF333333)),
                          ),
                          SizedBox(
                            height: size.width * 19,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/closedManagement/appointmentManagementAudit',
                            arguments: {'type': '普通车辆', 'data': list[index], 'gateList': gateList}).then((value) => {
                              _throwFunc.run()
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 24),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 24,
                            vertical: size.width * 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              color: Color(0xFF19B00E),
                              style: BorderStyle.solid,
                              width: size.width * 2),
                          // border: BoxBorder.lerp(a, b, t)
                        ),
                        child: Text(
                          '审核',
                          style: TextStyle(
                            color: Color(0xFF19B00E),
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
      page: true,
      url: Interface.getSubscribeList,
      queryParameters: {
        'type': 2,
        'carType': 2,
        'status': 0
      },
      throwFunc: _throwFunc,
      listParam: "records",
      method: 'get',
    );
  }
}

class PerRecord extends StatefulWidget {
  @override
  State<PerRecord> createState() => _PerRecordState();
}

class _PerRecordState extends State<PerRecord> {
  ThrowFunc _throwFunc = ThrowFunc();
  Map queryParameters = {};

  List gateList = [];

  @override
  void initState() {
    super.initState();
    queryParameters = {
                'type': 1,
                'status': 0,
                'keywords': ''
              };
    _getGateList();
  }

  _getGateList(){
    myDio.request(
        type: "get",
        url: Interface.getFaceGate,
    ).then((value) {
      if (value is List) {
        gateList = value;
        setState(() {});
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: size.width * 40,right: size.width * 40, bottom: size.width * 30),
            color: Colors.white,
            child: MyClosedMagInputBox(
                callback: (str) {
                  print(str);
                  queryParameters['keywords'] = str;
                  _throwFunc.run(argument: queryParameters);
                },
              ),
          ),
          Expanded(
            child: MyRefres(
              child: (index, list) => Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 10))),
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: size.width * 25),
                            child: Text(
                              '姓名:${list[index]['name']}',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: size.width * 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              MySureDialog.mySureDialog(
                                context, 
                                (){
                                  _throwFunc.run();
                                },
                                gateList,
                                1,
                                list[index]['id']
                              );
                            },
                            child: Container(
                              // width: size.width * 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(size.width * 10))),
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 22,
                                  horizontal: size.width * 23),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/icon_kstd@2x.png",
                                    height: size.width * 22,
                                    width: size.width * 36,
                                  ),
                                  SizedBox(
                                    width: size.width * 9,
                                  ),
                                  Text(
                                    '快速通过',
                                    style: TextStyle(
                                      color: Color(0xFF3072FE),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        color: Color(0xFFEEEEEE),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: size.width * 26),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.width * 19,
                                ),
                                Text(
                                  '电话:${list[index]['telephone']}',
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xFF333333)),
                                ),
                                SizedBox(
                                  height: size.width * 19,
                                ),
                                Text(
                                  '申请时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 19)}',
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xFF333333)),
                                ),
                                SizedBox(
                                  height: size.width * 19,
                                ),
                                Text(
                                  '预计来访时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['visitingTime']).toString().substring(0, 19)}',
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xFF333333)),
                                ),
                                SizedBox(
                                  height: size.width * 19,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  '/closedManagement/appointmentManagementAudit',
                                  arguments: {'type': '内部人员', 'data': list[index], 'gateList': gateList}).then((value) => {
                                    _throwFunc.run()
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: size.width * 24),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 24,
                                  vertical: size.width * 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: Color(0xFF19B00E),
                                    style: BorderStyle.solid,
                                    width: size.width * 2),
                                // border: BoxBorder.lerp(a, b, t)
                              ),
                              child: Text(
                                '审核',
                                style: TextStyle(
                                  color: Color(0xFF19B00E),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              page: true,
              url: Interface.getSubscribeList,
              queryParameters: queryParameters,
              listParam: "records",
              method: 'get',
              throwFunc: _throwFunc,
              // data: data
            )
          )
        ],
      );
  }
}
