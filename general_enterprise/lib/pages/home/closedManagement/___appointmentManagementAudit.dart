import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/closedManagement/myView/myRefuseDialog.dart';
import 'package:enterprise/pages/home/closedManagement/myView/mySureDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentManagementAudit extends StatefulWidget {
  AppointmentManagementAudit({
    this.type,
    this.data,
    this.gateList,
  });
  final String type;
  final Map data;
  final List gateList;
  @override
  State<AppointmentManagementAudit> createState() =>
      _AppointmentManagementAuditState();
}

class _AppointmentManagementAuditState
    extends State<AppointmentManagementAudit> {
  void initState() {
    super.initState();
    print(widget.data);
  }

  List<Widget> _getWidget() {
    switch (widget.type) {
      case '危化品车辆':
        return [
          SizedBox(
            height: size.width * 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '车牌号',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['carNo'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '驾驶员姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['name'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '驾驶员电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['telephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '押运员姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['supercargoName'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '押运员电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['supercargoTelephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '危险化学品名称',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['hazardousMaterial'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '运载状态',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['carryingStatus'] == 0 ? '空载' : '重载',
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '申请时间',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(widget.data['createDate'])
                    .toString()
                    .substring(0, 19),
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '对接人姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['oppositePerson'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '对接人电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['oppositeTelephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '预计来访时间',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(widget.data['visitingTime'])
                    .toString()
                    .substring(0, 19),
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '来访事由',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 30,
          ),
          Container(
            height: size.width * 130,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xFFEEEEEE),
                  style: BorderStyle.solid,
                  width: size.width * 1),
            ),
            child: ListView(
              children: [
                Text(
                  widget.data['subjectMatter'],
                  style: TextStyle(
                      color: Color(0xff333333), fontSize: size.width * 28),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.width * 62,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  MyRefuseDialog.myRefuseDialog(context, (strReason) {
                    if (strReason == "") {
                      Fluttertoast.showToast(msg: "请填写未通过原因");
                    } else {
                      Map submitData = {
                        "deviceSns": [],
                        "equipmentId": [],
                        "id": widget.data['id'],
                        "isPass": 0,
                        "result": strReason,
                        "type": 2
                      };
                      myDio
                          .request(
                              type: 'put',
                              url: Interface.putSubscribeApproval,
                              data: submitData)
                          .then((value) {
                        successToast('审批完成');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 65, vertical: size.width * 19),
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5454),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    '拒绝',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 26),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 79,
              ),
              GestureDetector(
                onTap: () {
                  MySureDialog.mySureDialog(context, () {
                    Navigator.of(context).pop();
                  }, widget.gateList, 2, widget.data['id']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 65, vertical: size.width * 19),
                  decoration: BoxDecoration(
                      color: Color(0xFF3072FE),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    '通过',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 26),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 62,
          ),
        ];
        break;
      case '普通车辆':
        return [
          SizedBox(
            height: size.width * 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '车牌号',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['carNo'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '驾驶员姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['name'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '驾驶员电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['telephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '申请时间',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(widget.data['createDate'])
                    .toString()
                    .substring(0, 19),
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '对接人姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['oppositePerson'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '对接人电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['oppositeTelephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '预计来访时间',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(widget.data['visitingTime'])
                    .toString()
                    .substring(0, 19),
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            children: [
              Text(
                '来访事由',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 30,
          ),
          Container(
            height: size.width * 130,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xFFEEEEEE),
                  style: BorderStyle.solid,
                  width: size.width * 1),
            ),
            child: ListView(
              children: [
                Text(
                  widget.data['subjectMatter'],
                  style: TextStyle(
                      color: Color(0xff333333), fontSize: size.width * 28),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.width * 62,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  MyRefuseDialog.myRefuseDialog(context, (strReason) {
                    if (strReason == "") {
                      Fluttertoast.showToast(msg: "请填写未通过原因");
                    } else {
                      Map submitData = {
                        "deviceSns": [],
                        "equipmentId": [],
                        "id": widget.data['id'],
                        "isPass": 0,
                        "result": strReason,
                        "type": 2
                      };
                      myDio
                          .request(
                              type: 'put',
                              url: Interface.putSubscribeApproval,
                              data: submitData)
                          .then((value) {
                        successToast('审批完成');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 65, vertical: size.width * 19),
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5454),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    '拒绝',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 26),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 79,
              ),
              GestureDetector(
                onTap: () {
                  MySureDialog.mySureDialog(context, () {
                    Navigator.of(context).pop();
                  }, widget.gateList, 2, widget.data['id']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 65, vertical: size.width * 19),
                  decoration: BoxDecoration(
                      color: Color(0xFF3072FE),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    '通过',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 26),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 62,
          ),
        ];
        break;
      case '内部人员':
        return [
          SizedBox(
            height: size.width * 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['name'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['telephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '申请时间',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(widget.data['createDate'])
                    .toString()
                    .substring(0, 19),
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '对接人姓名',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['oppositePerson'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '对接人电话',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                widget.data['oppositeTelephone'],
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '预计来访时间',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(widget.data['visitingTime'])
                    .toString()
                    .substring(0, 19),
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.symmetric(vertical: size.width * 29),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '来访事由',
                style: TextStyle(
                    fontSize: size.width * 28, color: Color(0xFF333333)),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 30,
          ),
          Container(
            height: size.width * 130,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xFFEEEEEE),
                  style: BorderStyle.solid,
                  width: size.width * 1),
            ),
            child: ListView(
              children: [
                Text(
                  widget.data['subjectMatter'],
                  style: TextStyle(
                      color: Color(0xff333333), fontSize: size.width * 28),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.width * 62,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  MyRefuseDialog.myRefuseDialog(context, (strReason) {
                    if (strReason == "") {
                      Fluttertoast.showToast(msg: "请填写未通过原因");
                    } else {
                      Map submitData = {
                        "deviceSns": [],
                        "equipmentId": [],
                        "id": widget.data['id'],
                        "isPass": 0,
                        "result": strReason,
                        "type": 1
                      };
                      myDio
                          .request(
                              type: 'put',
                              url: Interface.putSubscribeApproval,
                              data: submitData)
                          .then((value) {
                        successToast('审批完成');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 65, vertical: size.width * 19),
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5454),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    '拒绝',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 26),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 79,
              ),
              GestureDetector(
                onTap: () {
                  MySureDialog.mySureDialog(context, () {
                    Navigator.of(context).pop();
                  }, widget.gateList, 1, widget.data['id']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 65, vertical: size.width * 19),
                  decoration: BoxDecoration(
                      color: Color(0xFF3072FE),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    '通过',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 26),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 62,
          ),
        ];
        break;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('审核'),
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 39),
          children: _getWidget(),
        ),
      ),
    );
  }
}
