import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/myDialog/hiddenDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReformFinish extends StatefulWidget {
  @override
  State<ReformFinish> createState() => _ReformFinishState();
}

class _ReformFinishState extends State<ReformFinish> {
  Map data = {
    'reportingOpinion': '隐患描述隐患描述隐患描述隐患描述隐患描述隐患描述隐患描述',
    'reportingUrl':
        'http://171.91.196.161:31010/2022-04-25/16508788624301650878859864.png',

    'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
    'dangerName': '这是隐患名称',
    'dangerSrc':
        '2', // 隐患来源：日常排查：1；综合性排查：2；专业性排查：3；季节性排查：4；重点时段及节假日前排查:5；事故类比排查:6；复产复工前排查：7；外聘专家诊断式排查：8；管控措施失效：9；其他：10
    'hazardDangerType': '4', // 隐患类型（安全：1，工艺：2，电气：3，仪表：4，消防：5，总图：6，设备：7，其他：8）
    'dangerDesc': '这是描述',
    'dangerReason': '这是原因这是原因这是原因这是原因',
    'controlMeasures': '这里是一段控制措施描述',
    'cost': '5000',
    'liablePerson': ['张鹏'],
    'dangerManageDeadline': '2022-04-20',
    'checkAcceptPerson': ['陈小伞']
  };

  @override
  void initState() {
    super.initState();
  }

  Counter _counter = Provider.of(myContext);

  String _getHazardDangerType(String hazardDangerType) {
    switch (hazardDangerType) {
      case '1':
        return '安全';
        break;
      case '2':
        return '工艺';
        break;
      case '3':
        return '电气';
        break;
      case '4':
        return '仪表';
        break;
      case '5':
        return '消防';
        break;
      case '6':
        return '总图';
        break;
      case '7':
        return '设备';
        break;
      case '8':
        return '其他';
        break;
      default:
        return '';
    }
  }

  String _getDangerSrc(String dangerSrc) {
    switch (dangerSrc) {
      case '1':
        return '日常排查';
        break;
      case '2':
        return '综合性排查';
        break;
      case '3':
        return '专业性排查';
        break;
      case '4':
        return '季节性排查';
        break;
      case '5':
        return '重点时段及节假日前排查';
        break;
      case '6':
        return '事故类比排查';
        break;
      case '7':
        return '复产复工前排查';
        break;
      case '8':
        return '外聘专家诊断式排查';
        break;
      case '9':
        return '管控措施失效';
        break;
      case '10':
        return '其他';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.only(bottom: size.width * 74, top: size.width * 35),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: size.width * 30, top: size.width * 10),
            child: Text(
              '隐患描述：',
              style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: size.width * 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 50,
                top: size.width * 10,
                right: size.width * 50),
            child: Text(
              data['reportingOpinion'].toString(),
              style: TextStyle(
                color: Color(0xff343434),
                fontSize: size.width * 26,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 30),
            height: size.width * 200,
            child: Wrap(
                children: data['reportingUrl'].split('|').map<Widget>((ele) {
              return Padding(
                padding: EdgeInsets.only(right: size.width * 10),
                child: ele.toString().indexOf('http') > -1
                    ? Image.network(
                        ele,
                        width: size.width * 167,
                        height: size.width * 125,
                      )
                    : Container(),
              );
            }).toList()),
          ),
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 655,
                    height: size.width * 1,
                    color: Color(0xffEFEFEF),
                    margin: EdgeInsets.symmetric(vertical: size.width * 10),
                  ),
                  Text(
                    '五定措施:',
                    style: TextStyle(
                        color: Color(0xff343434),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.width * 32,
                  ),
                  Text(
                    '隐患名称',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        data['dangerName'],
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '隐患等级',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                            height: size.width * 72,
                            width: size.width * 310,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 8))),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 16),
                            child: Text(
                              data['dangerLevel'] == '0' ? '一般隐患' : '重大隐患',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '隐患类型',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                            height: size.width * 72,
                            width: size.width * 310,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 8))),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 16),
                            child: Text(
                              _getHazardDangerType(data['hazardDangerType']),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '隐患来源',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        _getDangerSrc(data['dangerSrc']),
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                  Text(
                    '隐患描述',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        data['dangerDesc'],
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                  Text(
                    '原因分析',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        data['dangerReason'],
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                  Text(
                    '控制措施',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        data['controlMeasures'],
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '资金',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                              height: size.width * 72,
                              width: size.width * 310,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 8))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  Text(
                                    data['cost'],
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Text(
                                    '万元',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '整改负责人',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                            height: size.width * 72,
                            width: size.width * 310,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 8))),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 16),
                            child: Text(
                              data['liablePerson'].toString(),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '隐患治理期限',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        data['dangerManageDeadline'],
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                  Text(
                    '验收人',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      height: size.width * 75,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 16),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 16),
                      child: Text(
                        data['checkAcceptPerson'].toString(),
                        style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333)),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * 50, right: size.width * 50),
            child: GestureDetector(
              onTap: () {
                HiddenDialog.myHiddenDialog(
                  context,
                  '整改完毕信息',
                  true,
                  '整改意见',
                  (submitData) {
                    print(submitData);
                    Navigator.of(context).pop();
                  },
                  counter: _counter,
                );
              },
              child: Container(
                height: size.width * 75,
                // width: size.width * 505,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    bottom: size.width * 100, top: size.width * 50),
                decoration: BoxDecoration(
                  color: Color(0xff3074FF),
                  borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                ),
                child: Text(
                  '整改完毕',
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 36),
                ),
              ),
            ),
          )
        ])));
  }
}
