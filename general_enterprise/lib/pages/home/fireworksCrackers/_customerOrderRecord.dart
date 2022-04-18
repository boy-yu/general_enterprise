import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomerOrderRecord extends StatefulWidget {
  @override
  _CustomerOrderRecordState createState() => _CustomerOrderRecordState();
}

class _CustomerOrderRecordState extends State<CustomerOrderRecord> {
  void _textFieldChanged(String str) {
    // queryParameters = {'keywords': str};
    string = str;
    // _throwFunc.run(argument: {'keywords': str});
    if(startDate != null && endDate != null){
      _throwFunc.run(argument: {
        'startDate': startDate.toString().substring(0, 10),
        'endDate': endDate.toString().substring(0, 10),
        'keywords': string,
      });
    }else{
      _throwFunc.run(argument: {'keywords': string});
    }
  }

  DateTime startDate;
  DateTime endDate;

  ThrowFunc _throwFunc = new ThrowFunc();

  String string = '';
  // Map queryParameters;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.width * 30),
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
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    width: size.width * 275,
                    height: size.width * 84,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffD2D2D2), width: size.width * 1),
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 10))),
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
                        if(string != ''){
                          _throwFunc.run(argument: {
                            'startDate': startDate.toString().substring(0, 10),
                            'endDate': endDate.toString().substring(0, 10),
                            'keywords': string,
                          });
                          setState(() {});
                        }else{
                          _throwFunc.run(argument: {
                            'startDate': startDate.toString().substring(0, 10),
                            'endDate': endDate.toString().substring(0, 10)
                          });
                          setState(() {});
                        }
                      }
                    });
                    }
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    width: size.width * 275,
                    height: size.width * 84,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffD2D2D2), width: size.width * 1),
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 10))),
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
          Container(
            height: size.width * 76,
            margin: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
            decoration: BoxDecoration(
              color: Color(0xffFAFAFB),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              border:
                  Border.all(width: size.width * 4, color: Color(0xffF0F0F2)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 30,
                ),
                Image.asset(
                  "assets/images/sousuo@2x.png",
                  height: size.width * 28,
                  width: size.width * 28,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: size.width * 20, bottom: size.width * 40),
                      hintText: '请输入姓名/电话/出库编码',
                      hintStyle: TextStyle(
                          color: Color(0xffACACBC), fontSize: size.width * 24),
                      border: InputBorder.none,
                    ),
                    onChanged: _textFieldChanged,
                    autofocus: false,
                    // textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: size.width * 20,
            color: Color(0xfff7f7f7),
            width: double.infinity,
          ),
          Expanded(child: MyRefres(
          child: (index, data) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/fireworksCrackers/orderFormDetails",
                      arguments: {
                        'id': data[index]['id']
                      }
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 10)),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
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
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Text(
                                '客户：${data[index]['clientName']}(${data[index]['clientTelephone']})',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.bold), 
                              ),
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
                                    width: size.width * 300,
                                    child: Text(
                                    '出库人：' + (data[index]['consigner'] == '' ? '无' : data[index]['consigner'].toString()) + '(${data[index]['consignerTelephone']})',
                                    style: TextStyle(
                                        color: Color(0xff848484),
                                        fontSize: size.width * 22),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                  ),
                                  ),
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
                                          text: '出库总量：',
                                          style: TextStyle(
                                              color: Color(0xff3073FE))),
                                      TextSpan(
                                          text: data[index]['num']
                                                  .toString() +
                                              '件',
                                          style: TextStyle(
                                              color: Color(0xff333333))),
                                    ]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          listParam: "records",
          page: true,
          url: Interface.getCustomerList,
          throwFunc: _throwFunc,
          // queryParameters: queryParameters,
          method: 'get'),)
        ],
      ),
    );
  }
}
