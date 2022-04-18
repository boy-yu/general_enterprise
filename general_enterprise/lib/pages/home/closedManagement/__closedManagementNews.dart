import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ClosedManagementNews extends StatefulWidget {
  @override
  State<ClosedManagementNews> createState() => _ClosedManagementNewsState();
}

class _ClosedManagementNewsState extends State<ClosedManagementNews> {
  List data = [
    {
      "title": "业务办理通知",
      "approvalDate": "2022.3.15  9:20",
      "content": "您好！您申请的预约已审核成功，请按时到达现场",
      "applyDate": "2022.3.15  9:20",
      "state": 1 // 1：通过， 2：未通过
    },
    {
      "title": "业务办理通知",
      "approvalDate": "2022.3.15  9:20",
      "content": "您好！您申请的预约审核失败",
      "applyDate": "2022.3.15  9:20",
      "state": 2, // 1：通过， 2：未通过
      "noPassReason": "八零八零零八零零八零"
    },
    {
      "title": "业务办理通知",
      "approvalDate": "2022.3.15  9:20",
      "content": "您好！您申请的预约已审核成功，请按时到达现场",
      "applyDate": "2022.3.15  9:20",
      "state": 1 // 1：通过， 2：未通过
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 10, horizontal: size.width * 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10))),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(size.width * 20),
                        child: Image.asset(
                          data[index]['state'] == 1
                              ? 'assets/images/tg@2x.png'
                              : 'assets/images/wtg@2x.png',
                          height: size.width * 140,
                          width: size.width * 186,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Row(
                          children: [
                            Text(
                              data[index]['title'],
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/images/icon_msg_date.png',
                              height: size.width * 30,
                              width: size.width * 30,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Text(
                              data[index]['approvalDate'],
                              style: TextStyle(
                                  color: Color(0xff7F8E9D),
                                  fontSize: size.width * 24),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        color: Color(0xffEEEEEE),
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['content'],
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 24),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              "申请时间：${data[index]['applyDate']}",
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 24),
                            ),
                            data[index]['state'] == 1
                                ? Container()
                                : SizedBox(
                                    height: size.width * 10,
                                  ),
                            data[index]['state'] == 1
                                ? Container()
                                : Text(
                                    "未通过理由：${data[index]['noPassReason']}",
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 24),
                                  ),
                            data[index]['state'] == 1
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      print("object");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.width * 10),
                                      child: Text(
                                        "点击此处再次发起车辆预约申请",
                                        style: TextStyle(
                                          color: Color(0xffFF6934),
                                          decoration: TextDecoration.underline,
                                          fontSize: size.width * 24,
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
        // page: true,
        // url: Interface.getRiskUnitList,
        // listParam: "records",
        // method: 'get'
        data: data);
  }
}
