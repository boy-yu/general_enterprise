import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AppendUnplannedRisk extends StatefulWidget {
  @override
  _AppendUnplannedRiskState createState() => _AppendUnplannedRiskState();
}

class _AppendUnplannedRiskState extends State<AppendUnplannedRisk> {
  TextEditingController _controller = TextEditingController();
  String selectRiskUnit = '请选择分析单元';
  // bool isSelectOther = false;

  String selectRiskEvent = '请选择风险事件';
  List unitData = [
    "分析单元1",
    "分析单元2",
    "分析单元3",
    "分析单元4",
    "分析单元5",
    "分析单元6",
    "其他",
  ];
  List eventData = [];

  Counter _counter = Provider.of<Counter>(myContext);
  _empty() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.changeSubmitDates("新增隐患", {"title": "新增计划外隐患", "value": []});
    });
  }

  @override
  void initState() {
    super.initState();
    _empty();
  }

  String describe;

  Map submitData = {};

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('新增计划外隐患'),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 25, vertical: size.width * 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '隐患名称：',
                style: TextStyle(
                    fontSize: size.width * 26,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: size.width * 60,
                width: size.width * 690,
                alignment: Alignment.center,
                child: TextField(
                  controller: _controller,
                  style:
                      TextStyle(color: Colors.black, fontSize: size.width * 24),
                  decoration: InputDecoration(
                    hintText: '请输入名称',
                    hintStyle: TextStyle(
                        color: Color(0xffB6BAC2), fontSize: size.width * 24),
                    fillColor: Color(0xffF1F5FD),
                    filled: true,
                    border: InputBorder.none,
                  ),
                  autofocus: false,
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Text(
                '风险分析单元：',
                style: TextStyle(
                    fontSize: size.width * 26,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: unitData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (unitData[index] == '其他') {
                                        WorkDialog.myDialog(context,
                                            (String appendUnit,
                                                String appendEvent) {
                                          selectRiskUnit = appendUnit;
                                          selectRiskEvent = appendEvent;
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, 16);
                                      } else {
                                        selectRiskUnit = unitData[index];
                                        selectRiskEvent = '请选择风险事件';
                                        eventData = [
                                          "风险事件1",
                                          "风险事件2",
                                          "风险事件3",
                                          "风险事件4",
                                          "风险事件5",
                                          "风险事件6",
                                          "其他",
                                        ];
                                        setState(() {});
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 30,
                                              horizontal: size.width * 20),
                                          child: Center(
                                            child: Text(unitData[index]),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: size.width * 1,
                                          color: Color(0xffF1F1F1),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                        // Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: unitData.asMap().keys.map((index)=>
                        //     ListTile(
                        //       title: unitData[index],
                        //       onTap: () async {
                        //         selectRiskUnit = unitData[index];
                        //         Navigator.pop(context);
                        //       },
                        //     ),
                        //   ).toList()
                        // );
                      });
                },
                child: Container(
                    height: size.width * 60,
                    width: size.width * 690,
                    color: Color(0xffF1F5FD),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 25),
                    child: Row(
                      children: [
                        Text(
                          selectRiskUnit,
                          style: TextStyle(
                              color: Color(0xffB6BAC2),
                              fontSize: size.width * 24),
                        ),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff898989),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Text(
                '风险事件：',
                style: TextStyle(
                    fontSize: size.width * 26,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  eventData.isNotEmpty && selectRiskEvent == '请选择风险事件'
                      ? showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: eventData.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (eventData[index] == '其他') {
                                            WorkDialog.myDialog(context,
                                                (String appendEv) {
                                              // print("appendUnit" + appendUnit);
                                              if (appendEv != null &&
                                                  appendEv != '') {
                                                selectRiskEvent = appendEv;
                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                            }, 17);
                                          } else {
                                            selectRiskEvent = eventData[index];

                                            setState(() {});
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.width * 30,
                                                  horizontal: size.width * 20),
                                              child: Center(
                                                child: Text(eventData[index]),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: size.width * 1,
                                              color: Color(0xffF1F1F1),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          })
                      : selectRiskEvent != '请选择风险事件'
                          ? Container()
                          : Fluttertoast.showToast(msg: "请先选择风险分析单元");
                },
                child: Container(
                    height: size.width * 60,
                    width: size.width * 690,
                    color: Color(0xffF1F5FD),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 25),
                    child: Row(
                      children: [
                        Text(
                          selectRiskEvent,
                          style: TextStyle(
                              color: Color(0xffB6BAC2),
                              fontSize: size.width * 24),
                        ),
                        Spacer(),
                        selectRiskEvent == '请选择风险事件'
                            ? Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff898989),
                              )
                            : Container()
                      ],
                    )),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Text(
                '排查结果：',
                style: TextStyle(
                    fontSize: size.width * 26,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Center(
                child: Container(
                  height: size.width * 60,
                  width: size.width * 220,
                  decoration: BoxDecoration(
                      color: Color(0xffFF1818),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  alignment: Alignment.center,
                  child: Text(
                    '异常',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 30),
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Text(
                '照片：',
                style: TextStyle(
                    fontSize: size.width * 26,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: size.width * 250,
                child: ListView(
                  children: [
                    MyImageCarma(
                      purview: "新增隐患",
                      title: "新增计划外隐患",
                      score: 3,
                    ),
                  ],
                ),
              ),
              Text(
                '描述:',
                style: TextStyle(
                    fontSize: size.width * 26,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (str) {
                  describe = str;
                },
                maxLines: 5,
                minLines: 5,
                style: TextStyle(fontSize: size.width * 24),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: describe ?? '请输入描述',
                    hintStyle: TextStyle(
                        color: Color(0xffB6BAC2), fontSize: size.width * 24),
                    fillColor: Color(0xffF1F5FD),
                    filled: true,
                    contentPadding: EdgeInsets.all(size.width * 20)),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    List imageList = [];
                    String image = '';
                     _counter.submitDates['新增隐患'].forEach((ele) {
                      if (ele['title'] == '新增计划外隐患') {
                        imageList = ele['value'];
                      }
                    });
                    for (var i = 0; i < imageList.length; i++) {
                      if (i == imageList.length - 1) {
                        image += imageList[i];
                      } else {
                        image += imageList[i] + '|';
                      }
                    }

                    if(_controller.text != ''){
                      submitData['name'] = _controller.text.toString();
                      if(selectRiskUnit != '请选择分析单元'){
                        submitData['selectRiskUnit'] = selectRiskUnit;
                        if(selectRiskEvent != '请选择风险事件'){
                          submitData['selectRiskEvent'] = selectRiskEvent;
                          if(image != ''){
                            submitData['image'] = image;
                            if(describe != '' && describe != null){
                              submitData['describe'] = describe;
                              print(submitData.toString());
                            }else{
                              Fluttertoast.showToast(msg: '请输入描述');
                            }
                          }else{
                            Fluttertoast.showToast(msg: '请拍照');
                          }
                        }else{
                          Fluttertoast.showToast(msg: '请选择风险事件');
                        }
                      }else{
                        Fluttertoast.showToast(msg: '请选择分析单元');
                      }
                    }else{
                      Fluttertoast.showToast(msg: '请输入隐患名称');
                    }
                    
                    
                    
                    // print("隐患名称：" + _controller.text.toString());
                    // print("风险分析单元：" + selectRiskUnit.toString());
                    // print("风险事件：" + selectRiskEvent.toString());
                    // print("照片：" + image);
                    // print("描述：" + describe.toString());                 
                  },
                  child: Container(
                    width: size.width * 505,
                    height: size.width * 78,
                    margin: EdgeInsets.only(top: size.width * 50, bottom: size.width * 100),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg_btn_unplanned.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      '确定',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 36),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
