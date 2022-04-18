import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ParticularsVehicleRecords extends StatefulWidget {
  ParticularsVehicleRecords({this.data});
  final Map data;
  @override
  State<ParticularsVehicleRecords> createState() =>
      _ParticularsVehicleRecordsState();
}

class _ParticularsVehicleRecordsState extends State<ParticularsVehicleRecords> {
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

  // carType: 1 危化品车辆 3 内部车辆 2 普通车辆
  _getWidget() {
    switch (widget.data['carType']) {
      case 1:
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: size.width * 39),
          child: Column(
            children: [
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
                    '川A55861',
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
                    '王小泽',
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
                    '15548936225',
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
                    '张三',
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
                    '15598632145',
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
                    '硫酸',
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
                    '进入时间',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '2022/3/12 12:30',
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
                    '离开时间',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '2022/3/12 12:30',
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
                    '进入闸机',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    'A2',
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
                    '离开闸机',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    'A2',
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
              )
            ],
          ),
        );
        break;
      case 3:
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: size.width * 39),
          child: Column(
            children: [
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
                    '川A55861',
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
                    '所属部门',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '市场部',
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
                    '王小泽',
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
                    '15548936225',
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
                    '进入时间',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '2022/3/12 12:30',
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
                    '离开时间',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '2022/3/12 12:30',
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
                    '进入闸机',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    'A2',
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
                    '离开闸机',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    'A2',
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
              )
            ],
          ),
        );
        break;
      case 2:
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: size.width * 39),
          child: Column(
            children: [
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
                    '川A55861',
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
                    '张三',
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
                    '15546328991',
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
                    '进园时间',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '2022/3/12 12:30',
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
                    '离园时间',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    '2022/3/12 12:30',
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
                    '进入闸机',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    'A2',
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
                    '离开闸机',
                    style: TextStyle(
                        fontSize: size.width * 28, color: Color(0xFF333333)),
                  ),
                  Text(
                    'A2',
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
              )
            ],
          ),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(title: Text("详情"), child: _getWidget());
  }
}
