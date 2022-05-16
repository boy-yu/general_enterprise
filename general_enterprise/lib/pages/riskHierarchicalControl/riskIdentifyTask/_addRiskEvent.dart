import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRiskEvent extends StatefulWidget {
  AddRiskEvent({this.riskUnitId});
  final String riskUnitId;
  @override
  State<AddRiskEvent> createState() => _AddRiskEventState();
}

class _AddRiskEventState extends State<AddRiskEvent> {
  TextEditingController _controllerEvent = TextEditingController();
  TextEditingController _controllerDescribe = TextEditingController();
  

  Map submitData = {
	"companyCode": "",
	"companyId": "",
	"createBy": "",
	"createDate": "",
	"currentRiskLevel": "",
	"deleted": "",
	"hazardCode": "",
	"id": "",
	"initialRiskConsequences": 0,
	"initialRiskDegree": 0,
	"initialRiskLevel": "",
	"initialRiskPossibility": 0,
	"riskConsequences": 0,
	"riskDegree": 0,
	"riskDescription": "",
	"riskEventName": "",
	"riskLevel": "",
	"riskObjectId": "",
	"riskPossibility": 0,
	"riskUnitId": "",
	"selected": "",
	"status": "",
	"updateBy": "",
	"updateDate": ""
};

  List levelChoice = [1, 2, 3, 4, 5];

  String _getInitialRiskLevel(int riskLevel){
    if(25 >= riskLevel && riskLevel >= 20){
      submitData['initialRiskLevel'] = '1';
      submitData['currentRiskLevel'] = '1';
      return '重大风险';
    }else if(20 > riskLevel && riskLevel >= 15){
      submitData['initialRiskLevel'] = '2';
      submitData['currentRiskLevel'] = '2';
      return '较大风险';
    }else if(15 > riskLevel && riskLevel >= 9){
      submitData['initialRiskLevel'] = '3';
      submitData['currentRiskLevel'] = '3';
      return '一般风险';
    }else if(8 >= riskLevel){
      submitData['initialRiskLevel'] = '4';
      submitData['currentRiskLevel'] = '4';
      return '低风险';
    }else{
      return '系统自动判断';
    }
  }

  String _getCurrentRiskLevel(int riskLevel){
    if(25 >= riskLevel && riskLevel >= 20){
      submitData['riskLevel'] = '1';
      return '重大风险';
    }else if(20 > riskLevel && riskLevel >= 15){
      submitData['riskLevel'] = '2';
      return '较大风险';
    }else if(15 > riskLevel && riskLevel >= 9){
      submitData['riskLevel'] = '3';
      return '一般风险';
    }else if(8 >= riskLevel){
      submitData['riskLevel'] = '4';
      return '低风险';
    }else{
      return '系统自动判断';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "新增风险事件",
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
                children: [
                  Text(
                    '风险事件',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerEvent,
                    onChanged: (value) {
                      submitData['riskEventName'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28, color: Color(0xff7F8A9C)),
                        hintText: submitData['riskEventName'] == ''
                            ? '请输入风险事件'
                            : submitData['riskEventName']),
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
                    '风险描述',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _controllerDescribe,
                    onChanged: (value) {
                      submitData['riskDescription'] = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28, color: Color(0xff7F8A9C)),
                        hintText: submitData['riskDescription'] == ''
                            ? '请输入风险描述'
                            : submitData['riskDescription']),
                    maxLines: 1,
                    minLines: 1,
                  ),
                  Container(
                    color: Color(0xffECECEC),
                    height: size.width * 2,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.width * 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '初始后果',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          GestureDetector(
                            onTap: (){
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
                                        itemCount: levelChoice.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              submitData['initialRiskConsequences'] = levelChoice[index];
                                              if(submitData['initialRiskPossibility'] != ''){
                                                submitData['initialRiskDegree'] = submitData['initialRiskConsequences'] * submitData['initialRiskPossibility'];
                                              }
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                  levelChoice[index].toString()),
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
                                border: Border.all(width: size.width * 2, color: Color(0xffECECEC)),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  Text(
                                    submitData['initialRiskConsequences'] == '' ? "请选择" : submitData['initialRiskConsequences'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w400
                                    ),
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
                            '剩余后果',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          GestureDetector(
                            onTap: (){
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
                                        itemCount: levelChoice.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              submitData['riskConsequences'] = levelChoice[index];
                                              if(submitData['riskPossibility'] != ''){
                                                submitData['riskDegree'] = submitData['riskPossibility'] * submitData['riskConsequences'];
                                              }
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                  levelChoice[index].toString()),
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
                                border: Border.all(width: size.width * 2, color: Color(0xffECECEC)),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  Text(
                                    submitData['riskConsequences'] == '' ? "请选择" : submitData['riskConsequences'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w400
                                    ),
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
                    height: size.width * 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '初始可能性',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          GestureDetector(
                            onTap: (){
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
                                        itemCount: levelChoice.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              submitData['initialRiskPossibility'] = levelChoice[index];
                                              if(submitData['initialRiskConsequences'] != ''){
                                                submitData['initialRiskDegree'] = submitData['initialRiskConsequences'] * submitData['initialRiskPossibility'];
                                              }
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                  levelChoice[index].toString()),
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
                                border: Border.all(width: size.width * 2, color: Color(0xffECECEC)),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  Text(
                                    submitData['initialRiskPossibility'] == '' ? "请选择" : submitData['initialRiskPossibility'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w400
                                    ),
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
                            '剩余可能性',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          GestureDetector(
                            onTap: (){
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
                                        itemCount: levelChoice.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              submitData['riskPossibility'] = levelChoice[index];
                                              if(submitData['riskConsequences'] != ''){
                                                submitData['riskDegree'] = submitData['riskPossibility'] * submitData['riskConsequences'];
                                              }
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                  levelChoice[index].toString()),
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
                                border: Border.all(width: size.width * 2, color: Color(0xffECECEC)),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              child: Row(
                                children: [
                                  Text(
                                    submitData['riskPossibility'] == '' ? "请选择" : submitData['riskPossibility'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w400
                                    ),
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
                    height: size.width * 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '初始风险度',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                              height: size.width * 72,
                              width: size.width * 310,
                              decoration: BoxDecoration(
                                color: Color(0xffECECEC),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                submitData['initialRiskDegree'] != '' ? submitData['initialRiskDegree'].toString() : "系统自动判断",
                                style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '剩余风险度',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                              height: size.width * 72,
                              width: size.width * 310,
                              decoration: BoxDecoration(
                                color: Color(0xffECECEC),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                submitData['riskDegree'] != '' ? submitData['riskDegree'].toString() : "系统自动判断",
                                style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '初始风险等级',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                              height: size.width * 72,
                              width: size.width * 310,
                              decoration: BoxDecoration(
                                color: Color(0xffECECEC),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                submitData['initialRiskDegree'] != 0 ? _getInitialRiskLevel(submitData['initialRiskDegree']) : '系统自动判断',
                                style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '剩余风险等级',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.width * 16,
                          ),
                          Container(
                              height: size.width * 72,
                              width: size.width * 310,
                              decoration: BoxDecoration(
                                color: Color(0xffECECEC),
                                borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                submitData['riskDegree'] != ''? _getCurrentRiskLevel(submitData['riskDegree']) : '系统自动判断',
                                style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
              GestureDetector(
                onTap: () {
                  if(submitData['riskEventName'] == ''){
                    Fluttertoast.showToast(msg: "请填写风险事件");
                  }else if(submitData['riskDescription'] == ''){
                    Fluttertoast.showToast(msg: "请填写风险描述");
                  }else if(submitData['initialRiskConsequences'] == 0){
                    Fluttertoast.showToast(msg: "请选择初始后果");
                  }else if(submitData['riskConsequences'] == 0){
                    Fluttertoast.showToast(msg: "请选择剩余后果");
                  }else if(submitData['initialRiskPossibility'] == 0){
                    Fluttertoast.showToast(msg: "请选择初始可能性");
                  }else if(submitData['riskPossibility'] == 0){
                    Fluttertoast.showToast(msg: "请选择剩余可能性");
                  }else{
                    submitData['riskUnitId'] = widget.riskUnitId;
                    myDio.request(
                          type: 'post',
                          url: Interface.postRiskTemplateThreeWarehouseAll,
                          data: submitData).then((value) {
                        successToast('新增风险事件成功');
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
        )
      );
  }
}
