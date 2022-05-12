import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/myDialog/hiddenDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReformFinish extends StatefulWidget {
  ReformFinish({this.id});
  final String id;
  @override
  State<ReformFinish> createState() => _ReformFinishState();
}

class _ReformFinishState extends State<ReformFinish> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map data = {};

  _getData() {
    myDio.request(
        type: 'get',
        url: Interface.getRiskHiddenDangereBook,
        queryParameters: {'id': widget.id}).then((value) {
      if (value is Map) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
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
        margin: EdgeInsets.only(bottom: size.width * 74, top: size.width * 80),
        child: SingleChildScrollView(
            child: data != {} && data.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Row(
                          children: [
                            Container(
                              height: size.width * 40,
                              width: size.width * 8,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF943D),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(size.width * 24))),
                            ),
                            SizedBox(
                              width: size.width * 32,
                            ),
                            Text(
                              '隐患描述：',
                              style: TextStyle(
                                  color: Color(0xff343434),
                                  fontSize: size.width * 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 16,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: size.width * 40),
                          padding: EdgeInsets.all(size.width * 16),
                          height: size.width * 272,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['dangerDesc'].toString(),
                                style: TextStyle(
                                  color: Color(0xff343434),
                                  fontSize: size.width * 26,
                                ),
                              ),
                              SizedBox(
                                height: size.width * 16,
                              ),
                              Container(
                                height: size.width * 144,
                                child: data['checkUrl'] != ''
                                    ? Wrap(
                                        children: data['checkUrl']
                                            .split('|')
                                            .map<Widget>((ele) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: size.width * 10),
                                          child:
                                              ele.toString().indexOf('http') >
                                                      -1
                                                  ? Image.network(
                                                      ele,
                                                      width: size.width * 167,
                                                      height: size.width * 125,
                                                    )
                                                  : Container(),
                                        );
                                      }).toList())
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.width * 40,
                        ),
                        GestureDetector(
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                FocusManager.instance.primaryFocus.unfocus();
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: size.width * 40,
                                      width: size.width * 8,
                                      decoration: BoxDecoration(
                                          color: Color(0xffFF943D),
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(
                                                  size.width * 24))),
                                    ),
                                    SizedBox(
                                      width: size.width * 32,
                                    ),
                                    Text(
                                      '五定措施:',
                                      style: TextStyle(
                                          color: Color(0xff343434),
                                          fontSize: size.width * 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 16),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: size.width * 16),
                                          child: Text(
                                            data['dangerName'],
                                            style: TextStyle(
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff333333)),
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '隐患等级',
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: size.width * 28,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            size.width * 8))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 16),
                                                child: Text(
                                                  data['dangerLevel'] == '0'
                                                      ? '一般隐患'
                                                      : '重大隐患',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: size.width * 28,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '隐患类型',
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: size.width * 28,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            size.width * 8))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 16),
                                                child: Text(
                                                  _getHazardDangerType(
                                                      data['hazardDangerType']),
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: size.width * 28,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 16),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: size.width * 16),
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 16),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: size.width * 16),
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 16),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: size.width * 16),
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 16),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: size.width * 16),
                                          child: Text(
                                            data['controlMeasures'],
                                            style: TextStyle(
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff333333)),
                                          )),
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
                                          height: size.width * 75,
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 16),
                                          child: Row(
                                            children: [
                                              Text(
                                                data['cost'],
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: size.width * 28,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Spacer(),
                                              Text(
                                                '万元',
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: size.width * 28,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )),
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.width * 16),
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      size.width * 8))),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: size.width * 16),
                                          child: Text(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    data[
                                                        'dangerManageDeadline'])
                                                .toString()
                                                .substring(0, 19),
                                            style: TextStyle(
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff333333)),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 50, right: size.width * 50),
                          child: GestureDetector(
                            onTap: () {
                              HiddenDialog.myHiddenDialog(
                                context,
                                '整改完毕信息',
                                true,
                                '整改意见',
                                (submitData) {
                                  myDio.request(
                                      type: 'post',
                                      url: Interface
                                          .postRectificationHiddenDanger,
                                      data: {
                                        "id": widget.id,
                                        "liableOpinion": submitData['editStr'],
                                        "liableUrl": submitData['image'],
                                      }).then((value) {
                                    successToast('整改完成');
                                    Navigator.pop(context);
                                  });
                                },
                                counter: _counter,
                              );
                            },
                            child: Container(
                              height: size.width * 75,
                              // width: size.width * 505,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: size.width * 100,
                                  top: size.width * 50),
                              decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 8)),
                              ),
                              child: Text(
                                '整改完毕',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 36),
                              ),
                            ),
                          ),
                        )
                      ])
                : Container()));
  }
}
