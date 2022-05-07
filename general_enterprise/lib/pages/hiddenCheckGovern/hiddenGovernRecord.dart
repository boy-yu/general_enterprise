import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myDateSelect.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenCheckTask.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class HiddenGovernRecord extends StatefulWidget {
  @override
  State<HiddenGovernRecord> createState() => _HiddenGovernRecordState();
}

class _HiddenGovernRecordState extends State<HiddenGovernRecord> {
  int chooseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Container(
          height: size.width * 72,
          width: size.width * 488,
          decoration: BoxDecoration(
              color: Color(0xff1E62EB),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 46))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  chooseIndex = 0;
                  setState(() {});
                },
                child: Container(
                  height: size.width * 64,
                  width: size.width * 240,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 0
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '排查隐患台账',
                    style: TextStyle(
                        fontSize: size.width * 28,
                        color:
                            chooseIndex == 0 ? Color(0xff3074FF) : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  chooseIndex = 1;
                  setState(() {});
                },
                child: Container(
                  height: size.width * 64,
                  width: size.width * 240,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 1
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '上报隐患台账',
                    style: TextStyle(
                        fontSize: size.width * 28,
                        color:
                            chooseIndex == 1 ? Color(0xff3074FF) : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        child: chooseIndex == 0 ? CheckHiddenRecord() : ReportedHiddenRecord());
  }
}

class CheckHiddenRecord extends StatefulWidget {
  @override
  State<CheckHiddenRecord> createState() => _CheckHiddenRecordState();
}

class _CheckHiddenRecordState extends State<CheckHiddenRecord> {
  String startDate;
  String endDate;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "riskObjectId": null,
      "riskUnitId": null,
      "riskEventId": null
    };
    _getDropList();
    DateTime dateTime = DateTime.now();
    startDate = dateTime.toString().substring(0, 10);
    endDate = dateTime.toString().substring(0, 10);
  }

  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    }
  ];

  _deleteIndex(int index) {
    for (var i = dropTempData.length - 1; i > index; i--) {
      dropTempData.removeAt(i);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map queryParameters = {};
  ThrowFunc _throwFunc = new ThrowFunc();

  List dropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    },
    {
      'title': '风险分析单元',
      'data': [],
      'value': '',
      "saveTitle": '风险分析单元',
      'dataUrl': Interface.getRiskUnitByDepartmentId,
      'limit': 'riskUnitId'
    },
    {
      'title': '风险事件',
      'data': [],
      'value': '',
      "saveTitle": '风险事件',
      'dataUrl': Interface.getRiskEventByDepartmentId,
      'limit': 'riskEventId'
    },
  ];

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio
            .request(
          type: 'get',
          url: dropTempData[i]['dataUrl'],
        )
            .then((value) {
          dropTempData[i]['data'] = value;
          dropTempData[i]['data'].insert(0, {"name": "查看全部"});
          if (mounted) {
            setState(() {});
          }
        });
      }
    }
  }

  _dropList({int index, String msg}) {
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      queryParameters = {
        "riskObjectId": null,
        "riskUnitId": null,
        "riskEventId": null
      };
      print(queryParameters);
      _throwFunc.run(argument: queryParameters);
      if (mounted) {
        setState(() {});
      }
      return;
    }
    _deleteIndex(index);
    String id = '';
    dropTempData[index]['data'].forEach((ele) {
      if (dropTempData[index]['value'] == ele['name']) {
        id = ele['id'];
        dropTempData[index]['id'] = ele['id'];
      }
    });
    if (index + 1 < dropList.length && dropTempData.length <= index + 1) {
      dynamic map = {};
      if (index == 0) {
        map = {'riskObjectId': id};
      } else if (index == 1) {
        map = {'riskUnitId': id};
      }
      dropTempData.add(jsonDecode(jsonEncode(dropList[index + 1])));
      myDio
          .request(
              type: 'get',
              url: dropTempData[index + 1]['dataUrl'],
              queryParameters: map)
          .then((value) {
        dropTempData[index + 1]['data'] = value;
        if (mounted) {
          setState(() {});
        }
      });
    }

    dropTempData.forEach((element) {
      if (element['id'] != null) {
        queryParameters[element['limit'].toString()] = element['id'];
      }
    });
    if (index == 0) {
      queryParameters["riskUnitId"] = null;
    }
    print(queryParameters);

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  List dangerStateList = ['全部', '待确认', '整改中', '待验收', '已验收'];
  String dangerStateStr = '';
  String keyStr = '';

  List dangerLevelList = ['全部', '无隐患', '一般隐患', '重大隐患'];
  String dangerLevelStr = '';

  List data = [
    {
      'dangerState': '1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '', // 隐患等级（一般隐患：0；重大隐患：1）
      'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
      'checkUser': '上报人员名字',
      'checkEndDate': '2022-03-25 12:36:22'
    },
    {
      'dangerState': '-1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
      'checkUser': '上报人员名字',
      'checkEndDate': '2022-03-25 12:36:22'
    },
    {
      'dangerState': '0', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '', // 隐患等级（一般隐患：0；重大隐患：1）
      'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
      'checkUser': '上报人员名字',
      'checkEndDate': '2022-03-25 12:36:22'
    },
    {
      'dangerState': '1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
      'checkUser': '上报人员名字',
      'checkEndDate': '2022-03-25 12:36:22'
    },
    {
      'dangerState': '9', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '1', // 隐患等级（一般隐患：0；重大隐患：1）
      'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
      'checkUser': '上报人员名字',
      'checkEndDate': '2022-03-25 12:36:22'
    },
    {
      'dangerState': '1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
      'checkUser': '上报人员名字',
      'checkEndDate': '2022-03-25 12:36:22'
    },
  ];

  Widget _getDangerState(String dangerState) {
    // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
    switch (dangerState) {
      case '-1':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffFFCA0E),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '待确认',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '0':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffFF9900),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '整改中',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '1':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffF56271),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '待验收',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '9':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xff5FD5EC),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '已验收',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      default:
        return Container();
    }
  }

  Widget _getDangerLevel(String dangerLevel) {
    // 隐患等级（一般隐患：0；重大隐患：1）
    switch (dangerLevel) {
      case '0':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffFF9900),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '一般隐患',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '1':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffF56271),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '重大隐患',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      default:
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xff2276FC),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '无隐患',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF8FAFF),
        child: Column(
          children: [
            TitleChoose(
              list: dropTempData,
              getDataList: _dropList,
            ),
            Container(
              height: size.width * 2,
              width: double.infinity,
              color: Color(0xffF2F2F2),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // 筛选 状态 管控手段
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              builder: (BuildContext context) {
                                return ListView.builder(
                                  itemCount: dangerStateList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        dangerStateStr =
                                            dangerStateList[index].toString();
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            dangerStateList[index].toString()),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          width: size.width * 328,
                          height: size.width * 60,
                          margin: EdgeInsets.only(top: size.width * 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 16,
                              vertical: size.width * 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: size.width * 2,
                              color: Color(0xffF2F2F2),
                            ),
                            borderRadius: BorderRadius.circular(size.width * 8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                dangerStateStr == ''
                                    ? "请选择整改状态"
                                    : dangerStateStr,
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff7F8A9C),
                                size: size.width * 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              builder: (BuildContext context) {
                                return ListView.builder(
                                  itemCount: dangerLevelList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        dangerLevelStr =
                                            dangerLevelList[index].toString();
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            dangerLevelList[index].toString()),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          width: size.width * 328,
                          height: size.width * 60,
                          margin: EdgeInsets.only(top: size.width * 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 16,
                              vertical: size.width * 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: size.width * 2,
                              color: Color(0xffF2F2F2),
                            ),
                            borderRadius: BorderRadius.circular(size.width * 8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                dangerLevelStr == ''
                                    ? "请选择隐患等级"
                                    : dangerLevelStr,
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff7F8A9C),
                                size: size.width * 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 筛选 时间
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MyDateSelect(
                        title: 'startDate',
                        purview: 'startDate',
                        hintText: '开始时间',
                        callback: (value) {
                          startDate = value;
                        },
                        icon: Image.asset(
                          'assets/images/doubleRiskProjeck/icon_calendar.png',
                          height: size.width * 28,
                          width: size.width * 28,
                        ),
                      ),
                      MyDateSelect(
                        title: 'endDate',
                        purview: 'endDate',
                        hintText: '结束时间',
                        callback: (value) {
                          endDate = value;
                          // _getData();
                          // _throwFunc.run(argument: queryParameters);
                          setState(() {});
                        },
                        icon: Image.asset(
                          'assets/images/doubleRiskProjeck/icon_calendar.png',
                          height: size.width * 28,
                          width: size.width * 28,
                        ),
                      ),
                    ],
                  ),
                  // 关键字搜索
                  Container(
                      margin: EdgeInsets.only(
                          right: size.width * 32,
                          left: size.width * 32,
                          bottom: size.width * 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width * 8),

                        ///圆角
                        border: Border.all(
                            color: Color(0xffF2F2F2), width: size.width * 2),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: size.width * 60,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 20),
                            child: Icon(
                              Icons.search,
                              color: Color(0xff7F8A9C),
                              size: size.width * 40,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: _controller,
                              onChanged: (value) {
                                keyStr = value;
                                setState(() {});
                              },
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff7F8A9C)),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: size.width * 30),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff7F8A9C)),
                                  hintText: keyStr == '' ? '输入关键字搜索' : keyStr),
                              maxLines: 1,
                              minLines: 1,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Expanded(
                child: MyRefres(
              child: (index, list) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, '/hiddenCheckGovern/hiddenGovernRecordDetails');
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: size.width * 32,
                      right: size.width * 32,
                      left: size.width * 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 16),
                        child: Row(
                          children: [
                            _getDangerState(list[index]['dangerState']),
                            SizedBox(
                              width: size.width * 16,
                            ),
                            _getDangerLevel(list[index]['dangerLevel']),
                            Spacer(),
                            Text(
                              '详情 >',
                              style: TextStyle(
                                  color: Color(0xff3074FF),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 24,
                            vertical: size.width * 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(size.width * 20),
                              bottomRight: Radius.circular(size.width * 20)),
                        ),
                        constraints: BoxConstraints(
                          minWidth: size.width * 686,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控措施：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: data[index]['riskMeasureDesc'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '隐患内容：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: data[index]
                                            ['troubleshootContent'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '排查人：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: data[index]['checkUser'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '排查时间：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: data[index]['checkEndDate'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // page: true,
              // url: Interface.getHistoricalSubscribe,
              // listParam: "records",
              // queryParameters: {
              //   'type': 2,
              // },
              // method: 'get'
              data: data,
            ))
          ],
        ));
  }
}

class ReportedHiddenRecord extends StatefulWidget {
  @override
  State<ReportedHiddenRecord> createState() => _ReportedHiddenRecordState();
}

class _ReportedHiddenRecordState extends State<ReportedHiddenRecord> {
  String startDate;
  String endDate;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "riskObjectId": null,
    };
    _getDropList();
    DateTime dateTime = DateTime.now();
    startDate = dateTime.toString().substring(0, 10);
    endDate = dateTime.toString().substring(0, 10);
  }

  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    }
  ];

  _deleteIndex(int index) {
    for (var i = dropTempData.length - 1; i > index; i--) {
      dropTempData.removeAt(i);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map queryParameters = {};
  ThrowFunc _throwFunc = new ThrowFunc();

  List dropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    },
  ];

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio
            .request(
          type: 'get',
          url: dropTempData[i]['dataUrl'],
        )
            .then((value) {
          dropTempData[i]['data'] = value;
          dropTempData[i]['data'].insert(0, {"name": "查看全部"});
          if (mounted) {
            setState(() {});
          }
        });
      }
    }
  }

  _dropList({int index, String msg}) {
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      queryParameters = {
        "riskObjectId": null,
      };
      print(queryParameters);
      _throwFunc.run(argument: queryParameters);
      if (mounted) {
        setState(() {});
      }
      return;
    }
    _deleteIndex(index);

    dropTempData.forEach((element) {
      if (element['id'] != null) {
        queryParameters[element['limit'].toString()] = element['id'];
      }
    });
    print(queryParameters);

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  List dangerStateList = ['全部', '待确认', '整改中', '待验收', '已验收'];
  String dangerStateStr = '';
  String keyStr = '';

  List dangerLevelList = ['全部', '无隐患', '一般隐患', '重大隐患'];
  String dangerLevelStr = '';

  List data = [
    {
      'dangerState': '1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '', // 隐患等级（一般隐患：0；重大隐患：1）
      'place': '地点地点地点地点地点地点地点地点地点',
      'reportedPer': '上报人',
      'checkEndDate': '2022-03-25 12:36:22',
      'image': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '-1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'place': '地点地点地点地点地点地点地点地点地点',
      'reportedPer': '上报人',
      'checkEndDate': '2022-03-25 12:36:22',
      'image': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '0', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '', // 隐患等级（一般隐患：0；重大隐患：1）
      'place': '地点地点地点地点地点地点地点地点地点',
      'reportedPer': '上报人',
      'checkEndDate': '2022-03-25 12:36:22',
      'image': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'place': '地点地点地点地点地点地点地点地点地点',
      'reportedPer': '上报人',
      'checkEndDate': '2022-03-25 12:36:22',
      'image': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '9', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '1', // 隐患等级（一般隐患：0；重大隐患：1）
      'place': '地点地点地点地点地点地点地点地点地点',
      'reportedPer': '上报人',
      'checkEndDate': '2022-03-25 12:36:22',
      'image': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '1', // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'place': '地点地点地点地点地点地点地点地点地点',
      'reportedPer': '上报人',
      'checkEndDate': '2022-03-25 12:36:22',
      'image': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
  ];

  Widget _getDangerState(String dangerState) {
    // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
    switch (dangerState) {
      case '-1':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffFFCA0E),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '待确认',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '0':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffFF9900),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '整改中',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '1':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffF56271),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '待验收',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '9':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xff5FD5EC),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '已验收',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      default:
        return Container();
    }
  }

  Widget _getDangerLevel(String dangerLevel) {
    // 隐患等级（一般隐患：0；重大隐患：1）
    switch (dangerLevel) {
      case '0':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffFF9900),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '一般隐患',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      case '1':
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xffF56271),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '重大隐患',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
        break;
      default:
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 16, vertical: size.width * 6),
            decoration: BoxDecoration(
                color: Color(0xff2276FC),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            child: Text(
              '无隐患',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 24,
                  fontWeight: FontWeight.w500),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF8FAFF),
        child: Column(
          children: [
            TitleChoose(
              list: dropTempData,
              getDataList: _dropList,
            ),
            Container(
              height: size.width * 2,
              width: double.infinity,
              color: Color(0xffF2F2F2),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // 筛选 状态 管控手段
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              builder: (BuildContext context) {
                                return ListView.builder(
                                  itemCount: dangerStateList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        dangerStateStr =
                                            dangerStateList[index].toString();
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            dangerStateList[index].toString()),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          width: size.width * 328,
                          height: size.width * 60,
                          margin: EdgeInsets.only(top: size.width * 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 16,
                              vertical: size.width * 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: size.width * 2,
                              color: Color(0xffF2F2F2),
                            ),
                            borderRadius: BorderRadius.circular(size.width * 8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                dangerStateStr == ''
                                    ? "请选择整改状态"
                                    : dangerStateStr,
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff7F8A9C),
                                size: size.width * 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              builder: (BuildContext context) {
                                return ListView.builder(
                                  itemCount: dangerLevelList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        dangerLevelStr =
                                            dangerLevelList[index].toString();
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            dangerLevelList[index].toString()),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          width: size.width * 328,
                          height: size.width * 60,
                          margin: EdgeInsets.only(top: size.width * 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 16,
                              vertical: size.width * 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: size.width * 2,
                              color: Color(0xffF2F2F2),
                            ),
                            borderRadius: BorderRadius.circular(size.width * 8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                dangerLevelStr == ''
                                    ? "请选择隐患等级"
                                    : dangerLevelStr,
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff7F8A9C),
                                size: size.width * 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 筛选 时间
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MyDateSelect(
                        title: 'startDate',
                        purview: 'startDate',
                        hintText: '开始时间',
                        callback: (value) {
                          startDate = value;
                        },
                        icon: Image.asset(
                          'assets/images/doubleRiskProjeck/icon_calendar.png',
                          height: size.width * 28,
                          width: size.width * 28,
                        ),
                      ),
                      MyDateSelect(
                        title: 'endDate',
                        purview: 'endDate',
                        hintText: '结束时间',
                        callback: (value) {
                          endDate = value;
                          // _getData();
                          // _throwFunc.run(argument: queryParameters);
                          setState(() {});
                        },
                        icon: Image.asset(
                          'assets/images/doubleRiskProjeck/icon_calendar.png',
                          height: size.width * 28,
                          width: size.width * 28,
                        ),
                      ),
                    ],
                  ),
                  // 关键字搜索
                  Container(
                      margin: EdgeInsets.only(
                          right: size.width * 32,
                          left: size.width * 32,
                          bottom: size.width * 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.width * 8),

                        ///圆角
                        border: Border.all(
                            color: Color(0xffF2F2F2), width: size.width * 2),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: size.width * 60,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 20),
                            child: Icon(
                              Icons.search,
                              color: Color(0xff7F8A9C),
                              size: size.width * 40,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: _controller,
                              onChanged: (value) {
                                keyStr = value;
                                setState(() {});
                              },
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff7F8A9C)),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: size.width * 30),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff7F8A9C)),
                                  hintText: keyStr == '' ? '输入关键字搜索' : keyStr),
                              maxLines: 1,
                              minLines: 1,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Expanded(
                child: MyRefres(
              child: (index, list) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, '/hiddenCheckGovern/hiddenGovernRecordDetails');
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: size.width * 32,
                      right: size.width * 32,
                      left: size.width * 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 16),
                        child: Row(
                          children: [
                            _getDangerState(list[index]['dangerState']),
                            SizedBox(
                              width: size.width * 16,
                            ),
                            _getDangerLevel(list[index]['dangerLevel']),
                            Spacer(),
                            Text(
                              '详情 >',
                              style: TextStyle(
                                  color: Color(0xff3074FF),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 24,
                              vertical: size.width * 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff2276FC).withOpacity(0.12),
                                Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(size.width * 20),
                                bottomRight: Radius.circular(size.width * 20)),
                          ),
                          constraints: BoxConstraints(
                            minWidth: size.width * 686,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 420,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '地点：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data[index]['place'],
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: size.width * 16,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '上报人：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data[index]
                                                    ['reportedPer'],
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: size.width * 16,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '排查时间：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data[index]
                                                    ['checkEndDate'],
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: size.width * 16,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: size.width * 128,
                                width: size.width * 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 8)),
                                  image: DecorationImage(
                                      image: AssetImage(data[index]['image']),
                                      fit: BoxFit.fill),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              // page: true,
              // url: Interface.getHistoricalSubscribe,
              // listParam: "records",
              // queryParameters: {
              //   'type': 2,
              // },
              // method: 'get'
              data: data,
            ))
          ],
        ));
  }
}
