import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myDateSelect.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/common/mySearchPeople.dart';
import 'package:enterprise/pages/home/risk/_riskButton.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AffirmHidden extends StatefulWidget {
  @override
  State<AffirmHidden> createState() => _AffirmHiddenState();
}

class _AffirmHiddenState extends State<AffirmHidden> {
  int selectbgColor = 0xff0ABA08;
  int selecttextColor = 0xffffffff;
  bool isFull = true;
  TextEditingController _textEditingController = TextEditingController();
  Counter _counter = Provider.of(myContext);

  TextEditingController _controllerHiddenName = TextEditingController();
  TextEditingController _controllerDangerDesc = TextEditingController();
  TextEditingController _controllerDangerReason = TextEditingController();
  TextEditingController _controllerControlMeasures = TextEditingController();
  TextEditingController _controllerCost = TextEditingController();

  Map data = {'reportingOpinion': '隐患描述隐患描述隐患描述隐患描述隐患描述隐患描述隐患描述'};

  List<String> imageList = [
    'http://171.91.196.161:31010/2022-04-25/16508788624301650878859864.png'
  ];

  Map fiveMeasuresData = {
    'dangerLevel': '', // 隐患等级（一般隐患：0；重大隐患：1）
    'dangerName': '',
    'dangerSrc':
        '', // 隐患来源：日常排查：1；综合性排查：2；专业性排查：3；季节性排查：4；重点时段及节假日前排查:5；事故类比排查:6；复产复工前排查：7；外聘专家诊断式排查：8；管控措施失效：9；其他：10
    'hazardDangerType': '', // 隐患类型（安全：1，工艺：2，电气：3，仪表：4，消防：5，总图：6，设备：7，其他：8）
    'dangerDesc': '',
    'dangerReason': '',
    'controlMeasures': '',
    'cost': '',
    'liablePerson': [],
    'dangerManageDeadline': '',
    'checkAcceptPerson': []
  };

  List levelList = [
    {'id': '0', 'name': '一般隐患'},
    {'id': '1', 'name': '重大隐患'},
  ];

  List hazardDangerTypeList = [
    {'id': '1', 'name': '安全'},
    {'id': '2', 'name': '工艺'},
    {'id': '3', 'name': '电气'},
    {'id': '4', 'name': '仪表'},
    {'id': '5', 'name': '消防'},
    {'id': '6', 'name': '总图'},
    {'id': '7', 'name': '设备'},
    {'id': '8', 'name': '其他'},
  ];

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

  List dangerSrcList = [
    {'id': '1', 'name': '日常排查'},
    {'id': '2', 'name': '综合性排查'},
    {'id': '3', 'name': '专业性排查'},
    {'id': '4', 'name': '季节性排查'},
    {'id': '5', 'name': '重点时段及节假日前排查'},
    {'id': '6', 'name': '事故类比排查'},
    {'id': '7', 'name': '复产复工前排查'},
    {'id': '8', 'name': '外聘专家诊断式排查'},
    {'id': '9', 'name': '管控措施失效'},
    {'id': '10', 'name': '其他'},
  ];

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

  List liablePersonMsg = [];

  void _changeLiablePersonMsg(List<PeopleStructure> data, Counter _context) {
    liablePersonMsg = [];
    for (var i = 0; i < data.length; i++) {
      fiveMeasuresData['liablePerson'].add(data[i].id);
      liablePersonMsg.add(data[i].name);
    }
    if (mounted) {
      setState(() {});
    }
    Navigator.pop(context);
  }

  String _getLiablePerName() {
    String perName = '';
    for (int i = 0; i < liablePersonMsg.length; i++) {
      perName += liablePersonMsg[i] + '、';
    }
    return perName;
  }

  List acceptPersonMsg = [];

  void _changeAcceptPersonMsg(List<PeopleStructure> data, Counter _context) {
    acceptPersonMsg = [];
    for (var i = 0; i < data.length; i++) {
      fiveMeasuresData['checkAcceptPerson'].add(data[i].id);
      acceptPersonMsg.add(data[i].name);
    }
    if (mounted) {
      setState(() {});
    }
    Navigator.pop(context);
  }

  String _getAcceptPersonName() {
    String perName = '';
    for (int i = 0; i < acceptPersonMsg.length; i++) {
      perName += acceptPersonMsg[i] + '、';
    }
    return perName;
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: size.width * 60),
                child: RiskButtons(
                  text: "正常",
                  testcolor: isFull ? selecttextColor : 0xff9A9A9A,
                  bgcolor: isFull ? selectbgColor : 0xffFFFFFF,
                  callback: () {
                    isFull = !isFull;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
              RiskButtons(
                text: "隐患",
                testcolor: isFull ? 0xff9A9A9A : 0xffffffff,
                bgcolor: isFull ? 0xffFFFFFF : 0xffFF1818,
                callback: () {
                  isFull = !isFull;
                  if (mounted) {
                    setState(() {});
                  }
                },
              )
            ],
          ),
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: size.width * 10),
                    child: imageList[index].isNotEmpty
                        ? Image.network(
                            imageList[index],
                            width: size.width * 167,
                            height: size.width * 125,
                          )
                        : Container(),
                  );
                }),
          ),
          isFull
              // 正常
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width * 655,
                      height: size.width * 1,
                      color: Color(0xffEFEFEF),
                      margin: EdgeInsets.symmetric(vertical: size.width * 10),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 30, bottom: size.width * 10),
                      child: Text(
                        '驳回意见:',
                        style: TextStyle(
                            color: Color(0xff343434),
                            fontSize: size.width * 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ClipRRect(
                        child: Container(
                            height: size.width * 160,
                            color: Color(0xffF2F2F2).withOpacity(0.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _textEditingController,
                                    onChanged: (val) {
                                      // callback('opinion', val);
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '请输入驳回意见...',
                                      hintStyle: TextStyle(
                                          color: Color(0xffC8C8C8),
                                          fontSize: size.width * 24),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Container(
                      width: size.width * 655,
                      height: size.width * 1,
                      color: Color(0xffEFEFEF),
                      margin: EdgeInsets.symmetric(vertical: size.width * 10),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 30),
                      child: Text(
                        '拍照:',
                        style: TextStyle(
                            color: Color(0xff343434),
                            fontSize: size.width * 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MyImageCarma(
                      title: "驳回图片",
                      name: '',
                      purview: '驳回图片',
                    ),
                  ],
                )
              // 隐患
              : GestureDetector(
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
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 10),
                        ),
                        Text(
                          '制定五定措施:',
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
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFECECEC),
                                  width: size.width * 2),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8))),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controllerHiddenName,
                            onChanged: (value) {
                              fiveMeasuresData['dangerName'] = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: size.width * 20,
                                    left: size.width * 20),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 28,
                                    color: Color(0xff7F8A9C)),
                                hintText: fiveMeasuresData['dangerName'] == ''
                                    ? '请输入隐患名称'
                                    : fiveMeasuresData['dangerName']),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
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
                                            itemCount: levelList.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  fiveMeasuresData[
                                                          'dangerLevel'] =
                                                      levelList[index]['id']
                                                          .toString();
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: ListTile(
                                                  title: Text(levelList[index]
                                                          ['name']
                                                      .toString()),
                                                ),
                                              );
                                            },
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: size.width * 72,
                                    width: size.width * 310,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: size.width * 2,
                                            color: Color(0xffECECEC)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 8))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          fiveMeasuresData['dangerLevel'] == ''
                                              ? "请选择"
                                              : fiveMeasuresData[
                                                          'dangerLevel'] ==
                                                      '0'
                                                  ? '一般隐患'
                                                  : '重大隐患',
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C),
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color(0xff7F8A9C),
                                        )
                                      ],
                                    ),
                                  ),
                                )
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
                                            itemCount:
                                                hazardDangerTypeList.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  fiveMeasuresData[
                                                          'hazardDangerType'] =
                                                      hazardDangerTypeList[
                                                              index]['id']
                                                          .toString();
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: ListTile(
                                                  title: Text(
                                                      hazardDangerTypeList[
                                                              index]['name']
                                                          .toString()),
                                                ),
                                              );
                                            },
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: size.width * 72,
                                    width: size.width * 310,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: size.width * 2,
                                            color: Color(0xffECECEC)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 8))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          fiveMeasuresData[
                                                      'hazardDangerType'] ==
                                                  ''
                                              ? "请选择"
                                              : _getHazardDangerType(
                                                  fiveMeasuresData[
                                                      'hazardDangerType']),
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C),
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color(0xff7F8A9C),
                                        )
                                      ],
                                    ),
                                  ),
                                )
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
                        SizedBox(
                          height: size.width * 16,
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
                                    itemCount: dangerSrcList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          fiveMeasuresData['dangerSrc'] =
                                              dangerSrcList[index]['id']
                                                  .toString();
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: Text(dangerSrcList[index]
                                                  ['name']
                                              .toString()),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: size.width * 72,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: size.width * 2,
                                    color: Color(0xffECECEC)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 8))),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 16),
                            child: Row(
                              children: [
                                Text(
                                  fiveMeasuresData['dangerSrc'] == ''
                                      ? "请选择"
                                      : _getDangerSrc(
                                          fiveMeasuresData['dangerSrc']),
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff7F8A9C),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 16,
                        ),
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
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFECECEC),
                                  width: size.width * 2),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8))),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controllerDangerDesc,
                            onChanged: (value) {
                              fiveMeasuresData['dangerDesc'] = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: size.width * 20,
                                    left: size.width * 20),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 28,
                                    color: Color(0xff7F8A9C)),
                                hintText: fiveMeasuresData['dangerDesc'] == ''
                                    ? '请输入隐患描述'
                                    : fiveMeasuresData['dangerDesc']),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
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
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFECECEC),
                                  width: size.width * 2),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8))),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controllerDangerReason,
                            onChanged: (value) {
                              fiveMeasuresData['dangerReason'] = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: size.width * 20,
                                    left: size.width * 20),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 28,
                                    color: Color(0xff7F8A9C)),
                                hintText: fiveMeasuresData['dangerReason'] == ''
                                    ? '请输入原因分析'
                                    : fiveMeasuresData['dangerReason']),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
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
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFECECEC),
                                  width: size.width * 2),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8))),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controllerControlMeasures,
                            onChanged: (value) {
                              fiveMeasuresData['controlMeasures'] = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: size.width * 20,
                                    left: size.width * 20),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 28,
                                    color: Color(0xff7F8A9C)),
                                hintText:
                                    fiveMeasuresData['controlMeasures'] == ''
                                        ? '请输入控制措施'
                                        : fiveMeasuresData['controlMeasures']),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
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
                                Container(
                                  height: size.width * 75,
                                  width: size.width * 310,
                                  margin: EdgeInsets.only(
                                      top: size.width * 16,
                                      bottom: size.width * 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFECECEC),
                                          width: size.width * 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8))),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    controller: _controllerCost,
                                    onChanged: (value) {
                                      fiveMeasuresData['cost'] = value;
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          bottom: size.width * 20,
                                          left: size.width * 20),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: size.width * 28,
                                          color: Color(0xff7F8A9C)),
                                      hintText: fiveMeasuresData['cost'] == ''
                                          ? '请输入资金'
                                          : fiveMeasuresData['cost'],
                                      suffixText: '万元',
                                    ),
                                    maxLines: 1,
                                    minLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '隐患治理期限',
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                MyDateSelect(
                                    height: size.width * 75,
                                    width: size.width * 310,
                                    title: 'startDate',
                                    purview: 'startDate',
                                    hintText: '隐患治理期限',
                                    callback: (value) {
                                      fiveMeasuresData['dangerManageDeadline'] =
                                          value;
                                    },
                                    icon: Image.asset(
                                      'assets/images/doubleRiskProjeck/icon_calendar.png',
                                      height: size.width * 40,
                                      width: size.width * 40,
                                    ),
                                    borderColor: Color(0xFFECECEC)),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '整改责任人',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => ChoosePeople(
                                      changeMsg: _changeLiablePersonMsg,
                                      way: false,
                                    ));
                          },
                          child: Container(
                              height: size.width * 75,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFECECEC),
                                      width: size.width * 2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 8))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  liablePersonMsg.isEmpty
                                      ? Expanded(
                                          child: Text(
                                          '请选择整改责任人',
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C),
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400),
                                        ))
                                      : Expanded(
                                          child: Text(
                                            _getLiablePerName(),
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff7F8A9C),
                                  )
                                ],
                              )),
                        ),
                        Text(
                          '验收人',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => ChoosePeople(
                                      changeMsg: _changeAcceptPersonMsg,
                                      way: false,
                                    ));
                          },
                          child: Container(
                              height: size.width * 75,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFECECEC),
                                      width: size.width * 2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 8))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  acceptPersonMsg.isEmpty
                                      ? Expanded(
                                          child: Text(
                                          '请选择验收人',
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C),
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400),
                                        ))
                                      : Expanded(
                                          child: Text(
                                            _getAcceptPersonName(),
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff7F8A9C),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * 50, right: size.width * 50),
            child: GestureDetector(
              onTap: () {
                if (isFull) {
                  bool next = false;
                  String image = '';
                  if (_textEditingController.text != '' &&
                      _counter.submitDates['驳回图片'] != null) {
                    _counter.submitDates['驳回图片'].forEach((ele) {
                      if (ele['title'] == '驳回图片') {
                        for (var i = 0; i < ele['value'].length; i++) {
                          if (i == ele['value'].length - 1) {
                            image += ele['value'][i];
                          } else {
                            image += ele['value'][i] + '|';
                          }
                        }
                      }
                    });
                    if (image != '') {
                      next = true;
                    }
                  }
                  if (next) {
                    print(_textEditingController.text);
                    print(image);
                    Fluttertoast.showToast(msg: '驳回成功');
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: '请填写驳回的原因以及拍照');
                  }
                } else {
                  print(fiveMeasuresData);
                  if(fiveMeasuresData['dangerLevel'] == ''){
                    Fluttertoast.showToast(msg: '请选择隐患等级');
                  }else if(fiveMeasuresData['dangerName'] == ''){
                    Fluttertoast.showToast(msg: '请填写隐患名称');
                  }else if(fiveMeasuresData['dangerSrc'] == ''){
                    Fluttertoast.showToast(msg: '请选择隐患来源');
                  }else if(fiveMeasuresData['hazardDangerType'] == ''){
                    Fluttertoast.showToast(msg: '请选择隐患类型');
                  }else if(fiveMeasuresData['dangerDesc'] == ''){
                    Fluttertoast.showToast(msg: '请填写隐患描述');
                  }else if(fiveMeasuresData['dangerManageDeadline'] == ''){
                    Fluttertoast.showToast(msg: '请选择治理隐患期限');
                  }else if(fiveMeasuresData['liablePerson'].isEmpty){
                    Fluttertoast.showToast(msg: '请选择整改责任人');
                  }else if(fiveMeasuresData['checkAcceptPerson'].isEmpty){
                    Fluttertoast.showToast(msg: '请选择验收人');
                  }else{
                    print(fiveMeasuresData);
                  }
                  
                  
                  // Navigator.pushNamed(context, '/home/hiddenConfirm',
                  //       arguments: {
                  //         "id": widget.id,
                  //         "data": data,
                  //         "fourId": widget.fourId
                  //       }).then((value) {
                  //     Navigator.pop(context);
                  //   });
                }
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
                  '确认',
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 36),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
