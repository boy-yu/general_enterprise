import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class HiddenCheckRecordDetails extends StatefulWidget {
  @override
  State<HiddenCheckRecordDetails> createState() => _HiddenCheckRecordDetailsState();
}

class _HiddenCheckRecordDetailsState extends State<HiddenCheckRecordDetails> {
  Map titleData = {
    'riskObjectName': '风险分析对象名称风险分析对象名称',
    'riskUnitName': '风险分析单元名称风险分析单元名称风险分析单元名称',
    'riskEventName': '风险事件名称风险事件名称风险事件名称',
    'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
    'initialRiskLevel': '3',      // 初始风险等级：1_重大2_较大3_一般4_低
    'currentRiskLevel': '2',
    'riskMeasureDesc': '管控措施描述管控措施描述管控措施描述管控措施描述管控措施描述',
    'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容隐患排查内容',
    'checkMeans': '0',     // 排查手段0_现场确认；1_拍照；2_热成像；3_震动
  };

  String _getLevel(String level){
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
      'time': '2022-05-12 13:12',
      'checkData': '上报人员数据上报人员数据上报人员数据上报人员数据上报人员数据',
      'checkResult': '正常',
      'checkUser': '上报人员名字',
      'checkDepartment': '上报人工位',
      'gps': '在管控范围内',
      'checkOpinion': '上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见',
      'checkUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'time': '2022-05-12 13:12',
      'checkData': '上报人员数据上报人员数据上报人员数据上报人员数据上报人员数据',
      'checkResult': '正常',
      'checkUser': '上报人员名字',
      'checkDepartment': '上报人工位',
      'gps': '在管控范围内',
      'checkOpinion': '上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见',
      'checkUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'time': '2022-05-12 13:12',
      'checkData': '上报人员数据上报人员数据上报人员数据上报人员数据上报人员数据',
      'checkResult': '正常',
      'checkUser': '上报人员名字',
      'checkDepartment': '上报人工位',
      'gps': '在管控范围内',
      'checkOpinion': '上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见',
      'checkUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'time': '2022-05-12 13:12',
      'checkData': '上报人员数据上报人员数据上报人员数据上报人员数据上报人员数据',
      'checkResult': '正常',
      'checkUser': '上报人员名字',
      'checkDepartment': '上报人工位',
      'gps': '在管控范围内',
      'checkOpinion': '上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见',
      'checkUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
    {
      'time': '2022-05-12 13:12',
      'checkData': '上报人员数据上报人员数据上报人员数据上报人员数据上报人员数据',
      'checkResult': '正常',
      'checkUser': '上报人员名字',
      'checkDepartment': '上报人工位',
      'gps': '在管控范围内',
      'checkOpinion': '上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见上报人意见',
      'checkUrl': 'assets/images/doubleRiskProjeck/bg_home_my.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('隐患排查记录详情', style: TextStyle(fontSize: size.width * 32)),
      child: Container(
        color: Color(0xffF8FAFF),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(size.width * 32, size.width * 32, size.width * 32, size.width * 20),
              margin: EdgeInsets.fromLTRB(size.width * 32, size.width * 32, size.width * 32, size.width * 0),
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
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '风险分析单元：${titleData['riskUnitName']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '风险事件：${titleData['riskEventName']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '风险描述：${titleData['riskDescription']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '初始风险等级：${_getLevel(titleData['initialRiskLevel']) }',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '剩余风险等级：${_getLevel(titleData['currentRiskLevel'])}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '管控措施：${titleData['riskMeasureDesc']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '隐患排查内容：${titleData['troubleshootContent']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: size.width * 16,
                  ),
                  Text(
                    '管控手段：${titleData['checkMeans'] == 0 ? '现场确认' : '拍照'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.fromLTRB(size.width * 32, size.width * 40, size.width * 32, size.width * 20),
              shrinkWrap: true, 								//解决无限高度问题
		          physics: new NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index){
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.width * 28,
                      width: size.width * 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 50)),
                        border: Border.all(width: size.width * 6, color: Color(0xff5FD5EC)) 
                      ),
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index]['time'],
                          style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w400
                          ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: size.width * 32, vertical: size.width * 16),
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
                                  '排查情况',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(size.width * 32, size.width * 16, size.width * 32, size.width * 32),
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
                                                      text: '排查结果：',
                                                      style: TextStyle(
                                                          color: Color(0xff333333))),
                                                  TextSpan(
                                                      text: '正常',
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
                                                    text: '排查人：',
                                                    style: TextStyle(
                                                        color: Color(0xff333333))),
                                                TextSpan(
                                                    text: data[index]['checkUser'],
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
                                                      text: '所在部门：',
                                                      style: TextStyle(
                                                          color: Color(0xff333333))),
                                                  TextSpan(
                                                      text: data[index]['checkDepartment'],
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
                                                    text: 'GPS：',
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
                                                    text: '排查人意见：',
                                                    style: TextStyle(
                                                        color: Color(0xff333333))),
                                                TextSpan(
                                                    text: data[index]['checkOpinion'],
                                                    style: TextStyle(
                                                        color: Color(0xff7F8A9C))),
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
                                        borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
                                        image: DecorationImage(
                                          image: AssetImage(data[index]['checkUrl']),  
                                          fit: BoxFit.fill
                                        ),
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
                );
              }
            )
          ],
        ),
      )
    );
  }
}