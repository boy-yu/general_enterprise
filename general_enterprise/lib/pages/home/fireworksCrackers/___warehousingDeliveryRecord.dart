import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WarehousingDeliveryRecord extends StatefulWidget {
  WarehousingDeliveryRecord({this.id});
  final int id;
  @override
  _WarehousingDeliveryRecordState createState() => _WarehousingDeliveryRecordState();
}

class _WarehousingDeliveryRecordState extends State<WarehousingDeliveryRecord> {
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate(){
    myDio.request(
      type: 'get', 
      url: Interface.getWarehousingShippmentRecordByWarehouseId, 
      queryParameters: {
        'id': widget.id,
    }).then((value) {
      data = value;
      setState(() {});
    });
  }

  List data = [];

  String _getDetail(List list){
    String result;
    for (int i = 0; i < list.length; i++) {
      result = list[i]['name'].toString() + '出库 ' + list[i]['num'].toString() + '件  ';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('仓库出库记录'),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: size.width * 164,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDatePickerMode: DatePickerMode.day,
                            initialDate: DateTime.now().toLocal(),
                            firstDate:
                                DateTime(DateTime.now().toLocal().year - 30),
                            lastDate:
                                DateTime(DateTime.now().toLocal().year + 30))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          startDate = value;
                        });
                      }
                    });
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 20),
                      width: size.width * 335,
                      height: size.width * 84,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xffD2D2D2), width: size.width * 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 10))),
                      child: Row(
                        children: [
                          Text(
                            startDate != null
                                ? startDate.toString().split(' ')[0]
                                : '开始日期',
                            style: TextStyle(color: Color(0xff898989)),
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/images/date.png",
                            width: size.width * 49,
                            height: size.width * 43,
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    if(startDate == null){
                      Fluttertoast.showToast(msg: '请先选择开始时间');
                    }else{
                      showDatePicker(
                            context: context,
                            initialDatePickerMode: DatePickerMode.day,
                            initialDate: DateTime.now().toLocal(),
                            firstDate:
                                DateTime(DateTime.now().toLocal().year - 30),
                            lastDate:
                                DateTime(DateTime.now().toLocal().year + 30))
                        .then((value) {
                      if (value != null) {
                        endDate = value;
                        myDio.request(
                          type: 'get', 
                          url: Interface.getWarehousingShippmentRecordByWarehouseId, 
                          queryParameters: {
                            'id': widget.id,
                            'startDate': startDate.toString().substring(0, 10),
                            'endDate': endDate.toString().substring(0, 10)
                        }).then((value) {
                          data = value;
                          setState(() {});                                       
                        });
                      }
                    });
                    }
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 20),
                      width: size.width * 335,
                      height: size.width * 84,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xffD2D2D2), width: size.width * 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 10))),
                      child: Row(
                        children: [
                          Text(
                            endDate != null
                                ? endDate.toString().split(' ')[0]
                                : '结束日期',
                            style: TextStyle(color: Color(0xff898989)),
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/images/date.png",
                            width: size.width * 49,
                            height: size.width * 43,
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: data.isNotEmpty ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.width * 15,
                          horizontal: size.width * 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 1.0,
                                spreadRadius: 1.0)
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 15,
                                horizontal: size.width * 20),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 400,
                                  child: Text(
                                  '客户：${data[index]['clientName']}(${data[index]['clientTelephone']})',
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis
                                ),
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * 60,
                                  height: size.width * 31,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3172FE).withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 6))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '编号',
                                    style: TextStyle(
                                        color: Color(0xff3172FE),
                                        fontSize: size.width * 20),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 5,
                                ),
                                Text(
                                  data[index]['orderNumber'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 22),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: size.width * 1,
                            width: double.infinity,
                            color: Color(0xfff0f0f0),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 15,
                                horizontal: size.width * 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: size.width * 400,
                                      child: 
                                    Text(
                                      '出库人：${data[index]['consigner']}(${data[index]['consignerTelephone']})',
                                      style: TextStyle(
                                          color: Color(0xff848484),
                                          fontSize: size.width * 22),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis
                                    ),),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/shijian@2x.png",
                                          width: size.width * 22,
                                          height: size.width * 22,
                                        ),
                                        SizedBox(
                                          width: size.width * 10,
                                        ),
                                        Text(
                                          data[index]['deliveryTime'],
                                          style: TextStyle(
                                              fontSize: size.width * 22,
                                              color: Color(0xff848484)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.width * 15,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: size.width * 20,
                                          fontWeight: FontWeight.bold),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '出库明细：',
                                            style: TextStyle(
                                                color: Color(0xff3073FE))),
                                        TextSpan(
                                            text: _getDetail(data[index]['detail']),
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                      ]),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }) : Container(),
            ),
          )
        ],
      ),
    );
  }
}
