import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/myDialog/affirmDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HiddenReported extends StatefulWidget {
  @override
  State<HiddenReported> createState() => _HiddenReportedState();
}

class _HiddenReportedState extends State<HiddenReported> {
  TextEditingController _controllerPlace = TextEditingController();
  TextEditingController _controllerDangerDesc = TextEditingController();
  Counter _counter = Provider.of(myContext);

  Map submitData = {
    'riskObjectName': '',
    'place': '',
    'dangerDesc': '',
    'executionUrl': ''
  };

  List riskObjectList = [
    {'riskObjectName': '风险分析对象1'},
    {'riskObjectName': '风险分析对象2'},
    {'riskObjectName': '风险分析对象3'},
    {'riskObjectName': '风险分析对象4'},
    {'riskObjectName': '风险分析对象5'},
    {'riskObjectName': '风险分析对象6'},
    {'riskObjectName': '风险分析对象7'},
    {'riskObjectName': '风险分析对象8'},
  ];

  List _generateImage({String state}) {
    List image = [];
    if (_counter.submitDates['上报隐患'] == null) {
      // Fluttertoast.showToast(msg: '请拍照');
    } else {
      bool next = false;
      _counter.submitDates['上报隐患'].forEach((ele) {
        if (ele['title'] == '上报隐患') {
          image = ele['value'];
          if (image.length > 0) {
            next = true;
          }
        }
      });
      if (!next && state != '数据录入') {
        Fluttertoast.showToast(msg: '请拍照');
      }
    }
    return image;
  }

  _sumbit() {
    if (submitData['riskObjectName'] == '') {
      Fluttertoast.showToast(msg: '请选择风险分析对象');
    } else if (submitData['place'] == '') {
      Fluttertoast.showToast(msg: '请输入地点');
    } else if (submitData['dangerDesc'] == '') {
      Fluttertoast.showToast(msg: '请输入隐患描述');
    } else {
      List image = _generateImage();
      if (image.isEmpty) {
        Fluttertoast.showToast(msg: '请拍照');
        return;
      }
      String carmaStr = '';
      for (var i = 0; i < image.length; i++) {
        if (i == image.length - 1) {
          carmaStr += image[i];
        } else {
          carmaStr += image[i] + '|';
        }
      }
      submitData['executionUrl'] = carmaStr;
      print(submitData);

      Fluttertoast.showToast(msg: '上报成功');
      submitData = {
        'riskObjectName': '',
        'place': '',
        'dangerDesc': '',
        'executionUrl': ''
      };
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          '上报隐患',
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
                    },
                    child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 32, vertical: size.width * 62),
                children: [
                  Text(
                    '风险分析对象',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.width * 20,
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
                              itemCount: riskObjectList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    submitData['riskObjectName'] =
                                        riskObjectList[index]['riskObjectName']
                                            .toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    title: Text(riskObjectList[index]
                                            ['riskObjectName']
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
                              width: size.width * 2, color: Color(0xffECECEC)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 16),
                      child: Row(
                        children: [
                          Text(
                            submitData['riskObjectName'] == ''
                                ? "请选择风险分析对象"
                                : submitData['riskObjectName'].toString(),
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
                    '地点',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerPlace,
                    onChanged: (value) {
                      submitData['place'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['place'] == ''
                            ? '请输入地点'
                            : submitData['place']),
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
                    '隐患描述',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerDangerDesc,
                    onChanged: (value) {
                      submitData['dangerDesc'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['dangerDesc'] == ''
                            ? '请输入隐患描述'
                            : submitData['dangerDesc']),
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
                    '拍照:',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  MyImageCarma(
                    title: "上报隐患",
                    name: '',
                    purview: '上报隐患',
                  )
                ],
              ),
                  )
              ),
              GestureDetector(
                onTap: (){
                  AffirmDialog.myAffirmDialog(
                    context,
                    '提示',
                    '是否确认提交隐患？',
                    _sumbit,
                  );
                },
                child: Container(
                  height: size.width * 80,
                  width: size.width * 686,
                  decoration: BoxDecoration(
                      color: Color(0xff3074FF),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 8))),
                  margin: EdgeInsets.symmetric(vertical: size.width * 10),
                  alignment: Alignment.center,
                  child: Text(
                    '提  交',
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
