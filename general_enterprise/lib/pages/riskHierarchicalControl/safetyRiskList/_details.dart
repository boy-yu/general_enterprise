import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details({this.id});
  final String id;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map data = {
    "troubleshootContent": "",
    "riskTemplateFiveList": [],
    "riskLevel": "",
    "riskEventName": "",
    "riskPossibility": -1,
    "initialRiskConsequences": -1,
    "initialRiskLevel": "",
    "riskDegree": -1,
    "hazardDep": "",
    "riskObjectName": "",
    "riskConsequences": -1,
    "riskMeasureDesc": "",
    "riskUnitName": "",
    "initialRiskPossibility": -1,
    "classify1": "",
    "hazardLiablePerson": "",
    "classify3": "",
    "classify2": "",
    "initialRiskDegree": -1,
    "dataSrc": ""
  };

  _getData() {
    myDio.request(
        type: 'get',
        url: Interface.getRiskTemplateFourById,
        queryParameters: {'id': widget.id}).then((value) {
      if (value is Map) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  String _getRiskLevel(String riskLevel) {
    switch (riskLevel) {
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

  Color _getColor(String riskLevel) {
    switch (riskLevel) {
      case '1':
        return Color(0xffF56271);
        break;
      case '2':
        return Color(0xffFF9900);
        break;
      case '3':
        return Color(0xffFFCA0E);
        break;
      case '4':
        return Color(0xff2276FC);
        break;
      default:
        return Colors.transparent;
    }
  }

  String _getClassify1(String classify1) {
    // 工程技术：1；维护保养：2；操作行为：3；应急措施：4
    switch (classify1) {
      case '1':
        return '工程技术';
        break;
      case '2':
        return '维护保养';
        break;
      case '3':
        return '操作行为';
        break;
      case '4':
        return '应急措施';
        break;
      default:
        return '';
    }
  }

  String _getClassify2(String classify2) {
    // 工艺控制:1-1；关键设备/部件：1-2；安全附件：1-3；安全仪表：1-4；其它：1-5；
    // 动设备：2-1；静设备：2-2；其它：2-3；
    // 人员资质：3-1；操作记录：3-2；交接班：3-3；其他：3-4；
    // 应急设施:4-1；个体防护：4-2；消防设施：4-3；应急预案：4-4；其它：4-5；
    switch (classify2) {
      case '1-1':
        return '工艺控制';
        break;
      case '1-2':
        return '关键设备/部件';
        break;
      case '1-3':
        return '安全附件';
        break;
      case '1-4':
        return '安全仪表';
        break;
      case '1-5':
        return '其它';
        break;
      case '2-1':
        return '动设备';
        break;
      case '2-2':
        return '静设备';
        break;
      case '2-3':
        return '其它';
        break;
      case '3-1':
        return '人员资质';
        break;
      case '3-2':
        return '操作记录';
        break;
      case '3-3':
        return '交接班';
        break;
      case '3-4':
        return '其他';
        break;
      case '4-1':
        return '应急设施';
        break;
      case '4-2':
        return '个体防护';
        break;
      case '4-3':
        return '消防设施';
        break;
      case '4-4':
        return '应急预案';
        break;
      case '4-5':
        return '其它';
        break;
      default:
        return '';
    }
  }

  String _getCheckMeans(String checkMeans){
    //  0_现场确认；1_拍照；2_热成像；3_震动
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
        title: Text(
          '详情',
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: Container(
          color: Color(0xffF8FAFF),
          child: ListView(
            padding: EdgeInsets.all(size.width * 32),
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.width * 20),
                          bottomLeft: Radius.circular(size.width * 20),
                          bottomRight: Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff7F8A9C).withOpacity(0.05),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 8)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          '风险分析对象：${data['riskObjectName']}',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 270,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w400),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: '责任人：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: data['hazardLiablePerson'],
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
                                    ]),
                              ),
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
                                        text: '责任部门：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: data['hazardDep'],
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
                  )),
              SizedBox(
                height: size.width * 32,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff7F8A9C).withOpacity(0.05),
                          spreadRadius: size.width * 2,
                          blurRadius: size.width * 8)
                    ]),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 32, vertical: size.width * 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20)),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff2276FC).withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    '风险分析单元：${data['riskUnitName']}',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 32,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.width * 20),
                          bottomLeft: Radius.circular(size.width * 20),
                          bottomRight: Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff7F8A9C).withOpacity(0.05),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 8)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          '风险事件：${data['riskEventName']}',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 32,
                              vertical: size.width * 16),
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
                                          text: '风险描述：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: data['riskDescription'],
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
                                    ]),
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 270,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '初始后果：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data[
                                                        'initialRiskConsequences']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
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
                                              text: '剩余后果：',
                                              style: TextStyle(
                                                  color: Color(0xff333333))),
                                          TextSpan(
                                              text: data['riskConsequences']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color(0xff7F8A9C))),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: size.width * 16,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 270,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '初始可能性：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data[
                                                        'initialRiskPossibility']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
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
                                              text: '剩余可能性：',
                                              style: TextStyle(
                                                  color: Color(0xff333333))),
                                          TextSpan(
                                              text: data['riskPossibility']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color(0xff7F8A9C))),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: size.width * 16,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 270,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '初始风险度：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: data['initialRiskDegree']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
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
                                              text: '剩余风险度：',
                                              style: TextStyle(
                                                  color: Color(0xff333333))),
                                          TextSpan(
                                              text:
                                                  data['riskDegree'].toString(),
                                              style: TextStyle(
                                                  color: Color(0xff7F8A9C))),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: size.width * 16,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 270,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '初始风险等级：',
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: _getRiskLevel(
                                                    data['initialRiskLevel']),
                                                style: TextStyle(
                                                    color: _getColor(data[
                                                        'initialRiskLevel']))),
                                          ]),
                                    ),
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
                                              text: '剩余风险等级：',
                                              style: TextStyle(
                                                  color: Color(0xff333333))),
                                          TextSpan(
                                              text: _getRiskLevel(
                                                  data['riskLevel']),
                                              style: TextStyle(
                                                  color: _getColor(
                                                      data['riskLevel']))),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: size.width * 16,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                            ],
                          ))
                    ],
                  )),
              SizedBox(
                height: size.width * 32,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.width * 20),
                          bottomLeft: Radius.circular(size.width * 20),
                          bottomRight: Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff7F8A9C).withOpacity(0.05),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 8)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          '管控措施：${data['riskMeasureDesc']}',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 32,
                              vertical: size.width * 16),
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
                                          text: '管控方式：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: data['dataSrc'] == '1'
                                              ? '自动化监控'
                                              : '隐患排查',
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
                                          text: '管控措施分类1：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text:
                                              _getClassify1(data['classify1']),
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
                                          text: '管控措施分类2：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text:
                                              _getClassify2(data['classify2']),
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
                                          text: '管控措施分类3：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: data['classify3'],
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
                                          text: '隐患排查内容：',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                      TextSpan(
                                          text: data['troubleshootContent'],
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C))),
                                    ]),
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                            ],
                          ))
                    ],
                  )),
              SizedBox(
                height: size.width * 32,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.width * 20),
                          bottomLeft: Radius.circular(size.width * 20),
                          bottomRight: Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff7F8A9C).withOpacity(0.05),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 8)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          '隐患排查任务',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * 100,
                            padding: EdgeInsets.only(
                                top: size.width * 16, bottom: size.width * 24),
                            alignment: Alignment.center,
                            child: Text(
                              '序号',
                              style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: size.width * 250,
                            padding: EdgeInsets.only(
                                top: size.width * 16, bottom: size.width * 24),
                            alignment: Alignment.center,
                            child: Text(
                              '隐患排查任务',
                              style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: size.width * 160,
                            padding: EdgeInsets.only(
                                top: size.width * 16, bottom: size.width * 24),
                            alignment: Alignment.center,
                            child: Text(
                              '巡检周期',
                              style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: size.width * 160,
                            padding: EdgeInsets.only(
                                top: size.width * 16, bottom: size.width * 24),
                            alignment: Alignment.center,
                            child: Text(
                              '管控手段',
                              style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xffF2F2F2),
                        height: size.width * 2,
                      ),
                      ListView.builder(
                          itemCount: data['riskTemplateFiveList'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: size.width * 100,
                                      padding: EdgeInsets.only(
                                          top: size.width * 16,
                                          bottom: size.width * 24),
                                      alignment: Alignment.center,
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 250,
                                      padding: EdgeInsets.only(
                                          top: size.width * 16,
                                          bottom: size.width * 24),
                                      alignment: Alignment.center,
                                      child: Text(
                                        data['riskTemplateFiveList'][index]['troubleshootContent'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 160,
                                      padding: EdgeInsets.only(
                                          top: size.width * 16,
                                          bottom: size.width * 24),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${data['riskTemplateFiveList'][index]['checkCycle']}/${data['riskTemplateFiveList'][index]['checkCycleUnit']}',
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 160,
                                      padding: EdgeInsets.only(
                                          top: size.width * 16,
                                          bottom: size.width * 24),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _getCheckMeans(data['riskTemplateFiveList'][index]['checkMeans']),
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                index != data['riskTemplateFiveList'].length -1 ? Container(
                                  width: double.infinity,
                                  color: Color(0xffF2F2F2),
                                  height: size.width * 2,
                                ) : Container(),
                              ],
                            );
                          })
                    ],
                  )),
              SizedBox(
                height: size.width * 32,
              ),
            ],
          ),
        ));
  }
}
