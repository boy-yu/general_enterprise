import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddControlMeasure extends StatefulWidget {
  AddControlMeasure({this.riskEventId});
  final String riskEventId;
  @override
  State<AddControlMeasure> createState() => _AddControlMeasureState();
}

class _AddControlMeasureState extends State<AddControlMeasure> {
  TextEditingController _controllerMeasures = TextEditingController();
  TextEditingController _controllerClassify3 = TextEditingController();
  TextEditingController _controllerTroubleshootContent =
      TextEditingController();
  TextEditingController _controllerRonsequenceReduction =
      TextEditingController();
  TextEditingController _controllerProbabilityReduction =
      TextEditingController();

  Map submitData = {
    'riskMeasureDesc': '',
    'classify1': '',
    'classify2': '',
    'classify3': '',
    'troubleshootContent': '',
    'consequenceReduction': '',
    'probabilityReduction': ''
  };

  List classify1Choice = ["工程技术", "维护保养", "操作行为", "应急措施"];

  List classify2Choice = [];
  // String regExp = "^(([1-5])|(([1-4])\\.[0-9][0-9]?)|(5\\.0{1,2}))$"
  _getClassify2Choice(String classify1) {
    switch (classify1) {
      case "工程技术":
        classify2Choice = ["工艺控制", "关键设备/部件", "安全附件", "安全仪表", "其他"];
        break;
      case "维护保养":
        classify2Choice = ["动设备", "静设备", "其他"];
        break;
      case "操作行为":
        classify2Choice = ["人员资质", "操作记录", "交接班", "其他"];
        break;
      case "应急措施":
        classify2Choice = ["应急设施", "个体防护", "消防设施", "应急预案", "其他"];
        break;
      default:
        classify2Choice = [];
    }
  }

  String _getClassify1(String classify1) {
    // 工程技术：1；维护保养：2；操作行为：3；应急措施：4
    switch (classify1) {
      case '工程技术':
        return '1';
        break;
      case '维护保养':
        return '2';
        break;
      case '操作行为':
        return '3';
        break;
      case '应急措施':
        return '4';
        break;
      default:
        return '';
    }
  }

  String _getClassify2(String classify1, String classify2) {
    print(classify1);
    print(classify2);
    // 工艺控制:1-1；关键设备/部件：1-2；安全附件：1-3；安全仪表：1-4；其它：1-5；
    // 动设备：2-1；静设备：2-2；其它：2-3；
    // 人员资质：3-1；操作记录：3-2；交接班：3-3；其他：3-4；
    // 应急设施:4-1；个体防护：4-2；消防设施：4-3；应急预案：4-4；其它：4-5；
    switch (classify1) {
      case '工程技术':
        switch (classify2) {
          case '工艺控制':
            return '1-1';
            break;
          case '关键设备/部件':
            return '1-2';
            break;
          case '安全附件':
            return '1-3';
            break;
          case '安全仪表':
            return '1-4';
            break;
          case '其它':
            return '1-5';
            break;
          default:
        return '';
        }
        break;
      case '维护保养':
        switch (classify2) {
          case '动设备':
            return '2-1';
            break;
          case '静设备':
            return '2-2';
            break;
          case '其它':
            return '2-3';
            break;
          default:
        return '';
        }
        break;
      case '操作行为':
        switch (classify2) {
          case '人员资质':
            return '3-1';
            break;
          case '操作记录':
            return '3-2';
            break;
          case '交接班':
            return '3-3';
            break;
          case '其他':
            return '3-4';
            break;
          default:
        return '';
        }
        break;
      case '应急措施':
        switch (classify2) {
          case '应急设施':
            return '4-1';
            break;
          case '个体防护':
            return '4-2';
            break;
          case '消防设施':
            return '4-3';
            break;
          case '应急预案':
            return '4-4';
            break;
          case '其它':
            return '4-5';
            break;
          default:
        return '';
        }
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "新增管控措施",
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 30, vertical: size.width * 20),
                children: [
                  Text(
                    '管控措施',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerMeasures,
                    onChanged: (value) {
                      submitData['riskMeasureDesc'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['riskMeasureDesc'] == ''
                            ? '请输入管控措施'
                            : submitData['riskMeasureDesc']),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  Text(
                    '管控措施分类1',
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
                              itemCount: classify1Choice.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    submitData['classify1'] =
                                        classify1Choice[index].toString();
                                    submitData['classify2'] = '';
                                    _getClassify2Choice(
                                        submitData['classify1']);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    title:
                                        Text(classify1Choice[index].toString()),
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
                              width: size.width * 2, color: Color(0xffECECEC)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 16),
                      child: Row(
                        children: [
                          Text(
                            submitData['classify1'] == ''
                                ? "请选择管控措施分类1"
                                : submitData['classify1'].toString(),
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
                    height: size.width * 32,
                  ),
                  Text(
                    '管控措施分类2',
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
                      if (classify2Choice.isNotEmpty) {
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
                                itemCount: classify2Choice.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      submitData['classify2'] =
                                          classify2Choice[index].toString();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          classify2Choice[index].toString()),
                                    ),
                                  );
                                },
                              );
                            });
                      } else {
                        Fluttertoast.showToast(msg: "请先选择管控措施分类1");
                      }
                    },
                    child: Container(
                      height: size.width * 72,
                      width: size.width * 310,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: size.width * 2, color: Color(0xffECECEC)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 16),
                      child: Row(
                        children: [
                          Text(
                            submitData['classify2'] == ''
                                ? "请选择管控措施分类2"
                                : submitData['classify2'].toString(),
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
                    height: size.width * 32,
                  ),
                  Text(
                    '管控措施分类3',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerClassify3,
                    onChanged: (value) {
                      submitData['classify3'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['classify3'] == ''
                            ? '请输入管控措施分类3'
                            : submitData['classify3']),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  Text(
                    '隐患排查内容',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerTroubleshootContent,
                    onChanged: (value) {
                      submitData['troubleshootContent'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['troubleshootContent'] == ''
                            ? '请输入隐患排查内容'
                            : submitData['troubleshootContent']),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  // yz
                  Text(
                    '后果降低值',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),//数字包括小数
                      LengthLimitingTextInputFormatter(4)
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _controllerRonsequenceReduction,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        double v = double.parse(value);
                        if (v < 0 || v > 4.00) {
                          Fluttertoast.showToast(msg: "输入值在0~4.00之间");
                          _controllerRonsequenceReduction.text = '';
                          // _controllerRonsequenceReduction.selection =
                          //     TextSelection.fromPosition(TextPosition(
                          //         offset: _controllerRonsequenceReduction
                          //             .text.length));
                        } else {
                          submitData['consequenceReduction'] = value;
                          setState(() {});
                        }
                      } else {
                        _controllerRonsequenceReduction.text = '';
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['consequenceReduction'] == ''
                            ? '请输入后果降低值'
                            : submitData['consequenceReduction']),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  Text(
                    '可能性降低值',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]")),//数字包括小数
                      LengthLimitingTextInputFormatter(4),
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _controllerProbabilityReduction,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        double v = double.parse(value);
                        if (v < 0 || v > 4.00) {
                          Fluttertoast.showToast(msg: "输入值在0~4.00之间");
                          _controllerProbabilityReduction.text = '';
                        } else {
                          submitData['probabilityReduction'] = value;
                          setState(() {});
                        }
                      } else {
                        _controllerProbabilityReduction.text = '';
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['probabilityReduction'] == ''
                            ? '请输入可能性降低值'
                            : submitData['probabilityReduction']),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                ],
              )),
              GestureDetector(
                onTap: () {
                  if (submitData['riskMeasureDesc'] == '') {
                    Fluttertoast.showToast(msg: "请填写管控措施");
                  } else if (submitData['classify1'] == '') {
                    Fluttertoast.showToast(msg: "请选择管控措施分类1");
                  } else if (submitData['classify2'] == '') {
                    Fluttertoast.showToast(msg: "请选择管控措施分类2");
                  } else if (submitData['troubleshootContent'] == '') {
                    Fluttertoast.showToast(msg: "请填写隐患排查内容");
                  } else if (submitData['consequenceReduction'] == '') {
                    Fluttertoast.showToast(msg: "请填写后果降低值");
                  } else if (submitData['probabilityReduction'] == '') {
                    Fluttertoast.showToast(msg: "请填写可能性降低值");
                  } else {
                    submitData['riskEventId'] = widget.riskEventId;
                    submitData['dataSrc'] = '2';
                    submitData['classify2'] = _getClassify2(submitData['classify1'], submitData['classify2']);
                    submitData['classify1'] = _getClassify1(submitData['classify1']);
                    print(submitData);
                    myDio
                        .request(
                            type: 'post',
                            url: Interface.postRiskTemplateFourWarehouse,
                            data: submitData)
                        .then((value) {
                      successToast('新增风险管控措施成功');
                      Navigator.pop(context);
                    });
                  }
                },
                child: Container(
                  height: size.width * 80,
                  width: size.width * 686,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: size.width * 50),
                  decoration: BoxDecoration(
                      color: Color(0xff3074FF),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 8))),
                  child: Text(
                    "确  定",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
