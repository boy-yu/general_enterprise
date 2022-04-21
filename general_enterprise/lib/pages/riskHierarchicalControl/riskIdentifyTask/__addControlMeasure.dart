import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddControlMeasure extends StatefulWidget {
  @override
  State<AddControlMeasure> createState() => _AddControlMeasureState();
}

class _AddControlMeasureState extends State<AddControlMeasure> {
  TextEditingController _controllerMeasures = TextEditingController();
  TextEditingController _controllerClassify3 = TextEditingController();

  Map submitData = {
    'controlMeasures': '',
    'controlClassify1': '',
    'controlClassify2': '',
    'controlClassify3': '',
  };

  List classify1Choice = ["工程技术", "维护保养", "操作行为", "应急措施"];

  List classify2Choice = [];

  _getClassify2Choice(String classify1){
    switch (classify1) {
      case "工程技术":
        classify2Choice = ["工艺控制", "关键设备/部件", "安全附件", "安全仪表", "其他"];
        break;
      case "维护保养":
        classify2Choice = ["动设备", "静设备"];
        break;
      case "操作行为":
        classify2Choice = ["人员资质", "操作记录", "交接班"];
        break;
      case "应急措施":
        classify2Choice = ["应急设施", "个体防护", "消防设施", "应急预案"];
        break;
      default:
       classify2Choice = [];
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
                      submitData['controlMeasures'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['controlMeasures'] == ''
                            ? '请输入管控措施'
                            : submitData['controlMeasures']),
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
                                    submitData['controlClassify1'] = classify1Choice[index].toString();
                                    submitData['controlClassify2'] = '';
                                    _getClassify2Choice(submitData['controlClassify1']);
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
                            submitData['controlClassify1'] == ''
                                ? "请选择管控措施分类1"
                                : submitData['controlClassify1'].toString(),
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
                      if(classify2Choice.isNotEmpty){
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
                                    submitData['controlClassify2'] =
                                        classify2Choice[index].toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    title:
                                        Text(classify2Choice[index].toString()),
                                  ),
                                );
                              },
                            );
                          });
                      }else{
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
                            submitData['controlClassify2'] == ''
                                ? "请选择管控措施分类2"
                                : submitData['controlClassify2'].toString(),
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
                      submitData['controlClassify3'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff7F8A9C)),
                        hintText: submitData['controlClassify3'] == ''
                            ? '请输入管控措施分类3'
                            : submitData['controlClassify3']),
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
                  print(submitData);
                  if(submitData['controlMeasures'] == ''){
                    Fluttertoast.showToast(msg: "请填写管控措施");
                  }else if(submitData['controlClassify1'] == ''){
                    Fluttertoast.showToast(msg: "请选择管控措施分类1");
                  }else if(submitData['controlClassify2'] == ''){
                    Fluttertoast.showToast(msg: "请选择管控措施分类2");
                  }else{
                    Navigator.of(context).pop();
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