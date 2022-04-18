import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class AppointmentRecordReview extends StatefulWidget {
  AppointmentRecordReview({this.type, this.data});
  final String type;
  final Map data;
  @override
  State<AppointmentRecordReview> createState() =>
      _AppointmentRecordReviewState();
}

class _AppointmentRecordReviewState extends State<AppointmentRecordReview> {
  Widget _getReason() {
    if (widget.data['status'] == 2) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '审核未通过理由',
              style: TextStyle(
                  fontSize: size.width * 28, color: Color(0xFF333333)),
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
                    widget.data['result']
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width * 60,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
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
                widget.data['carryingStatus'] == 0 ? "空载" : "重载",
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
                DateTime.fromMillisecondsSinceEpoch(widget.data['createDate']).toString().substring(0, 19),
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
                DateTime.fromMillisecondsSinceEpoch(widget.data['visitingTime']).toString().substring(0, 19),
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
                  // style: TextStyle(
                  //     color: Color(0x333333),
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: size.width * 28),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.width * 30,
          ),
          _getReason()
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
                DateTime.fromMillisecondsSinceEpoch(widget.data['createDate']).toString().substring(0, 19),
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
                DateTime.fromMillisecondsSinceEpoch(widget.data['visitingTime']).toString().substring(0, 19),
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
                  // style: TextStyle(
                  //     color: Color(0x333333),
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: size.width * 28),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.width * 30,
          ),
          _getReason()
        ];
        break;
      case '人员预约':
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
                DateTime.fromMillisecondsSinceEpoch(widget.data['createDate']).toString().substring(0, 19),
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
                DateTime.fromMillisecondsSinceEpoch(widget.data['visitingTime']).toString().substring(0, 19),
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
                  widget.data['subjectMatter']
                )
              ],
            ),
          ),
          SizedBox(
            height: size.width * 30,
          ),
          _getReason()
        ];
        break;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('详情'),
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: size.width * 39),
          child: ListView(
            children: _getWidget(),
          )),
    );
  }
}
