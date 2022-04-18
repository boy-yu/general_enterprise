import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_flutter/qr_flutter.dart';

class OfflineStudyPlan extends StatefulWidget {
  OfflineStudyPlan({this.type});
  final int type;
  @override
  _OfflineStudyPlanState createState() => _OfflineStudyPlanState();
}

class _OfflineStudyPlanState extends State<OfflineStudyPlan> {
  _getButton(int status, int id, int stage) {
    switch (status) {
      case 0:
        return InkWell(
            onTap: () async {
              await Permission.camera.request();
              String barcode = await scanner.scan();
              if (barcode is String && barcode != null) {
                if (barcode == currentDate) {
                  myDio.request(
                      type: 'post',
                      url: Interface.postOfflinePlanSignIn,
                      queryParameters: {
                        "id": id,
                        "stage": stage,
                        "isYear": widget.type
                      }).then((value) {
                    successToast('签到成功');
                    _throwFunc.run();
                  });
                }
              }
            },
            child: Container(
                height: size.width * 40,
                width: size.width * 119,
                decoration: BoxDecoration(
                  color: Color(0xff3869FC),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 4)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '扫码签到',
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 20),
                )));
        break;
      case 1:
        return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ShowDialog(
                        child: Center(
                      child: Container(
                        height: size.width * 700,
                        width: size.width * 690,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 20,
                              vertical: size.width * 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: size.width * 40,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '签到二维码',
                                style: TextStyle(
                                    fontSize: size.width * 36,
                                    color: Color(0xff0059FF),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: size.width * 30,
                              ),
                              QrImage(
                                data: currentDate,
                                size: 200.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  });
            },
            child: Container(
                height: size.width * 40,
                width: size.width * 119,
                decoration: BoxDecoration(
                  color: Color(0xff3869FC),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 4)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '签到二维码',
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 20),
                )));
        break;
      default:
        return Container();
    }
  }

  String currentDate;

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    currentDate = dateTime.year.toString() +
        '-' +
        dateTime.month.toString() +
        '-' +
        dateTime.day.toString();
  }

  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('现场学习计划'),
      child: Container(
        color: Colors.white,
        child: MyRefres(
            child: (index, list) => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 8)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1.0,
                            blurRadius: 1.0)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: size.width * 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_mylist_edu_twolist.png',
                                      width: size.width * 90,
                                      height: size.width * 90,
                                    ),
                                    SizedBox(
                                      width: size.width * 25,
                                    ),
                                    Container(
                                      width: size.width * 350,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              list[index]['title'],
                                              style: TextStyle(
                                                  color: Color(0xff404040),
                                                  fontSize: size.width * 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: size.width * 15,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 22),
                                                  children: [
                                                    TextSpan(
                                                        text: "发起人： ",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff404040))),
                                                    TextSpan(
                                                        text: list[index]
                                                            ['sponsorName'],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff3074FF))),
                                                  ]),
                                            )
                                          ]),
                                    ),
                                    Spacer(),
                                    _getButton(
                                        list[index]['status'],
                                        list[index]['id'],
                                        list[index]['stage']),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: size.width * 12,
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '学习计划内容：' + list[index]['content'],
                                        style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 20),
                                        maxLines: list[index]['unfold'] == null
                                            ? 2
                                            : 10,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (list[index]['unfold'] == null) {
                                          list[index]['unfold'] = 1;
                                        } else {
                                          list[index]['unfold'] = null;
                                        }
                                        setState(() {});
                                      },
                                      child: Text(
                                        list[index]['unfold'] == null
                                            ? '[展开]'
                                            : '[收起]',
                                        style: TextStyle(
                                              color: Color(0xff3074FF),
                                              fontSize: size.width * 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: size.width * 1,
                                  color: Color(0xffE8E8E8),
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.width * 12),
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '培训开始时间：',
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 5,
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(list[index]['startDate']).toString().substring(0, 19),
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '培训结束时间：',
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 5,
                                            ),
                                            Text(
                                              DateTime.fromMillisecondsSinceEpoch(list[index]['endDate']).toString().substring(0, 19),
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '学时：',
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                              list[index]['classHours'].toString() + '学时',
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: size.width * 20),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: '培训地点：',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff404040),
                                                            fontWeight: FontWeight.bold)),
                                                TextSpan(
                                                    text: list[index]
                                                            ['trainingLocation']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff404040))),
                                              ]),
                                        )
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
            // data: data,
            // type: '风险不受控',
            listParam: "records",
            throwFunc: _throwFunc,
            page: true,
            url: Interface.getEducationTrainingOfflinePlanListByUserId,
            queryParameters: {"isYear": widget.type},
            method: 'get'),
      ),
    );
  }
}
