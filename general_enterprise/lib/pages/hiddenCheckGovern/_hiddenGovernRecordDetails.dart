import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class HiddenGovernRecordDetails extends StatefulWidget {
  HiddenGovernRecordDetails({this.id, this.type});
  final String id;
  final String type;
  @override
  State<HiddenGovernRecordDetails> createState() =>
      _HiddenGovernRecordDetailsState();
}

class _HiddenGovernRecordDetailsState extends State<HiddenGovernRecordDetails> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    print(widget.id);
    if (widget.type == '排查') {
      myDio.request(
          type: 'get',
          url: Interface.getcheckHiddenDangereBookById,
          queryParameters: {'id': widget.id}).then((value) {
        if (value is Map) {
          data = value;
        }
        if (mounted) {
          setState(() {});
        }
      });
    } else if (widget.type == '上报') {
      myDio.request(
          type: 'get',
          url: Interface.getreportHiddenDangereBookById,
          queryParameters: {'id': widget.id}).then((value) {
        if (value is Map) {
          data = value;
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  Map data = {};

  String _getDangerSrc(String dangerSrc) {
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

  String _getHazardDangerType(String hazardDangerType) {
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
        title: Text('隐患治理记录详情', style: TextStyle(fontSize: size.width * 32)),
        child: Container(
            color: Color(0xffF8FAFF),
            child: data.isNotEmpty && data != {}
                ? ListView(children: [
                    widget.type == '排查'
                        ? Container(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 32,
                                size.width * 32,
                                size.width * 32,
                                size.width * 20),
                            margin: EdgeInsets.fromLTRB(
                                size.width * 32,
                                size.width * 32,
                                size.width * 32,
                                size.width * 0),
                            decoration: BoxDecoration(
                              color: Color(0xff2276FC),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(size.width * 20),
                                  bottomLeft: Radius.circular(size.width * 20),
                                  bottomRight:
                                      Radius.circular(size.width * 20)),
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
                          )
                        : Container(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 32,
                                size.width * 32,
                                size.width * 32,
                                size.width * 20),
                            margin: EdgeInsets.fromLTRB(
                                size.width * 32,
                                size.width * 32,
                                size.width * 32,
                                size.width * 0),
                            decoration: BoxDecoration(
                              color: Color(0xff2276FC),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(size.width * 20),
                                  bottomLeft: Radius.circular(size.width * 20),
                                  bottomRight:
                                      Radius.circular(size.width * 20)),
                            ),
                            child: Text(
                              '风险分析对象：${data['riskObjectName']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 32,
                          size.width * 40, size.width * 32, size.width * 20),
                      child: Column(
                        children: [
                          // 隐患排查/隐患上报
                          data['checkTime'] != null && data['checkTime'] != ''
                              ? widget.type == '排查'
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: size.width * 28,
                                          width: size.width * 28,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 50)),
                                              border: Border.all(
                                                  width: size.width * 6,
                                                  color: Color(0xff5FD5EC))),
                                        ),
                                        SizedBox(
                                          width: size.width * 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '隐患排查  ${DateTime.fromMillisecondsSinceEpoch(data['checkTime']).toString().substring(0, 19)}',
                                                  style: TextStyle(
                                                      color: Color(0xff7F8A9C),
                                                      fontSize: size.width * 28,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                    topRight: Radius.circular(
                                                        size.width * 20),
                                                    bottomLeft: Radius.circular(
                                                        size.width * 20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            size.width * 20)),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.width * 32,
                                                            vertical:
                                                                size.width *
                                                                    16),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          Color(0xff2276FC)
                                                              .withOpacity(
                                                                  0.12),
                                                          Colors.transparent,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      size.width *
                                                                          20)),
                                                    ),
                                                    child: Text(
                                                      // '排查结果是否异常0否1是',
                                                      '排查结果：${data['isAbnormal'] == 0 ? '正常' : '存在隐患'}',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff333333),
                                                          fontSize:
                                                              size.width * 28,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            size.width * 32,
                                                            size.width * 16,
                                                            size.width * 32,
                                                            size.width * 32),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      285,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400),
                                                                    children: <
                                                                        InlineSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              '排查人：',
                                                                          style:
                                                                              TextStyle(color: Color(0xff333333))),
                                                                      TextSpan(
                                                                          text: data[
                                                                              'checkUser'],
                                                                          style:
                                                                              TextStyle(color: Color(0xff7F8A9C))),
                                                                    ]),
                                                              ),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          size.width *
                                                                              24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                  children: <
                                                                      InlineSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'GPS：',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xff333333))),
                                                                    TextSpan(
                                                                        text: data['checkUser'] ==
                                                                                ''
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
                                                          height:
                                                              size.width * 16,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              children: <
                                                                  InlineSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '隐患描述：',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff333333))),
                                                                TextSpan(
                                                                    text: data[
                                                                        'dangerDesc'],
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff7F8A9C))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              size.width * 16,
                                                        ),
                                                        data['checkUrl'] != ''
                                                            ? Container(
                                                                height:
                                                                    size.width *
                                                                        320,
                                                                width:
                                                                    size.width *
                                                                        574,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xffEDF0F6),
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          size.width *
                                                                              20)),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                        data['checkUrl'].toString().split('|')[0].toString().indexOf('http:') >
                                                                                -1
                                                                            ? Interface.fileUrl +
                                                                                data['checkUrl'].toString().split('|')[0]
                                                                            : data['checkUrl'].toString().split('|')[0],
                                                                      ),
                                                                      fit: BoxFit.contain),
                                                                ),
                                                              )
                                                            : Container(
                                                                height:
                                                                    size.width *
                                                                        320,
                                                                width:
                                                                    size.width *
                                                                        574,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          size.width *
                                                                              20)),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  '暂无图片',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          size.width *
                                                                              32),
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
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: size.width * 28,
                                          width: size.width * 28,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 50)),
                                              border: Border.all(
                                                  width: size.width * 6,
                                                  color: Color(0xff5FD5EC))),
                                        ),
                                        SizedBox(
                                          width: size.width * 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '隐患上报  ${DateTime.fromMillisecondsSinceEpoch(data['checkTime']).toString().substring(0, 19)}',
                                                  style: TextStyle(
                                                      color: Color(0xff7F8A9C),
                                                      fontSize: size.width * 28,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                    topRight: Radius.circular(
                                                        size.width * 20),
                                                    bottomLeft: Radius.circular(
                                                        size.width * 20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            size.width * 20)),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.width * 32,
                                                            vertical:
                                                                size.width *
                                                                    16),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          Color(0xff2276FC)
                                                              .withOpacity(
                                                                  0.12),
                                                          Colors.transparent,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      size.width *
                                                                          20)),
                                                    ),
                                                    child: Text(
                                                      // '排查结果是否异常0否1是',
                                                      '上报结果：${data['isAbnormal'] == 0 ? '正常' : '存在隐患'}',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff333333),
                                                          fontSize:
                                                              size.width * 28,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            size.width * 32,
                                                            size.width * 16,
                                                            size.width * 32,
                                                            size.width * 32),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              children: <
                                                                  InlineSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '上报人：',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff333333))),
                                                                TextSpan(
                                                                    text: data[
                                                                        'checkUser'],
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff7F8A9C))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              size.width * 16,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              children: <
                                                                  InlineSpan>[
                                                                TextSpan(
                                                                    text: '地点：',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff333333))),
                                                                TextSpan(
                                                                    text: data[
                                                                        'address'],
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff7F8A9C))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              size.width * 16,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              children: <
                                                                  InlineSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '隐患描述：',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff333333))),
                                                                TextSpan(
                                                                    text: data[
                                                                        'dangerDesc'],
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff7F8A9C))),
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              size.width * 16,
                                                        ),
                                                        data['checkUrl'] != ''
                                                            ? Container(
                                                                height:
                                                                    size.width *
                                                                        320,
                                                                width:
                                                                    size.width *
                                                                        574,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xffEDF0F6),
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          size.width *
                                                                              20)),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                        data['checkUrl'].toString().split('|')[0].toString().indexOf('http:') >
                                                                                -1
                                                                            ? Interface.fileUrl +
                                                                                data['checkUrl'].toString().split('|')[0]
                                                                            : data['checkUrl'].toString().split('|')[0],
                                                                      ),
                                                                      fit: BoxFit.contain),
                                                                ),
                                                              )
                                                            : Container(
                                                                height:
                                                                    size.width *
                                                                        320,
                                                                width:
                                                                    size.width *
                                                                        574,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          size.width *
                                                                              20)),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  '暂无图片',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          size.width *
                                                                              32),
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
                                    )
                              : Container(),
                          // 是否有隐患0否1是
                          data['registTime'] != null && data['registTime'] != ''
                              ? data['isHiddenDangere'] == 1
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Container(
                                            height: size.width * 28,
                                            width: size.width * 28,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 50)),
                                                border: Border.all(
                                                    width: size.width * 6,
                                                    color: Color(0xff5FD5EC))),
                                          ),
                                          SizedBox(
                                            width: size.width * 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '隐患确认  ${DateTime.fromMillisecondsSinceEpoch(data['registTime']).toString().substring(0, 19)}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7F8A9C),
                                                        fontSize:
                                                            size.width * 28,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                  borderRadius: BorderRadius
                                                      .only(
                                                          topRight: Radius
                                                              .circular(
                                                                  size.width *
                                                                      20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  size.width *
                                                                      20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  size.width *
                                                                      20)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                      .width *
                                                                  32,
                                                              vertical:
                                                                  size.width *
                                                                      16),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            Color(0xff2276FC)
                                                                .withOpacity(
                                                                    0.12),
                                                            Colors.transparent,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        size.width *
                                                                            20)),
                                                      ),
                                                      child: Text(
                                                        '隐患等级：${data['dangerLevel'] == '0' ? '一般隐患' : '重大隐患'}',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff333333),
                                                            fontSize:
                                                                size.width * 28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              size.width * 32,
                                                              size.width * 16,
                                                              size.width * 32,
                                                              size.width * 32),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        285,
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                      style: TextStyle(
                                                                          fontSize: size.width *
                                                                              24,
                                                                          fontWeight: FontWeight
                                                                              .w400),
                                                                      children: <
                                                                          InlineSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                '确认人：',
                                                                            style:
                                                                                TextStyle(color: Color(0xff333333))),
                                                                        TextSpan(
                                                                            text:
                                                                                data['registrant'],
                                                                            style: TextStyle(color: Color(0xff7F8A9C))),
                                                                      ]),
                                                                ),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400),
                                                                    children: <
                                                                        InlineSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              '隐患名称：',
                                                                          style:
                                                                              TextStyle(color: Color(0xff333333))),
                                                                      TextSpan(
                                                                          text: data[
                                                                              'dangerName'],
                                                                          style:
                                                                              TextStyle(color: Color(0xff7F8A9C))),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        285,
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                      style: TextStyle(
                                                                          fontSize: size.width *
                                                                              24,
                                                                          fontWeight: FontWeight
                                                                              .w400),
                                                                      children: <
                                                                          InlineSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                '隐患来源：',
                                                                            style:
                                                                                TextStyle(color: Color(0xff333333))),
                                                                        TextSpan(
                                                                            text:
                                                                                _getDangerSrc(data['dangerSrc']),
                                                                            style: TextStyle(color: Color(0xff7F8A9C))),
                                                                      ]),
                                                                ),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400),
                                                                    children: <
                                                                        InlineSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              '隐患类型：',
                                                                          style:
                                                                              TextStyle(color: Color(0xff333333))),
                                                                      TextSpan(
                                                                          text: _getHazardDangerType(data[
                                                                              'hazardDangerType']),
                                                                          style:
                                                                              TextStyle(color: Color(0xff7F8A9C))),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '隐患描述：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: data[
                                                                          'dangerDesc'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '原因分析：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: data['dangerReason'] ==
                                                                              ''
                                                                          ? '无'
                                                                          : data[
                                                                              'dangerReason'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '控制措施：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: data['controlMeasures'] ==
                                                                              ''
                                                                          ? '无'
                                                                          : data[
                                                                              'controlMeasures'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        285,
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                      style: TextStyle(
                                                                          fontSize: size.width *
                                                                              24,
                                                                          fontWeight: FontWeight
                                                                              .w400),
                                                                      children: <
                                                                          InlineSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                '资金：',
                                                                            style:
                                                                                TextStyle(color: Color(0xff333333))),
                                                                        TextSpan(
                                                                            text:
                                                                                '${data['cost']} 万元',
                                                                            style:
                                                                                TextStyle(color: Color(0xff7F8A9C))),
                                                                      ]),
                                                                ),
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400),
                                                                    children: <
                                                                        InlineSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              '整改责任人：',
                                                                          style:
                                                                              TextStyle(color: Color(0xff333333))),
                                                                      TextSpan(
                                                                          text: data[
                                                                              'liablePerson'],
                                                                          style:
                                                                              TextStyle(color: Color(0xff7F8A9C))),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '隐患治理期限：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: DateTime.fromMillisecondsSinceEpoch(data[
                                                                              'dangerManageDeadline'])
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              19),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '验收人姓名：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: data[
                                                                          'checkAcceptPerson'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
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
                                          )
                                        ])
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Container(
                                            height: size.width * 28,
                                            width: size.width * 28,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 50)),
                                                border: Border.all(
                                                    width: size.width * 6,
                                                    color: Color(0xff5FD5EC))),
                                          ),
                                          SizedBox(
                                            width: size.width * 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '隐患确认  ${DateTime.fromMillisecondsSinceEpoch(data['registTime']).toString().substring(0, 19)}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7F8A9C),
                                                        fontSize:
                                                            size.width * 28,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                  borderRadius: BorderRadius
                                                      .only(
                                                          topRight: Radius
                                                              .circular(
                                                                  size.width *
                                                                      20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  size.width *
                                                                      20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  size.width *
                                                                      20)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                      .width *
                                                                  32,
                                                              vertical:
                                                                  size.width *
                                                                      16),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            Color(0xff2276FC)
                                                                .withOpacity(
                                                                    0.12),
                                                            Colors.transparent,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        size.width *
                                                                            20)),
                                                      ),
                                                      child: Text(
                                                        '隐患确认结果：已驳回',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff333333),
                                                            fontSize:
                                                                size.width * 28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              size.width * 32,
                                                              size.width * 16,
                                                              size.width * 32,
                                                              size.width * 32),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '确认人：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: data[
                                                                          'registrant'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          '驳回意见：',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff333333))),
                                                                  TextSpan(
                                                                      text: data['registOpinion'] ==
                                                                              ''
                                                                          ? '无'
                                                                          : data[
                                                                              'registOpinion'],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xff7F8A9C))),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 16,
                                                          ),
                                                          data['registUrl'] !=
                                                                  ''
                                                              ? Container(
                                                                  height:
                                                                      size.width *
                                                                          320,
                                                                  width:
                                                                      size.width *
                                                                          574,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffEDF0F6),
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(size.width *
                                                                            20)),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          data['registUrl'].toString().split('|')[0].toString().indexOf('http:') > -1
                                                                              ? Interface.fileUrl + data['registUrl'].toString().split('|')[0]
                                                                              : data['registUrl'].toString().split('|')[0],
                                                                        ),
                                                                        fit: BoxFit.contain),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height:
                                                                      size.width *
                                                                          320,
                                                                  width:
                                                                      size.width *
                                                                          574,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(size.width *
                                                                            20)),
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '暂无图片',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            size.width *
                                                                                32),
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
                                        ])
                              : Container(),
                          // 隐患整改
                          data['liableCompletedTime'] != null &&
                                  data['liableCompletedTime'] != ''
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Container(
                                        height: size.width * 28,
                                        width: size.width * 28,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 50)),
                                            border: Border.all(
                                                width: size.width * 6,
                                                color: Color(0xff5FD5EC))),
                                      ),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '隐患整改  ${DateTime.fromMillisecondsSinceEpoch(data['liableCompletedTime']).toString().substring(0, 19)}',
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C),
                                                    fontSize: size.width * 28,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                                  topRight: Radius.circular(
                                                      size.width * 20),
                                                  bottomLeft: Radius.circular(
                                                      size.width * 20),
                                                  bottomRight: Radius.circular(
                                                      size.width * 20)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 32,
                                                      vertical:
                                                          size.width * 16),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xff2276FC)
                                                            .withOpacity(0.12),
                                                        Colors.transparent,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    size.width *
                                                                        20)),
                                                  ),
                                                  child: Text(
                                                    '整改责任人：${data['liablePerson']}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize:
                                                            size.width * 28,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      size.width * 32,
                                                      size.width * 16,
                                                      size.width * 32,
                                                      size.width * 32),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            children: <
                                                                InlineSpan>[
                                                              TextSpan(
                                                                  text: '整改意见：',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff333333))),
                                                              TextSpan(
                                                                  text: data[
                                                                      'liableOpinion'],
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff7F8A9C))),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: size.width * 16,
                                                      ),
                                                      data['liableUrl'] != ''
                                                          ? Container(
                                                              height:
                                                                  size.width *
                                                                      320,
                                                              width:
                                                                  size.width *
                                                                      574,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xffEDF0F6),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        size.width *
                                                                            20)),
                                                                image:
                                                                    DecorationImage(
                                                                        image:
                                                                            NetworkImage(
                                                                          data['liableUrl'].toString().indexOf('http:') > -1
                                                                              ? Interface.fileUrl + data['liableUrl']
                                                                              : data['liableUrl'],
                                                                        ),
                                                                        fit: BoxFit
                                                                            .contain),
                                                              ),
                                                            )
                                                          : Container(
                                                              height:
                                                                  size.width *
                                                                      320,
                                                              width:
                                                                  size.width *
                                                                      574,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        size.width *
                                                                            20)),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                '暂无图片',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        size.width *
                                                                            32),
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
                                    ])
                              : Container(),
                          // 整改完成审批
                          data['checkAcceptTime'] != null &&
                                  data['checkAcceptTime'] != ''
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Container(
                                        height: size.width * 28,
                                        width: size.width * 28,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 50)),
                                            border: Border.all(
                                                width: size.width * 6,
                                                color: Color(0xff5FD5EC))),
                                      ),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '整改完成审批  ${DateTime.fromMillisecondsSinceEpoch(data['checkAcceptTime']).toString().substring(0, 19)}',
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C),
                                                    fontSize: size.width * 28,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                                  topRight: Radius.circular(
                                                      size.width * 20),
                                                  bottomLeft: Radius.circular(
                                                      size.width * 20),
                                                  bottomRight: Radius.circular(
                                                      size.width * 20)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 32,
                                                      vertical:
                                                          size.width * 16),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xff2276FC)
                                                            .withOpacity(0.12),
                                                        Colors.transparent,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    size.width *
                                                                        20)),
                                                  ),
                                                  child: Text(
                                                    '验收人姓名：${data['checkAcceptPerson']}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize:
                                                            size.width * 28,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      size.width * 32,
                                                      size.width * 16,
                                                      size.width * 32,
                                                      size.width * 32),
                                                  child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        children: <InlineSpan>[
                                                          TextSpan(
                                                              text: '验收情况：',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff333333))),
                                                          TextSpan(
                                                              text: data[
                                                                  'checkAcceptComment'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff7F8A9C))),
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
                                      )
                                    ])
                              : Container()
                        ],
                      ),
                    )
                  ])
                : Container()));
  }
}
