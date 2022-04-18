import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/closedManagement/myView/myClosedMagInputBox.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class Accessrecords extends StatefulWidget {
  @override
  State<Accessrecords> createState() => _AccessrecordsState();
}

class _AccessrecordsState extends State<Accessrecords> {
  int type = 1;

  Map queryParameters = {};

  String keywords = '';

  @override
  void initState() {
    super.initState();
    queryParameters = {
      'type': 1,
      'keywords': keywords
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 30, vertical: size.width * 30),
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
                    child: Column(
                      children: [
                        Text(
                          '车辆记录',
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
                  ),
                  GestureDetector(
                    onTap: () {
                      type = 2;
                      setState(() {});
                    },
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
                  )
                ],
              ),
              SizedBox(
                height: size.width * 30,
              ),
              MyClosedMagInputBox(
                callback: (str) {
                  keywords = str;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: type == 1 
          ? CarRecordList(keywords: keywords) 
          : PerRecordList(keywords: keywords),
        )
      ],
    );
  }
}

class CarRecordList extends StatefulWidget {
  CarRecordList({this.keywords});
  final String keywords;
  @override
  State<CarRecordList> createState() => _CarRecordListState();
}

class _CarRecordListState extends State<CarRecordList> {
  Map queryParameters = {};

  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  void initState() {
    super.initState();
    queryParameters = {
      'type': 2,
      'keywords': widget.keywords
    };
  }

  @override
  void didUpdateWidget(covariant CarRecordList oldWidget) {
    super.didUpdateWidget(oldWidget);
    queryParameters = {
      'type': 2,
      'keywords': widget.keywords
    };
    _throwFunc.run(argument: queryParameters);
  }


  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => GestureDetector(
            onTap: () {
              // Navigator.pushNamed(
              //     context, '/closedManagement/particularsVehicleRecords',
              //     arguments: {'data': list[index]});
            },
            child: Container(
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
                          list[index]['carNo'].toString(),
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * 140,
                        height: size.width * 67,
                        decoration: BoxDecoration(
                            color: list[index]['carType'] == 1
                                ? Color(0xFFFE9F30)
                                : Color(0xff3072FE),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(size.width * 10))),
                        alignment: Alignment.center,
                        child: Text(
                          list[index]['carType'] == 1
                              ? "危化品车辆"
                              : list[index]['carType'] == 2
                                  ? "普通车辆"
                                  : "内部车辆",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: size.width * 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: size.width * 20,
                        top: size.width * 20,
                        bottom: size.width * 20,
                        right: size.width * 40),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              '电话:${list[index]['telephone']}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              height: size.width * 19,
                            ),
                            list[index]['carType'] == 1
                                ? Text(
                                    '化学品名称:${list[index]['hazardousMaterial']}',
                                    style: TextStyle(
                                        fontSize: size.width * 24,
                                        color: Color(0xFF333333)),
                                  )
                                : Container(),
                            list[index]['carType'] == 1
                                ? SizedBox(
                                    height: size.width * 19,
                                  )
                                : Container(),
                            Text(
                              '通过设备:${list[index]['equipmentName']}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              height: size.width * 19,
                            ),
                            Text(
                              '方向:${list[index]['direction'] == 1 ? '入口': '出口'}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              height: size.width * 19,
                            ),
                            Text(
                              '通过时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 19)}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              height: size.width * 19,
                            ),
                          ],
                        ),
                        // Spacer(),
                        // Text(
                        //   '详情',
                        //   style: TextStyle(
                        //     color: Color(0xFF3072FE),
                        //     fontSize: size.width * 24,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        page: true,
        url: Interface.getCurrentRecordList,
        throwFunc: _throwFunc,
        queryParameters: queryParameters,
        listParam: "records",
        method: 'get');
  }
}

class PerRecordList extends StatefulWidget {
  PerRecordList({this.keywords});
  final String keywords;
  @override
  State<PerRecordList> createState() => _PerRecordListState();
}

class _PerRecordListState extends State<PerRecordList> {
  Map queryParameters = {};

  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  void initState() {
    super.initState();
    queryParameters = {
      'type': 1,
      'keywords': widget.keywords
    };
  }

  @override
  void didUpdateWidget(covariant PerRecordList oldWidget) {
    super.didUpdateWidget(oldWidget);
    queryParameters = {
      'type': 1,
      'keywords': widget.keywords
    };
    _throwFunc.run(argument: queryParameters);
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => GestureDetector(
                child: Container(
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
                          '体温:${list[index]['temperature']}℃',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * 140,
                        height: size.width * 67,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: list[index]['personnelType'] == 1
                                ? Color(0xff3072FE)
                                : Color(0xFFFE9F30),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(size.width * 10))),
                        child: Text(
                          list[index]['personnelType'] == 1 ? "内部人员" : "访客人员",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold,
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
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '姓名:${list[index]['name']}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
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
                            // list[index]['type'] == 1
                            //     ? Text(
                            //         '部门:${list[index]['department']}',
                            //         style: TextStyle(
                            //             fontSize: size.width * 24,
                            //             color: Color(0xFF333333)),
                            //       )
                            //     : Container(),
                            // list[index]['type'] == 1
                            //     ? SizedBox(
                            //         height: size.width * 19,
                            //       )
                            //     : Container(),
                            Text(
                              '通过设备:${list[index]['equipmentName']}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              height: size.width * 19,
                            ),
                            Text(
                              '方向:${list[index]['direction'] == 1 ? '入口': '出口' }',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              height: size.width * 19,
                            ),
                            Text(
                              '通过时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 19)}',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xFF333333)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
        page: true,
        url: Interface.getCurrentRecordList,
        throwFunc: _throwFunc,
        queryParameters: queryParameters,
        listParam: "records",
        method: 'get'
      );
  }
}
