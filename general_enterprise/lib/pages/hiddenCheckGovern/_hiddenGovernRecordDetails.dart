import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class HiddenGovernRecordDetails extends StatefulWidget {
  @override
  State<HiddenGovernRecordDetails> createState() =>
      _HiddenGovernRecordDetailsState();
}

class _HiddenGovernRecordDetailsState extends State<HiddenGovernRecordDetails> {
  Map titleData = {
    'riskObjectName': '风险分析对象名称风险分析对象名称',
    'riskUnitName': '风险分析单元名称风险分析单元名称风险分析单元名称',
    'riskEventName': '风险事件名称风险事件名称风险事件名称',
    'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
    'initialRiskLevel': '3', // 初始风险等级：1_重大2_较大3_一般4_低
    'currentRiskLevel': '2',
    'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
    'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
    'checkMeans': '0', // 排查手段0_现场确认；1_拍照；2_热成像；3_震动
  };

  String _getLevel(String level) {
    switch (level) {
      case '1':
        return '重大风险';
        break;
      case '2':
        return '较大风险';
        break;
      case '3':
        return '一般风险';
        break;
      case '4':
        return '低风险';
        break;
      default:
        return '';
    }
  }

  List data = [
    {
      'dangerState': '-1', // 隐患状态（隐患排查：-1；隐患确认：0；隐患整改：1；整改完成审批：9）
      'time': '2022-05-12 13:12',
      'isAbnormal': 0, // 排查结果是否异常 0否 1是
      'checkUser': '上报人员名字',
      'dangerDesc': '隐患描述隐患描述隐患描述隐患描述隐患描述',
      'checkUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '0', // 隐患状态（隐患排查：-1；隐患确认：0；隐患整改：1；整改完成审批：9）
      'time': '2022-05-12 13:12',
      'dangerLevel': '0', // 隐患等级（一般隐患：0；重大隐患：1）
      'registrant': '确认人员名字',
      'dangerName': '隐患名称',
      'dangerSrc':
          '5', // 隐患来源：日常排查：1；综合性排查：2；专业性排查：3；季节性排查：4；重点时段及节假日前排查:5；事故类比排查:6；复产复工前排查：7；外聘专家诊断式排查：8；管控措施失效：9；其他：10
      'hazardDangerType': '1', //隐患类型（安全：1，工艺：2，电气：3，仪表：4，消防：5，总图：6，设备：7，其他：8）
      'dangerDesc': '隐患描述隐患描述隐患描述隐患描述隐患描述隐患描述隐患描述',
      'dangerReason': '原因分析原因分析原因分析原因分析原因分析原因分析',
      'controlMeasures': '整改措施整改措施整改措施整改措施整改措施整改措施',
      'cost': '20',
      'liablePerson': '整改责任人',
      'dangerManageDeadline': '2022-05-12 13:12',
      'checkAcceptPerson': '整改确认人员'
    },
    {
      'dangerState': '1', // 隐患状态（隐患排查：-1；隐患确认：0；隐患整改：1；整改完成审批：9）
      'time': '2022-05-12 13:12',
      'liablePerson': '整改责任人',
      'liableOpinion': '整改描述整改描述整改描述整改描述整改描述整改描述',
      'liableUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'dangerState': '9', // 隐患状态（隐患排查：-1；隐患确认：0；隐患整改：1；整改完成审批：9）
      'time': '2022-05-12 13:12',
      'checkAcceptPerson': '整改确认人员',
      'checkAcceptComment': '整改确认情况信息整改确认情况信息整改确认情况信息整改确认情况信息'
    }
  ];

  String _getDangerSrc(String dangerSrc){
    // 隐患来源：日常排查：1；综合性排查：2；专业性排查：3；季节性排查：4；重点时段及节假日前排查:5；事故类比排查:6；复产复工前排查：7；外聘专家诊断式排查：8；管控措施失效：9；其他：10
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

  String _getHazardDangerType(String hazardDangerType){
    //隐患类型（安全：1，工艺：2，电气：3，仪表：4，消防：5，总图：6，设备：7，其他：8）
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

  Widget _getWidget(Map map) {
    // 隐患状态（隐患排查：-1；隐患确认：0；隐患整改：1；整改完成审批：9）
    switch (map['dangerState']) {
      case "-1":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '隐患排查  ${map['time']}',
                  style: TextStyle(
                      color: Color(0xff7F8A9C),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 20,
            ),
            Container(
              width: size.width * 638,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.width * 20),
                    bottomLeft: Radius.circular(size.width * 20),
                    bottomRight: Radius.circular(size.width * 20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 32, vertical: size.width * 16),
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
                          topRight: Radius.circular(size.width * 20)),
                    ),
                    child: Text(
                      '排查结果：${map['isAbnormal'] == 0 ? '正常' : '存在隐患'}',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 32,
                        size.width * 16, size.width * 32, size.width * 32),
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
                                        fontWeight: FontWeight.w400),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: '排查人：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: map['checkUser'],
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
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
                                        text: 'Gps：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: '在管控范围内',
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                    text: '隐患描述：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['dangerDesc'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
                              ]),
                        ),
                        SizedBox(
                          height: size.width * 16,
                        ),
                        Container(
                          height: size.width * 320,
                          width: size.width * 574,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 20)),
                            image: DecorationImage(
                                image: AssetImage(map['checkUrl']),
                                fit: BoxFit.fill),
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
        );
        break;
      case "0":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '隐患确认  ${map['time']}',
                  style: TextStyle(
                      color: Color(0xff7F8A9C),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 20,
            ),
            Container(
              width: size.width * 638,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.width * 20),
                    bottomLeft: Radius.circular(size.width * 20),
                    bottomRight: Radius.circular(size.width * 20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 32, vertical: size.width * 16),
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
                          topRight: Radius.circular(size.width * 20)),
                    ),
                    child: Text(
                      '隐患等级：${map['dangerLevel'] == '0' ? '一般隐患' : map['dangerLevel'] == '1' ? '重大隐患' : '无隐患'}',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 32,
                        size.width * 16, size.width * 32, size.width * 32),
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
                                        fontWeight: FontWeight.w400),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: '确认人：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: map['registrant'],
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
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
                                        text: '隐患名称：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: map['dangerName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                        fontWeight: FontWeight.w400),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: '隐患来源：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: _getDangerSrc(map['dangerSrc']),
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
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
                                        text: '隐患类型：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: _getHazardDangerType(map['hazardDangerType']),
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                    text: '隐患描述：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['dangerDesc'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
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
                                    text: '原因分析：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['dangerReason'] == '' ? '无' : map['dangerReason'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
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
                                    text: '控制措施：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['controlMeasures'] == '' ? '无' : map['controlMeasures'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
                              ]),
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
                                        fontWeight: FontWeight.w400),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: '资金：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: '${map['cost']} 万元',
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
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
                                        text: '整改责任人：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: map['liablePerson'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                    text: '隐患治理期限：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['dangerManageDeadline'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
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
                                    text: '验收人姓名：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['checkAcceptPerson'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
                              ]),
                        ),
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
        );
        break;
      case "1":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '隐患整改  ${map['time']}',
                  style: TextStyle(
                      color: Color(0xff7F8A9C),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 20,
            ),
            Container(
              width: size.width * 638,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.width * 20),
                    bottomLeft: Radius.circular(size.width * 20),
                    bottomRight: Radius.circular(size.width * 20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 32, vertical: size.width * 16),
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
                          topRight: Radius.circular(size.width * 20)),
                    ),
                    child: Text(
                      '整改责任人：${map['liablePerson']}',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 32,
                        size.width * 16, size.width * 32, size.width * 32),
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
                                    text: '整改意见：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['liableOpinion'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
                              ]),
                        ),
                        SizedBox(
                          height: size.width * 16,
                        ),
                        Container(
                          height: size.width * 320,
                          width: size.width * 574,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 20)),
                            image: DecorationImage(
                                image: AssetImage(map['liableUrl']),
                                fit: BoxFit.fill),
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
        );
        break;
      case "9":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '整改完成审批  ${map['time']}',
                  style: TextStyle(
                      color: Color(0xff7F8A9C),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 20,
            ),
            Container(
              width: size.width * 638,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.width * 20),
                    bottomLeft: Radius.circular(size.width * 20),
                    bottomRight: Radius.circular(size.width * 20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 32, vertical: size.width * 16),
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
                          topRight: Radius.circular(size.width * 20)),
                    ),
                    child: Text(
                      '验收人姓名：${map['checkAcceptPerson']}',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 32,
                        size.width * 16, size.width * 32, size.width * 32),
                    child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w400),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: '验收情况：',
                                    style: TextStyle(color: Color(0xff333333))),
                                TextSpan(
                                    text: map['checkAcceptComment'],
                                    style: TextStyle(color: Color(0xff7F8A9C))),
                              ]),
                        ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width * 40,
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('隐患治理记录详情', style: TextStyle(fontSize: size.width * 32)),
        child: Container(
            color: Color(0xffF8FAFF),
            child: ListView(children: [
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
                      '风险分析对象：${titleData['riskObjectName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险分析单元：${titleData['riskUnitName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险事件：${titleData['riskEventName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险描述：${titleData['riskDescription']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '初始风险等级：${_getLevel(titleData['initialRiskLevel'])}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '剩余风险等级：${_getLevel(titleData['currentRiskLevel'])}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '管控措施：${titleData['riskMeasureDesc']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '隐患排查内容：${titleData['troubleshootContent']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '管控手段：${titleData['checkMeans'] == 0 ? '现场确认' : '拍照'}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.fromLTRB(size.width * 32, size.width * 40,
                      size.width * 32, size.width * 20),
                  shrinkWrap: true, //解决无限高度问题
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Row(
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
                                  width: size.width * 6,
                                  color: Color(0xff5FD5EC))),
                        ),
                        SizedBox(
                          width: size.width * 20,
                        ),
                        _getWidget(data[index]),
                      ],
                    );
                  })
            ])));
  }
}
