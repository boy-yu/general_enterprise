import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class HiddenCheckRecordDetails extends StatefulWidget {
  HiddenCheckRecordDetails({this.id});
  final String id;
  @override
  State<HiddenCheckRecordDetails> createState() =>
      _HiddenCheckRecordDetailsState();
}

class _HiddenCheckRecordDetailsState extends State<HiddenCheckRecordDetails> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    myDio.request(
        type: 'get',
        url: Interface.getcheckRecordById,
        queryParameters: {'id': widget.id}).then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Map data = {
    "id": "",
    "checkTime": 1651726922976,
    "hazardCode": "",
    "riskObjectId": "",
    "riskUnitId": "",
    "riskEventId": "",
    "riskMeasureId": "",
    "checkTaskId": "",
    "companyId": "",
    "companyCode": "",
    "checkUserId": "",
    "checkUser": "",
    "checkSign": "",
    "checkOpinion": "",
    "checkData": "",
    "checkDepartment": "",
    "checkDepartmentId": "",
    "checkUrl": "",
    "checkStatus": "",
    "checkMeans": "",
    "checkStartDate": null,
    "checkEndDate": 1651743229000,
    "createDate": null,
    "createBy": "",
    "createByMobile": "",
    "updateDate": null,
    "updateBy": "",
    "updateByMobile": "",
    "riskMeasureDesc": "",
    "troubleshootContent": "",
    "checkCycle": -1,
    "checkCycleUnit": "",
    "departmentId": "",
    "userId": "",
    "riskObjectName": "",
    "riskUnitName": "",
    "riskEventName": ""
  };

  String _getCheckStatus(String checkStatus) {
    // 0正常 1存在隐患 2未排查 3其他
    switch (checkStatus) {
      case '0':
        return '正常';
        break;
      case '1':
        return '存在隐患';
        break;
      case '2':
        return '未排查';
        break;
      case '3':
        return '其他';
        break;
      default:
        return '';
    }
  }

  String _getCheckMeans(String checkMeans) {
    // 0_现场确认；1_拍照；2_热成像；3_震动
    switch (checkMeans) {
      case '0':
        return '现场确认';
        break;
      case '1':
        return '拍照';
        break;
      case '2':
        return '热成像';
        break;
      case '3':
        return '震动';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('隐患排查记录详情', style: TextStyle(fontSize: size.width * 32)),
        child: Container(
          color: Color(0xffF8FAFF),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 32, size.width * 32,
                    size.width * 32, size.width * 20),
                margin: EdgeInsets.fromLTRB(size.width * 32, size.width * 32,
                    size.width * 32, size.width * 0),
                decoration: BoxDecoration(
                  color: Color(0xff2276FC),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.width * 20),
                      bottomLeft: Radius.circular(size.width * 20),
                      bottomRight: Radius.circular(size.width * 20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '风险分析对象：${data['riskObjectName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险分析单元：${data['riskUnitName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险事件：${data['riskEventName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '管控措施：${data['riskMeasureDesc']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '隐患排查任务：${data['troubleshootContent']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '管控手段：${_getCheckMeans(data['checkMeans'])}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '巡检周期：${data['checkCycle']}/${data['checkCycleUnit']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 32, vertical: size.width * 46),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.width * 28,
                      width: size.width * 28,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 50)),
                          border: Border.all(
                              width: size.width * 6, color: Color(0xff5FD5EC))),
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(data['checkTime'])
                              .toString()
                              .substring(0, 19),
                          style: TextStyle(
                              color: Color(0xff7F8A9C),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Container(
                          width: size.width * 638,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff7F8A9C).withOpacity(0.05),
                                  spreadRadius: size.width * 2,
                                  blurRadius: size.width * 8)
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(size.width * 20),
                                bottomLeft: Radius.circular(size.width * 20),
                                bottomRight: Radius.circular(size.width * 20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 32,
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
                                      topRight:
                                          Radius.circular(size.width * 20)),
                                ),
                                child: Text(
                                  '排查情况',
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    size.width * 32,
                                    size.width * 16,
                                    size.width * 32,
                                    size.width * 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 285,
                                          child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: size.width * 24,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: '排查结果：',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff333333))),
                                                  TextSpan(
                                                      text: _getCheckStatus(
                                                          data['checkStatus']),
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff7F8A9C))),
                                                ]),
                                          ),
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
                                                        color:
                                                            Color(0xff333333))),
                                                TextSpan(
                                                    text: data['checkUser'],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7F8A9C))),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.width * 16,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 285,
                                          child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: size.width * 24,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: '所在部门：',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff333333))),
                                                  TextSpan(
                                                      text: data[
                                                          'checkDepartment'],
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff7F8A9C))),
                                                ]),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: size.width * 24,
                                                  fontWeight: FontWeight.w400),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: 'GPS：',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333))),
                                                TextSpan(
                                                    text:
                                                        data['checkUser'] == ''
                                                            ? ''
                                                            : '在管控范围内',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7F8A9C))),
                                              ]),
                                        ),
                                      ],
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
                                                text: '排查人意见：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data['checkOpinion'],
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: size.width * 16,
                                    ),
                                    data['checkUrl'] != ''
                                        ? Container(
                                            height: size.width * 320,
                                            width: size.width * 574,
                                            decoration: BoxDecoration(
                                              color: Color(0xffEDF0F6),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 20)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    data['checkUrl']
                                                                .toString()
                                                                .split('|')[0]
                                                                .toString()
                                                                .indexOf(
                                                                    'http:') >
                                                            -1
                                                        ? data['checkUrl']
                                                            .toString()
                                                            .split('|')[0]
                                                        : Interface.fileUrl +
                                                            data['checkUrl']
                                                                .toString()
                                                                .split('|')[0],
                                                  ),
                                                  fit: BoxFit.contain),
                                            ),
                                          )
                                        : Container(
                                            height: size.width * 320,
                                            width: size.width * 574,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 20)),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '暂无图片',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 32),
                                            ),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.width * 40,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
