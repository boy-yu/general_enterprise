import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRiskEvent extends StatefulWidget {
  @override
  State<AddRiskEvent> createState() => _AddRiskEventState();
}

class _AddRiskEventState extends State<AddRiskEvent> {
  TextEditingController _controllerEvent = TextEditingController();
  TextEditingController _controllerDescribe = TextEditingController();
  

  Map submitData = {
    'riskEvent': '',
    'riskDescription': '',
    'initialConsequence': '',
    'currentConsequence': '',
    'initialChance': '',
    'currentChance': '',
    'initialRiskDegree': '',
    'currentRiskDegree': '',
    'initialRiskLevel': '',
    'currentRiskLevel': '',
  };

  List levelChoice = ['1', '2', '3', '4', '5'];

  String _getInitialRiskLevel(int riskLevel){
    submitData['initialRiskLevel'] = riskLevel.toString();
    if(25 >= riskLevel && riskLevel >= 20){
      return '重大风险';
    }else if(20 > riskLevel && riskLevel >= 15){
      return '较大风险';
    }else if(15 > riskLevel && riskLevel >= 9){
      return '较大风险';
    }else if(8 >= riskLevel){
      return '低风险';
    }else{
      return '系统自动判断';
    }
  }

  String _getCurrentRiskLevel(int riskLevel){
    submitData['currentRiskLevel'] = riskLevel.toString();
    if(25 >= riskLevel && riskLevel >= 20){
      return '重大风险';
    }else if(20 > riskLevel && riskLevel >= 15){
      return '较大风险';
    }else if(15 > riskLevel && riskLevel >= 9){
      return '较大风险';
    }else if(8 >= riskLevel){
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
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _controllerEvent,
                  onChanged: (value) {
                    submitData['riskEvent'] = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: size.width * 28, color: Color(0xff7F8A9C)),
                      hintText: submitData['riskEvent'] == ''
                          ? '请输入风险事件'
                          : submitData['riskEvent']),
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
                  keyboardType: TextInputType.phone,
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
                                            submitData['initialConsequence'] = levelChoice[index].toString();
                                            if(submitData['initialChance'] != ''){
                                              submitData['initialRiskDegree'] = (int.parse(submitData['initialConsequence']) * int.parse(submitData['initialChance'])).toString();
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
                                  submitData['initialConsequence'] == '' ? "请选择" : submitData['initialConsequence'].toString(),
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
                                            submitData['currentConsequence'] = levelChoice[index].toString();
                                            if(submitData['currentChance'] != ''){
                                              submitData['currentRiskDegree'] = (int.parse(submitData['currentChance']) * int.parse(submitData['currentConsequence'])).toString();
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
                                  submitData['currentConsequence'] == '' ? "请选择" : submitData['currentConsequence'].toString(),
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
                                            submitData['initialChance'] = levelChoice[index].toString();
                                            if(submitData['initialConsequence'] != ''){
                                              submitData['initialRiskDegree'] = (int.parse(submitData['initialConsequence']) * int.parse(submitData['initialChance'])).toString();
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
                                  submitData['initialChance'] == '' ? "请选择" : submitData['initialChance'].toString(),
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
                                            submitData['currentChance'] = levelChoice[index].toString();
                                            if(submitData['currentConsequence'] != ''){
                                              submitData['currentRiskDegree'] = (int.parse(submitData['currentChance']) * int.parse(submitData['currentConsequence'])).toString();
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
                                  submitData['currentChance'] == '' ? "请选择" : submitData['currentChance'].toString(),
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
                              submitData['initialRiskDegree'] != '' ? submitData['initialRiskDegree'] : "系统自动判断",
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
                              submitData['currentRiskDegree'] != '' ? submitData['currentRiskDegree'] : "系统自动判断",
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
                              submitData['initialRiskDegree'] != ''? _getInitialRiskLevel(int.parse(submitData['initialRiskDegree'])) : '系统自动判断',
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
                              submitData['currentRiskDegree'] != ''? _getCurrentRiskLevel(int.parse(submitData['currentRiskDegree'])) : '系统自动判断',
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
                if(submitData['riskEvent'] == ''){
                  Fluttertoast.showToast(msg: "请填写风险事件");
                }else if(submitData['riskDescription'] == ''){
                  Fluttertoast.showToast(msg: "请填写风险描述");
                }else if(submitData['initialConsequence'] == ''){
                  Fluttertoast.showToast(msg: "请选择初始后果");
                }else if(submitData['currentConsequence'] == ''){
                  Fluttertoast.showToast(msg: "请选择剩余后果");
                }else if(submitData['initialChance'] == ''){
                  Fluttertoast.showToast(msg: "请选择初始可能性");
                }else if(submitData['currentChance'] == ''){
                  Fluttertoast.showToast(msg: "请选择剩余可能性");
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
        )
        );
  }
}
