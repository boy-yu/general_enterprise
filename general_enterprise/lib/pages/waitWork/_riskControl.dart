import 'package:enterprise/common/customChoose.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class WaitRiskControl extends StatefulWidget {
  WaitRiskControl({this.arguments});
  final arguments;
  @override
  _WaitRiskControlState createState() => _WaitRiskControlState();
}

class _WaitRiskControlState extends State<WaitRiskControl> {
  List data = [
    {
      "title": '动火作业',
      'way': [
        {
          'title': '环境因素',
          'value': '',
          'url': Interface.generateHazardIdentification,
          'type': 'post'
        },
        {
          'title': '作业方式',
          'value': '',
          'url': Interface.getWorkWayListAll,
          'type': 'get'
        }
      ]
    }
  ];
  List submitList = [];
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    if (widget.arguments != null) {
      data = [];
      widget.arguments['message']['workTypes'].forEach((ele) {
        data.add({
          "title": ele,
          'way': [
            {
              'title': '环境因素',
              'value': '',
              'idList': [],
              'valueList': [],
              'url': Interface.getWorkEnvirnmentalFatorTree,
              'type': 'get'
            },
            {
              'title': '作业方式',
              'value': '',
              'idList': [],
              'valueList': [],
              'url': Interface.getWorkWayListAll,
              'type': 'get'
            }
          ]
        });
        submitList.add({"workType": ele, "envirnmentalIds": [], "wayIds": []});
      });
    }
  }

  _sumbitList() {
    for (var i = 0; i < data.length; i++) {
      if (data[i]['title'] == submitList[i]['workType']) {
        data[i]['way'].forEach((ele) {
          if (ele['title'] == '环境因素') {
            submitList[i]['envirnmentalIds'] = ele['idList'];
          } else if (data[i]['title'] == '作业方式') {
            submitList[i]['wayIds'] = ele['idList'];
          }
        });
      }
    }
    myDio.request(
        type: 'post',
        url: Interface.generateHazardIdentification,
        data: {"generateHazardIdentificationVos": submitList}).then((value) {
      if (value is List) {
        Navigator.pushNamed(context, '/index/waitWork/riskControl/riskIdentify',
            arguments: {
              "message": value,
              "title": '危害识别',
              'listId': [],
              'bookId': widget.arguments['message']['bookId']
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      title: Text('风险辨识'),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: width * 30, horizontal: width * 20),
              itemBuilder: (context, index) {
                _emptyFun() {
                  for (var i = 0; i < data[index]['way'].length; i++) {
                    data[index]['way'][i]['idList'] = [];
                    data[index]['way'][i]['valueList'] = [];
                  }
                }

                return Container(
                  padding: EdgeInsets.all(width * 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: underColor.withOpacity(0.4)))),
                        padding: EdgeInsets.only(
                            left: width * 24,
                            right: width * 20,
                            bottom: width * 20),
                        child: Text(
                          data[index]['title'].toString(),
                          style: TextStyle(
                              fontSize: width * 30,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      for (var item in data[index]['way'])
                        WaitRiskControlChoose(
                            item, item['idList'], item['valueList'], _emptyFun)
                    ],
                  ),
                );
              },
              itemCount: data.length,
            ),
          ),
          GestureDetector(
            onTap: _sumbitList,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size.height * 20),
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: lineGradBlue)),
              child: Text(
                '生成危害识别',
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

class WaitRiskControlChoose extends StatefulWidget {
  WaitRiskControlChoose(this.data, this.idList, this.valueList, this.emptyFun);
  final Map data;
  final List idList; // idList
  final List valueList;
  final Function emptyFun;
  @override
  _WaitRiskControlChooseState createState() => _WaitRiskControlChooseState();
}

class _WaitRiskControlChooseState extends State<WaitRiskControlChoose> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
            context: context,
            builder: (_) {
              widget.emptyFun();
              return PopFrame(
                  changeValue: (String msg) {
                    widget.data['value'] = msg;
                    setState(() {});
                  },
                  idList: widget.idList,
                  valueList: widget.valueList,
                  data: widget.data);
            });
      },
      child: Container(
        margin: EdgeInsets.only(top: size.width * 30),
        child: Row(
          children: [
            Text(
              widget.data['title'],
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            SizedBox(
              width: size.width * 20,
            ),
            Expanded(
              child: Text(
                widget.data['value'].toString() == ''
                    ? '请选择${widget.data['title']}'
                    : widget.data['value'].toString(),
                style: TextStyle(
                    color: widget.data['value'].toString() == ''
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black),
              ),
            ),
            // Spacer(),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}

class PopFrame extends StatefulWidget {
  PopFrame(
      {@required this.changeValue,
      @required this.idList,
      @required this.valueList,
      @required this.data});
  final Function changeValue;
  final List idList, valueList;
  final Map data;
  @override
  _PopFrameState createState() => _PopFrameState();
}

class _PopFrameState extends State<PopFrame> {
  List data = [];
  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() {
    myDio
        .request(type: 'get', url: Interface.getWorkEnvirnmentalFatorTree)
        .then((value) {
      if (value is List) {
        data = value;
      }
      setState(() {});
    });

    // myDio.get(Interface.getWorkEnvirnmentalFatorTree).then((value) {
    //   if (value is List) {
    //     data = value;
    //   }
    //   setState(() {});
    // }).catchError((onError) {
    //   Interface().error(onError, context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size.width * 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          ),
          data.length > 0
              ? Expanded(
                  child: ListView.builder(
                  itemBuilder: (context, index) {
                    return RecursionTree(
                        data: data,
                        idList: widget.idList,
                        valueList: widget.valueList);
                  },
                  itemCount: 1,
                ))
              : Container(),
          Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 20),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              autofocus: true,
              onPressed: () {
                // temp = [];
                // _resousion(data);
                String tempString = '';
                for (var i = 0; i < widget.valueList.length; i++) {
                  if (i == widget.valueList.length - 1) {
                    tempString += widget.valueList[i];
                  } else {
                    tempString += widget.valueList[i] + '|';
                  }
                }
                widget.changeValue(tempString);
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          )
        ],
      ),
    );
  }
}

class RecursionTree extends StatefulWidget {
  RecursionTree(
      {this.title,
      @required this.data,
      @required this.idList,
      @required this.valueList});
  final List data, idList, valueList;
  final String title;
  @override
  _RecursionTreeState createState() => _RecursionTreeState();
}

class _RecursionTreeState extends State<RecursionTree> {
  String temp = '';
  List<int> seleted = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title == null ? '环境因素' : widget.title,
          style: TextStyle(
            fontSize: size.width * 30,
          ),
        ),
        CustomChoose(
          physic: true,
          ownData: widget.data,
          msg: '',
          type: CustomChooseType.mutipleDrop,
          seleted: seleted,
          chooseUI: true,
          chooseUIBack: (int id, String msg, bool addtion) {
            if (!addtion) {
              widget.idList.remove(id);
              widget.valueList.remove(msg);
            } else {
              widget.idList.add(id);
              widget.valueList.add(msg);
            }
          },
          callback: (int i, String msg) {
            // reason msg end has |
            if (msg != '') {
              msg = msg.substring(0, msg.length - 1);
            }

            widget.data[0]['value'] = msg;
            setState(() {});
          },
          chooseColor: Color(0xff39AC6A),
          borderRadius: 38,
        ),
        widget.data[0]['value'] != null
            ? Column(
                children: widget.data.map((ele) {
                  List tempSplit =
                      widget.data[0]['value'].toString().split('|');
                  if (tempSplit.indexOf(ele['name']) > -1) {
                    if (ele['children'] != null) {
                      return RecursionTree(
                        valueList: widget.valueList,
                        idList: widget.idList,
                        data: ele['children'],
                        title: ele['name'],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                }).toList(),
              )
            : Container()
      ],
    );
  }
}
