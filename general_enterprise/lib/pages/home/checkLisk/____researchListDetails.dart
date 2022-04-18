import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResearchListDetails extends StatefulWidget {
  ResearchListDetails({this.isPrincipal, this.name, this.id});
  final int isPrincipal, id;
  final String name;
  @override
  _ResearchListDetailsState createState() => _ResearchListDetailsState();
}

class _ResearchListDetailsState extends State<ResearchListDetails> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map data = {
    "educationTrainingResources": [],
    "isParticipateAll": -1,
    "name": "",
    "sponsorName": "",
    "theme": "",
    "validTime": 0,
    "id": -1,
    "endTime": 0,
    "departmentList": [],
    "principalList": [],
    "createDate": 0,
    "isPrincipal": 0
  };

  _getData() {
    myDio.request(
        type: "get",
        url: Interface.getEducationTrainingResearchByIdTwo,
        queryParameters: {
          'id': widget.id,
          'isPrincipal': widget.isPrincipal
        }).then((value) {
      if (value is Map) {
        data = value;
        List educationTrainingResources = data['educationTrainingResources'];
        selectedClasshour = 0;
        if(educationTrainingResources.isNotEmpty){
          for (int i = 0; i < educationTrainingResources.length; i++) {
            if(educationTrainingResources[i]['whetherVote'] == 1){
              selectedClasshour += educationTrainingResources[i]['classHours'];
            }
          }
        }
      }
      setState(() {
        show = true;
      });
    });
  }

  int selectedClasshour = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.name.toString()),
      child: Transtion(
          Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 30, vertical: size.width * 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '培训需求调研主题：${data['theme']}',
                      style: TextStyle(
                          color: Color(0xff666666), fontSize: size.width * 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 15,
                    ),
                    Text(
                      widget.isPrincipal == 0
                          ? '调研发起人：${data['sponsorName']}'
                          : '培训需求调研发起人：${data['sponsorName']}',
                      style: TextStyle(
                          color: Color(0xff666666), fontSize: size.width * 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 15,
                    ),
                    widget.isPrincipal == 0
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                '调研部门: ',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 26, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (data['isParticipateAll'] == 1) {
                                    return;
                                  } else {
                                    WorkDialog.myDialog(context, () {}, 2,
                                        widget: Container(
                                            height: size.width * 600,
                                            padding: EdgeInsets.all(10),
                                            child: SingleChildScrollView(
                                              child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  runAlignment:
                                                      WrapAlignment.start,
                                                  children:
                                                      data['departmentList']
                                                          .asMap()
                                                          .keys
                                                          .map((index) =>
                                                              Container(
                                                                  width:
                                                                      size.width *
                                                                          250,
                                                                  height:
                                                                      size.width *
                                                                          50,
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          size.width *
                                                                              20),
                                                                  margin: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          size.width *
                                                                              20,
                                                                      vertical: size.width * 10),
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: placeHolder)),
                                                                  alignment: Alignment.center,
                                                                  child: Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/8691619248054_.pic_hd@2x.png',
                                                                        height:
                                                                            size.width *
                                                                                27,
                                                                        width: size.width *
                                                                            24,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            size.width *
                                                                                5,
                                                                      ),
                                                                      Expanded(
                                                                          child: Text(
                                                                              data['departmentList'][index]['name'],
                                                                              style: TextStyle(fontSize: size.width * 24, color: Color(0xff333333)),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis))
                                                                    ],
                                                                  )))
                                                          .toList()),
                                            )));
                                  }
                                },
                                child: Container(
                                  height: size.width * 34,
                                  width: size.width * 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 6))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data['isParticipateAll'] == 1
                                        ? '全厂'
                                        : '${data['departmentList'].length}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                    widget.isPrincipal == 0
                        ? Container()
                    : SizedBox(
                      height: size.width * 15,
                    ),
                    Text(
                          '问卷截止时间：${DateTime.fromMillisecondsSinceEpoch(data['endTime']).toString().substring(0, 10)}',
                          style: TextStyle(
                              color: Color(0xff666666), fontSize: size.width * 26, fontWeight: FontWeight.bold),
                        ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(size.width * 10),
                    child: RichText(
                                  text: TextSpan(
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '已选择',
                                            style: TextStyle(
                                              fontSize: size.width * 26, 
                                                color: Color(0xff404040),
                                                )),
                                        TextSpan(
                                            text: selectedClasshour.toString(),
                                            style: TextStyle(
                                              fontSize: size.width * 30,
                                                color: Color(0xff3074ff))),
                                                TextSpan(
                                            text: '课时',
                                            style: TextStyle(
                                              fontSize: size.width * 26, 
                                                color: Color(0xff404040))),
                                      ]),
                                ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: data['educationTrainingResources'].length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.width * 10,
                                horizontal: size.width * 30),
                            padding: EdgeInsets.all(size.width * 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0),
                                ]),
                            child: Row(
                              children: [
                                Image.network(
                                  data['educationTrainingResources'][index]
                                      ['coverUrl'],
                                  height: size.width * 139,
                                  width: size.width * 209,
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 400,
                                      child: Text(
                                        data['educationTrainingResources'][index]
                                            ['title'],
                                        style: TextStyle(
                                            fontSize: size.width * 28,
                                            color: Color(0xff333333),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: size.width * 300,
                                          child: Text(
                                              data['educationTrainingResources']
                                                  [index]['introduction'],
                                              style: TextStyle(
                                                fontSize: size.width * 22,
                                                color: Color(0xff999999),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        SizedBox(
                                          width: size.width * 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return ShowDialog(
                                                      child: Center(
                                                    child: Container(
                                                      height: size.width * 500,
                                                      width: size.width * 690,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      size.width *
                                                                          10))),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        20,
                                                                vertical:
                                                                    size.width *
                                                                        10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Spacer(),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Icon(
                                                                    Icons.clear,
                                                                    size:
                                                                        size.width *
                                                                            40,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Text(
                                                              data['educationTrainingResources']
                                                                      [index]
                                                                  ['title'],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          36,
                                                                  color: Color(
                                                                      0xff0059FF),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  size.width *
                                                                      30,
                                                            ),
                                                            Text(
                                                              data['educationTrainingResources']
                                                                      [index][
                                                                  'introduction'],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          30,
                                                                  color: Color(
                                                                      0xff9D9D9D)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                                });
                                          },
                                          child: Text(
                                            '[简介]',
                                            style: TextStyle(
                                                fontSize: size.width * 20,
                                                color: Color(0xff1D3DEB)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Text(
                                      '本教材包含${data['educationTrainingResources'][index]['classHours']}个课时，已学习${data['educationTrainingResources'][index]['num']}次',
                                      style: TextStyle(
                                          color: Color(0xff16CAA2),
                                          fontSize: size.width * 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: size.width * 65,
                              child: GestureDetector(
                                onTap: () {
                                  if (data['educationTrainingResources'][index]['whetherVote'] == 0) {
                                    data['educationTrainingResources'][index]['whetherVote'] = 1;
                                  } else {
                                    data['educationTrainingResources'][index]['whetherVote'] = 0;
                                  }
                                  selectedClasshour = 0;
                                  for (int i = 0; i < data['educationTrainingResources'].length; i++) {
                                    if(data['educationTrainingResources'][i]['whetherVote'] == 1){
                                      selectedClasshour = selectedClasshour + data['educationTrainingResources'][index]['classHours'];
                                    }
                                  }
                                  setState(() {});
                                },
                                child: Image.asset(
                                  data['educationTrainingResources'][index]
                                              ['whetherVote'] ==
                                          1
                                      ? 'assets/images/dui@2x.png'
                                      : 'assets/images/dui(14)@2x.png',
                                  height: size.width * 61,
                                  width: size.width * 61,
                                ),
                              ))
                        ],
                      );
                    }),
              ),
              GestureDetector(
                onTap: () {
                  List resourcesIds = [];
                  for (int i = 0; i < data['educationTrainingResources'].length; i++) {
                    if(data['educationTrainingResources'][i]['whetherVote'] == 1){
                      resourcesIds.add(data['educationTrainingResources'][i]['id']);
                    }
                  }
                  print(resourcesIds);
                  myDio.request(
                          type: 'post',
                          url: Interface.postVotingOrPicking,
                          data: {
                            'id': widget.id,
                            'isPrincipal': widget.isPrincipal,
                            'resourcesIds': resourcesIds
                          })
                      .then((value) {
                    Fluttertoast.showToast(msg: '选择教材成功');
                    Navigator.pop(myContext);
                  });
                },
                child: Container(
                  height: size.width * 60,
                  width: size.width * 240,
                  margin: EdgeInsets.symmetric(vertical: size.width * 30),
                  decoration: BoxDecoration(
                    color: Color(0xff0059FF),
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 8)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '确定',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          show),
    );
  }
}
