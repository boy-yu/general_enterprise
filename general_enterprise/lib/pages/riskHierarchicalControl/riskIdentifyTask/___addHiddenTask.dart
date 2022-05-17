import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddHiddenTask extends StatefulWidget {
  AddHiddenTask({this.riskMeasureId});
  final String riskMeasureId;
  @override
  State<AddHiddenTask> createState() => _AddHiddenTaskState();
}

class _AddHiddenTaskState extends State<AddHiddenTask> {
  TextEditingController _controllerMeasures = TextEditingController();
  TextEditingController _controllerPeriod = TextEditingController();

  Map submitData = {
    'riskMeasureId': '',
    'troubleshootContent': '',
    'checkCycle': '',
    'checkMeans': '',
    'checkCycleUnit': '小时',
    'startRefreshTime': '',
    'endRefreshTime': '',
    'refreshRule': -1 // 1为工作日2为非工作日3为每天
  };

  @override
  void initState() {
    super.initState();
    submitData['riskMeasureId'] = widget.riskMeasureId;
  }

  List controlMeansChoice = ["拍照", "现场确认"];

  List checkCycleUnitList = ["小时", "天", "月", "年"];

  DateTime startRefreshTime;
  DateTime endRefreshTime;

  Widget _getWidget() {
    if (submitData['checkCycleUnit'] == '小时') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.width * 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '开始执行的时间',
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
                      DatePicker.showTimePicker(context,
                          // 是否展示顶部操作按钮
                          showTitleActions: true,
                          // 确定事件
                          onConfirm: (date) {
                        print(date);
                        startRefreshTime = date;
                        submitData['startRefreshTime'] =
                            date.toString().substring(11, 16);
                        setState(() {});
                      },
                          // 当前时间
                          currentTime: DateTime(00), // 当前时间
                          // 语言
                          locale: LocaleType.zh);
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
                            submitData['startRefreshTime'] == ''
                                ? "请选择"
                                : submitData['startRefreshTime'].toString(),
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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '结束执行时间',
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
                      if (startRefreshTime == null) {
                        Fluttertoast.showToast(msg: "请先选择开始执行时间");
                      } else {
                        DatePicker.showTimePicker(context,
                            // 是否展示顶部操作按钮
                            showTitleActions: true,
                            // 确定事件
                            onConfirm: (date) {
                          endRefreshTime = date;
                          submitData['endRefreshTime'] =
                              date.toString().substring(11, 16);
                          setState(() {});
                        },
                            // 当前时间
                            // currentTime: DateTime(2019, 6, 20, 17, 30, 20), // 指定时间
                            currentTime: startRefreshTime, // 当前时间
                            // 语言
                            locale: LocaleType.zh);
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
                            submitData['endRefreshTime'] == ''
                                ? "请选择"
                                : submitData['endRefreshTime'].toString(),
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
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.width * 32,
          ),
          Text(
            '任务执行类型',
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size.width * 16,
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: size.width * 32),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      submitData['refreshRule'] = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: size.width * 200,
                      height: size.width * 68,
                      child: Row(
                        children: [
                          Container(
                            height: size.width * 32,
                            width: size.width * 32,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: submitData['refreshRule'] == 1
                                    ? Border.all(
                                        color: Color(0xff3074FF),
                                        width: size.width * 10)
                                    : Border.all(
                                        color: Color(0xffE0E0E0),
                                        width: size.width * 2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 50))),
                          ),
                          SizedBox(
                            width: size.width * 16,
                          ),
                          Text(
                            '工作日',
                            style: TextStyle(
                                color: submitData['refreshRule'] == 1
                                    ? Color(0xff262626)
                                    : Color(0xff8D95A3),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      submitData['refreshRule'] = 2;
                      setState(() {});
                    },
                    child: Container(
                      width: size.width * 230,
                      height: size.width * 68,
                      child: Row(
                        children: [
                          Container(
                            height: size.width * 32,
                            width: size.width * 32,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: submitData['refreshRule'] == 2
                                    ? Border.all(
                                        color: Color(0xff3074FF),
                                        width: size.width * 10)
                                    : Border.all(
                                        color: Color(0xffE0E0E0),
                                        width: size.width * 2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 50))),
                          ),
                          SizedBox(
                            width: size.width * 16,
                          ),
                          Text(
                            '非工作日',
                            style: TextStyle(
                                color: submitData['refreshRule'] == 2
                                    ? Color(0xff262626)
                                    : Color(0xff8D95A3),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      submitData['refreshRule'] = 3;
                      setState(() {});
                    },
                    child: Container(
                      width: size.width * 200,
                      height: size.width * 68,
                      child: Row(
                        children: [
                          Container(
                            height: size.width * 32,
                            width: size.width * 32,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: submitData['refreshRule'] == 3
                                    ? Border.all(
                                        color: Color(0xff3074FF),
                                        width: size.width * 10)
                                    : Border.all(
                                        color: Color(0xffE0E0E0),
                                        width: size.width * 2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 50))),
                          ),
                          SizedBox(
                            width: size.width * 16,
                          ),
                          Text(
                            '每天',
                            style: TextStyle(
                                color: submitData['refreshRule'] == 3
                                    ? Color(0xff262626)
                                    : Color(0xff8D95A3),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      );
    } else {
      return Container();
    }
  }

  int _getHour() {
    if (endRefreshTime.difference(startRefreshTime).inHours < 0) {
      return 24 - endRefreshTime.difference(startRefreshTime).inHours;
    } else {
      return endRefreshTime.difference(startRefreshTime).inHours;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "新增隐患排查内容",
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
                    '隐患排查内容',
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
                      submitData['troubleshootContent'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['troubleshootContent'] == ''
                            ? '请输入隐患内容'
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
                  Text(
                    '管控手段',
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
                              itemCount: controlMeansChoice.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    submitData['checkMeans'] =
                                        controlMeansChoice[index].toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                        controlMeansChoice[index].toString()),
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
                            submitData['checkMeans'] == ''
                                ? "请选择管控手段"
                                : submitData['checkMeans'].toString(),
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
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  Text(
                    '巡检周期',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          inputFormatters: [
                            submitData['checkCycleUnit'] == '小时'
                                ? FilteringTextInputFormatter.allow(
                                    RegExp(r'^(1[0-2]|\d)$'))
                                : FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]*$')) //周期为小数设置只允许1-12正整数
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: _controllerPeriod,
                          onChanged: (value) {
                            submitData['checkCycle'] = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: size.width * 28,
                                  color: Color(0xff7F8A9C)),
                              hintText: submitData['checkCycle'] == ''
                                  ? '请输入巡检周期'
                                  : submitData['checkCycle'].toString()),
                          maxLines: 1,
                          minLines: 1,
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
                                  itemCount: checkCycleUnitList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        submitData['checkCycleUnit'] =
                                            checkCycleUnitList[index]
                                                .toString();
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(checkCycleUnitList[index]
                                            .toString()),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          height: size.width * 90,
                          width: size.width * 200,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: size.width * 2,
                                  color: Color(0xffECECEC)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8))),
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 16),
                          child: Row(
                            children: [
                              Text(
                                submitData['checkCycleUnit'].toString(),
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
                    ],
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  _getWidget()
                ],
              )),
              GestureDetector(
                onTap: () {
                  if (submitData['troubleshootContent'] == '') {
                    Fluttertoast.showToast(msg: "请填写隐患内容");
                  } else if (submitData['checkCycle'] == '') {
                    Fluttertoast.showToast(msg: "请填写巡检周期");
                  } else if (submitData['checkMeans'] == '') {
                    Fluttertoast.showToast(msg: "请选择管控手段");
                  } else {
                    if (submitData['checkCycleUnit'] == '小时') {
                      if (submitData['startRefreshTime'] == '') {
                        Fluttertoast.showToast(msg: "请选择开始执行时间");
                      } else if (submitData['endRefreshTime'] == '') {
                        Fluttertoast.showToast(msg: "请选择结束执行时间");
                      } else if (submitData['startRefreshTime'] ==
                          submitData['endRefreshTime']) {
                        Fluttertoast.showToast(msg: "执行时段请小于24小时");
                      } else if (int.parse(submitData['checkCycle']) >
                          _getHour()) {
                        Fluttertoast.showToast(msg: "周期不能大于时间段");
                      } else if (submitData['refreshRule'] == -1) {
                        Fluttertoast.showToast(msg: "请选择刷新规则");
                      } else {
                        // 提交数据
                        // Navigator.of(context).pop();
                        submitData['checkCycle'] =
                            int.parse(submitData['checkCycle']);
                        if (submitData['checkMeans'] == '拍照') {
                          submitData['checkMeans'] = '1';
                        } else if (submitData['checkMeans'] == '现场确认') {
                          submitData['checkMeans'] = '0';
                        }
                        myDio
                            .request(
                                type: 'post',
                                url: Interface.postAddRiskTemplateFiveWarehouse,
                                data: submitData)
                            .then((value) {
                          Fluttertoast.showToast(msg: '新增隐患排查内容成功');
                          Navigator.of(context).pop();
                        });
                      }
                    } else {
                      // 提交数据
                      submitData['checkCycle'] =
                          int.parse(submitData['checkCycle']);
                      if (submitData['checkMeans'] == '拍照') {
                        submitData['checkMeans'] = '1';
                      } else if (submitData['checkMeans'] == '现场确认') {
                        submitData['checkMeans'] = '0';
                      }
                      myDio
                          .request(
                              type: 'post',
                              url: Interface.postAddRiskTemplateFiveWarehouse,
                              data: submitData)
                          .then((value) {
                        Fluttertoast.showToast(msg: '新增隐患排查内容成功');
                        Navigator.of(context).pop();
                      });
                    }
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
