import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WaitWorkRiskIdentify extends StatefulWidget {
  WaitWorkRiskIdentify({@required this.arguments});
  final arguments;
  // message : last page
  // title
  // listId : own last  choose id List  [{workType: 高处作业, workHazardIdentificationsIds: [23], resultList: []}]
  // bookId int    need sumbit ID
  /*  message format
    [
		{
			"workType": "",
			"resultList": [],
			"resultList": [
				{
					"id": 0,
					"content": "",
					"hazardId": 0,
					"createDate": "",
					"modifyDate": ""
				}
			]
		}
	],
  */
  @override
  _WaitWorkRiskIdentifyState createState() => _WaitWorkRiskIdentifyState();
}

class _WaitWorkRiskIdentifyState extends State<WaitWorkRiskIdentify> {
  List<String> choose = [
    '作业类型',
    '动火作业',
    '动土作业',
    '高处作业',
  ];
  int chooseIndex = 0;
  List<bool> allChoose = [false];
  List chooseId = [[]];
  List data = [];
  List submitList = [];
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    choose = [];
    allChoose = [];
    if (widget.arguments['message'] is List) {
      data = widget.arguments['message'];
      widget.arguments['message'].forEach((ele) {
        choose.add(ele['workType']);
        allChoose.add(false);
      });
      if (choose.length > 0) {
        chooseId = [];
        for (var i = 0; i < choose.length; i++) {
          chooseId.add([]);
          for (var _i = 0; _i < data[i]['resultList'].length; _i++) {
            chooseId[i].add(false);
          }
        }
      }
    }
  }

  _sumbitList(Counter _context) {
    submitList = [];
    choose.forEach((element) {
      if (widget.arguments['title'] == '安全措施') {
        submitList.add({
          "workType": element,
          "workSafetyMeasuresIds": [],
          "resultList": []
        });
      } else if (widget.arguments['title'] == '危害识别') {
        submitList.add({
          "workType": element,
          "workHazardIdentificationsIds": [],
          "resultList": []
        });
      }
    });
    for (var i = 0; i < submitList.length; i++) {
      for (var _i = 0; _i < chooseId[i].length; _i++) {
        if (chooseId[i][_i]) {
          // print(i.toString() + ':' + _i.toString());
          if (widget.arguments['title'] == '安全措施') {
            submitList[i]['workSafetyMeasuresIds']
                .add(data[i]['resultList'][_i]['id']);
          } else if (widget.arguments['title'] == '危害识别') {
            submitList[i]['workHazardIdentificationsIds']
                .add(data[i]['resultList'][_i]['id']);
          }
        }
      }
    }
    if (widget.arguments['title'] == '安全措施') {
      myDio.request(
        type: 'post',
        url: Interface.postSubmitRiskIdentification,
        data: {
          "bookId": widget.arguments['bookId'].toString(),
          "hazardIdentificationResultVos": widget.arguments['idList'],
          "securityMeasuresResultVos": submitList
        },
      ).then((value) {
        Fluttertoast.showToast(msg: '添加辨识成功');
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      myDio.request(
          type: 'post',
          url: Interface.postGnerateSecurityMeasures,
          data: {"hazardIdentificationResultVos": submitList}).then((value) {
        if (value is List) {
          Navigator.pushNamed(
              context, '/index/waitWork/riskControl/riskIdentify',
              arguments: {
                "message": value,
                "title": '安全措施',
                "idList": submitList,
                "bookId": widget.arguments['bookId']
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return MyAppbar(
      title: Text(widget.arguments['title'].toString()),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(size.width * 20),
            child: Row(
              children: [
                PopupMenuButton(
                  onSelected: (value) {
                    chooseIndex = value;
                    setState(() {});
                  },
                  itemBuilder: (BuildContext context) => choose
                      .asMap()
                      .keys
                      .map<PopupMenuItem>((index) => PopupMenuItem(
                          value: index,
                          child: Center(
                              child: Text(choose[index].toString(),
                                  style: TextStyle(
                                      color: chooseIndex == index
                                          ? themeColor
                                          : Colors.black,
                                      fontSize: size.width * 26)))))
                      .toList(),
                  child: Text(
                    choose[chooseIndex],
                    style: TextStyle(
                        fontSize: size.width * 30,
                        color: Colors.black.withOpacity(.4)),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.play_arrow,
                    size: size.width * 30,
                    color: Color(0xffD4DCEF),
                  ),
                ),
                Spacer(),
                Text(
                  '全选',
                  style: TextStyle(
                      fontSize: size.width * 30,
                      color: Colors.black.withOpacity(.4)),
                ),
                Container(
                  margin: EdgeInsets.only(left: size.width * 20),
                  width: size.width * 40,
                  height: size.width * 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder(
                            side: BorderSide(
                                width: 1, color: Color(0xffD4DCEF)))),
                        backgroundColor: MaterialStateProperty.all(
                            allChoose[chooseIndex]
                                ? themeColor
                                : backgroundBg)),
                    onPressed: () {
                      allChoose[chooseIndex] = !allChoose[chooseIndex];
                      for (var i = 0; i < chooseId[chooseIndex].length; i++) {
                        chooseId[chooseIndex][i] = allChoose[chooseIndex];
                      }
                      setState(() {});
                    },
                    child: allChoose[chooseIndex]
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: size.width * 30,
                          )
                        : Container(),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.width * 10)),
                  padding: EdgeInsets.all(size.width * 20),
                  margin: EdgeInsets.all(size.width * 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(data[chooseIndex]['resultList'][index]
                                  ['content']
                              .toString())),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 20),
                        width: size.width * 40,
                        height: size.width * 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(CircleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xffD4DCEF)))),
                              backgroundColor: MaterialStateProperty.all(
                                  chooseId[chooseIndex][index]
                                      ? themeColor
                                      : backgroundBg)),
                          onPressed: () {
                            chooseId[chooseIndex][index] =
                                !chooseId[chooseIndex][index];
                            setState(() {});
                          },
                          child: chooseId[chooseIndex][index]
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: size.width * 30,
                                )
                              : Container(),
                        ),
                      )
                    ],
                  ));
            },
            itemCount: chooseId[chooseIndex].length,
          )),
          GestureDetector(
            onTap: () {
              _sumbitList(_context);
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size.height * 20),
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: lineGradBlue)),
              child: Text(
                widget.arguments['title'] == '安全措施' ? '完成' : '生成安全措施',
                style:
                    TextStyle(color: Colors.white, fontSize: size.width * 32),
              ),
            ),
          )
        ],
      ),
    );
  }
}
