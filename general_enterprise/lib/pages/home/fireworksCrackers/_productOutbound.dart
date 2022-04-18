import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ProductOutbound extends StatefulWidget {
  @override
  _ProductOutboundState createState() => _ProductOutboundState();
}

class _ProductOutboundState extends State<ProductOutbound> {
  void _textNameChanged(String str) {
    clientName = str;
  }

  void _textPhoneChanged(String str) {
    clientTelephone = str;
  }

  String clientName = '';
  String clientTelephone = '';

  List data = [];

  dynamic _value;

  List<DropdownMenuItem> items = [];

  List warehouseList = [];

  @override
  void initState() {
    super.initState();
    _getWarehouseList();
  }

  _getWarehouseList() {
    myDio
        .request(
      type: 'get',
      url: Interface.getWarehousingWarehouseList,
    )
        .then((value) {
      if (value is List) {
        warehouseList = value;
        if (warehouseList.isNotEmpty) {
          items = [];
          for (int i = 0; i < warehouseList.length; i++) {
            items.add(DropdownMenuItem(
                child: Text(
                  warehouseList[i]['name'],
                  style: TextStyle(color: Colors.black),
                ),
                value: {
                  'id': warehouseList[i]['id'],
                  'name': warehouseList[i]['name']
                }));
          }
        }
        setState(() {});
      }
    });
  }

  String barcode;

  int inStockNum = 0;
  int textProductNum = 0;

  void _textProductNum(String str) {
    textProductNum = int.parse(str);
  }

  Map submitData = {
    "clientName": "",
    "clientTelephone": "",
    "deliveryVoList": []
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: size.width * 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * 30,
              ),
              Text(
                '基本信息：',
                style: TextStyle(
                    fontSize: size.width * 30,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    '客户名称',
                    style: TextStyle(
                      fontSize: size.width * 30,
                      color: Color(0xff5A5A5B),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: '请输入',
                        hintStyle: TextStyle(
                            color: Color(0xffC1C1C1),
                            fontSize: size.width * 30),
                        border: InputBorder.none,
                      ),
                      onChanged: _textNameChanged,
                      autofocus: false,
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
              Container(
                color: Color(0xffE4E4E4),
                height: size.width * 1,
                width: double.infinity,
              ),
              Row(
                children: [
                  Text(
                    '联系电话',
                    style: TextStyle(
                      fontSize: size.width * 30,
                      color: Color(0xff5A5A5B),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: '请输入',
                        hintStyle: TextStyle(
                            color: Color(0xffC1C1C1),
                            fontSize: size.width * 30),
                        border: InputBorder.none,
                      ),
                      onChanged: _textPhoneChanged,
                      autofocus: false,
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
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
              child: data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: size.width * 30,
                              right: size.width * 30,
                              left: size.width * 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 30,
                                    top: size.width * 20),
                                child: Text(
                                  data[index]['title'],
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: size.width * 1,
                                width: double.infinity,
                                color: Color(0xffEFEFEF),
                                margin: EdgeInsets.symmetric(
                                    vertical: size.width * 20),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      data[index]['productListVoList'].length,
                                  itemBuilder: (context, _index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: size.width * 30,
                                          right: size.width * 30,
                                          left: size.width * 30),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                            data[index]['productListVoList']
                                                [_index]['name'],
                                            style: TextStyle(
                                                fontSize: size.width * 26,
                                                color: Color(0xff7487A4),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: size.width * 10,
                                          ),
                                          Text(
                                            '最大数量：' + data[index]['productListVoList']
                                                [_index]['maxNum'].toString(),
                                            style: TextStyle(
                                                fontSize: size.width * 16,
                                                color: Color(0xffFF5F5F)),
                                          ),
                                            ],
                                          ),
                                          Spacer(),
                                          data[index]['productListVoList'][_index]['num'] == 0 
                                          ? Image.asset(
                                              "assets/images/jinzhijianshao@2x.png",
                                              height: size.width * 30,
                                              width: size.width * 30,
                                          )
                                          : GestureDetector(
                                            onTap: (){
                                              data[index]['productListVoList'][_index]['num'] = data[index]['productListVoList'][_index]['num'] - 1;
                                              setState(() {});
                                            },
                                            child: Image.asset(
                                              "assets/images/jian@2x.png",
                                              height: size.width * 30,
                                              width: size.width * 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 15,
                                          ),
                                          Text(
                                            data[index]['productListVoList'][_index]['num'].toString(),
                                            style: TextStyle(
                                                color: data[index]['productListVoList'][_index]['num'] > data[index]['productListVoList'][_index]['maxNum'] ? Color(0xffFF5F5F) : Color(0xff445CFE),
                                                fontSize: size.width * 30),
                                          ),
                                          SizedBox(
                                            width: size.width * 15,
                                          ),
                                          data[index]['productListVoList'][_index]['num'] > data[index]['productListVoList'][_index]['maxNum'] 
                                          ? Image.asset(
                                            "assets/images/jinzhitianjia@2x.png",
                                            height: size.width * 30,
                                            width: size.width * 30,
                                          )
                                          : GestureDetector(
                                            onTap: (){
                                              data[index]['productListVoList'][_index]['num'] = data[index]['productListVoList'][_index]['num'] + 1;
                                              setState(() {});
                                            },
                                            child: Image.asset(
                                              "assets/images/jia@2x.png",
                                              height: size.width * 30,
                                              width: size.width * 30,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                            ],
                          ),
                        );
                      })
                  : Container(
                      padding: EdgeInsets.only(top: size.width * 200),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/icon_product_chahua@2x.png",
                            height: size.width * 254,
                            width: size.width * 368,
                          ),
                          SizedBox(
                            height: size.width * 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, state) {
                                        return ShowDialog(
                                            child: Center(
                                          child: Container(
                                            height: size.width * 500,
                                            width: size.width * 690,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 10))),
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
                                                          Navigator.of(context)
                                                              .pop();
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
                                                    '仓库选择',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 36,
                                                        color:
                                                            Color(0xff0059FF),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 30,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.width *
                                                                    40),
                                                    child: DropdownButton(
                                                        value: _value,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffCFCFCF),
                                                            fontSize:
                                                                size.width *
                                                                    30),
                                                        icon: Icon(Icons
                                                            .keyboard_arrow_down),
                                                        iconSize:
                                                            size.width * 50,
                                                        iconEnabledColor:
                                                            Colors.black,
                                                        hint: Text('请选择仓库'),
                                                        isExpanded: true,
                                                        isDense: false,
                                                        items: items,
                                                        onChanged: (value) {
                                                          _value = value;
                                                          state(() {});
                                                        }),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (_value == null) {
                                                        Fluttertoast.showToast(
                                                            msg: '请选择仓库');
                                                      } else {
                                                        await Permission.camera
                                                            .request();
                                                        String barcode =
                                                            await scanner
                                                                .scan();
                                                        inStockNum = 0;
                                                        if (barcode != '' &&
                                                            barcode != null) {
                                                          // 判断该条形码在该仓库中的数量
                                                          print(_value[
                                                              'id']); // 仓库id
                                                          myDio.request(
                                                              type: 'get',
                                                              url: Interface
                                                                  .getInStock,
                                                              queryParameters: {
                                                                "warehouseId":
                                                                    _value[
                                                                        'id'],
                                                                'barCode':
                                                                    barcode
                                                              }).then((value) {
                                                            if (value is Map) {
                                                              inStockNum =
                                                                  value['num'];
                                                              if (inStockNum ==
                                                                  0) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            '该仓库中没有此商品');
                                                              } else {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return StatefulBuilder(
                                                                        builder:
                                                                            (context,
                                                                                state) {
                                                                          return ShowDialog(
                                                                              child: Center(
                                                                            child:
                                                                                Container(
                                                                              height: size.width * 320,
                                                                              width: size.width * 690,
                                                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(size.width * 10))),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: size.width * 40,
                                                                                    ),
                                                                                    Text(
                                                                                      barcode.toString(),
                                                                                      style: TextStyle(color: Color(0xff333333), fontSize: size.width * 36),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: size.width * 20,
                                                                                    ),
                                                                                    Container(
                                                                                        height: size.width * 80,
                                                                                        width: size.width * 400,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xfff5f5f5),
                                                                                          borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                                                                                          border: Border.all(width: size.width * 1, color: Color(0xffB2B2B2)),
                                                                                        ),
                                                                                        child: TextField(
                                                                                                keyboardType: TextInputType.number,
                                                                                                decoration: InputDecoration(
                                                                                                  contentPadding: EdgeInsets.only(left: size.width * 20, bottom: size.width * 20),
                                                                                                  hintText: '请输入出库数量',
                                                                                                  hintStyle: TextStyle(color: Color(0xffCFCFCF), fontSize: size.width * 30),
                                                                                                  border: InputBorder.none,
                                                                                                ),
                                                                                                onChanged: _textProductNum,
                                                                                                autofocus: false,
                                                                                              ),
                                                                                        ),
                                                                                    Spacer(),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        print(textProductNum);
                                                                                        if (textProductNum == 0) {
                                                                                          Fluttertoast.showToast(msg: '请输入出库数量');
                                                                                        } else {
                                                                                          myDio.request(type: 'get', url: Interface.getWarehousingProductByBarCode, queryParameters: {
                                                                                              'barCode': barcode
                                                                                            }).then((value) {
                                                                                              data.add({
                                                                                                'title': _value['name'],
                                                                                                'warehouseId': _value['id'],
                                                                                                'productListVoList': [
                                                                                                  {
                                                                                                    'name': value['name'],
                                                                                                    'productId': value['id'],
                                                                                                    'num': textProductNum,
                                                                                                    'maxNum': inStockNum
                                                                                                  },
                                                                                                ]
                                                                                              });
                                                                                              Navigator.of(context).pop();
                                                                                              setState(() {});
                                                                                            });
                                                                                          // if (textProductNum > inStockNum) {
                                                                                          //   Fluttertoast.showToast(msg: '库存不足');
                                                                                          // } else {
                                                                                          //   print('确认出库');
                                                                                            
                                                                                          // }
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        width: size.width * 140,
                                                                                        height: size.width * 50,
                                                                                        margin: EdgeInsets.only(bottom: size.width * 20),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                                                                                          color: Color(0xff2E6CFD),
                                                                                        ),
                                                                                        alignment: Alignment.center,
                                                                                        child: Text(
                                                                                          '确认出库',
                                                                                          style: TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontSize: size.width * 24,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ));
                                                                        },
                                                                      );
                                                                    });
                                                              }
                                                            }
                                                          });
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      width: size.width * 505,
                                                      height: size.width * 75,
                                                      margin: EdgeInsets.only(
                                                          bottom:
                                                              size.width * 50),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        38)),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            Color(0xff3174FF),
                                                            Color(0xff1C3AEA),
                                                          ],
                                                        ),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        '确定',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width * 36,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                      },
                                    );
                                  });
                            },
                            child: Container(
                              width: size.width * 160,
                              height: size.width * 60,
                              decoration: BoxDecoration(
                                  color: Color(0xff2E6CFD),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 10))),
                              alignment: Alignment.center,
                              child: Text(
                                '出库',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        ),
        data.isNotEmpty
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: size.width * 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, state) {
                                  return ShowDialog(
                                      child: Center(
                                    child: Container(
                                      height: size.width * 500,
                                      width: size.width * 690,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 10))),
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
                                              '仓库选择',
                                              style: TextStyle(
                                                  fontSize: size.width * 36,
                                                  color: Color(0xff0059FF),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: size.width * 30,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 40),
                                              child: DropdownButton(
                                                  value: _value,
                                                  style: TextStyle(
                                                      color: Color(0xffCFCFCF),
                                                      fontSize:
                                                          size.width * 30),
                                                  icon: Icon(Icons
                                                      .keyboard_arrow_down),
                                                  iconSize: size.width * 50,
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  hint: Text('请选择仓库'),
                                                  isExpanded: true,
                                                  isDense: false,
                                                  items: items,
                                                  onChanged: (value) {
                                                    _value = value;
                                                    state(() {});
                                                  }),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                if (_value == null) {
                                                  Fluttertoast.showToast(
                                                      msg: '请选择仓库');
                                                } else {
                                                  await Permission.camera
                                                      .request();
                                                  String barcode =
                                                      await scanner.scan();
                                                  inStockNum = 0;
                                                  if (barcode != '' &&
                                                      barcode != null) {
                                                    // 判断该条形码在该仓库中的数量
                                                    print(_value['id']); // 仓库id
                                                    myDio.request(
                                                        type: 'get',
                                                        url: Interface
                                                            .getInStock,
                                                        queryParameters: {
                                                          "warehouseId":
                                                              _value['id'],
                                                          'barCode': barcode
                                                        }).then((value) {
                                                      if (value is Map) {
                                                        inStockNum =
                                                            value['num'];
                                                        if (inStockNum == 0) {
                                                          Fluttertoast.showToast(
                                                              msg: '该仓库中没有此商品');
                                                        } else {
                                                          Navigator.of(context)
                                                              .pop();
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  true,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return StatefulBuilder(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    return ShowDialog(
                                                                        child:
                                                                            Center(
                                                                      child:
                                                                          Container(
                                                                        height: size.width *
                                                                            320,
                                                                        width: size.width *
                                                                            690,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.all(Radius.circular(size.width * 10))),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: size.width * 20,
                                                                              vertical: size.width * 10),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: size.width * 40,
                                                                              ),
                                                                              Text(
                                                                                barcode.toString(),
                                                                                style: TextStyle(color: Color(0xff333333), fontSize: size.width * 36),
                                                                              ),
                                                                              SizedBox(
                                                                                height: size.width * 20,
                                                                              ),
                                                                              Container(
                                                                                  height: size.width * 80,
                                                                                  width: size.width * 593,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xfff5f5f5),
                                                                                    borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                                                                                    border: Border.all(width: size.width * 1, color: Color(0xffB2B2B2)),
                                                                                  ),
                                                                                  child: TextField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          decoration: InputDecoration(
                                                                                            contentPadding: EdgeInsets.only(left: size.width * 20, bottom: size.width * 20),
                                                                                            hintText: '请输入出库数量',
                                                                                            hintStyle: TextStyle(color: Color(0xffCFCFCF), fontSize: size.width * 30),
                                                                                            border: InputBorder.none,
                                                                                          ),
                                                                                          onChanged: _textProductNum,
                                                                                          autofocus: false,
                                                                                        ),
                                                                                  ),
                                                                              Spacer(),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  if (textProductNum == 0) {
                                                                                    Fluttertoast.showToast(msg: '请输入出库数量');
                                                                                  } else {
                                                                                    myDio.request(type: 'get', url: Interface.getWarehousingProductByBarCode, queryParameters: {
                                                                                        'barCode': barcode
                                                                                      }).then((value) {
                                                                                        bool isttt = false;
                                                                                        int dataIndex = -1;
                                                                                        for (int i = 0; i < data.length; i++) {
                                                                                          if(_value['id'] == data[i]['warehouseId']){
                                                                                            isttt = true;
                                                                                            dataIndex = i;
                                                                                          }
                                                                                        }
                                                                                        if(isttt){
                                                                                          data[dataIndex]['productListVoList'].add(
                                                                                            {
                                                                                                'name': value['name'],
                                                                                                'productId': value['id'],
                                                                                                'num': textProductNum,
                                                                                                'maxNum': inStockNum
                                                                                            },
                                                                                          );
                                                                                        }else{
                                                                                          data.add({
                                                                                            'title': _value['name'],
                                                                                            'warehouseId': _value['id'],
                                                                                            'productListVoList': [
                                                                                              {
                                                                                                'name': value['name'],
                                                                                                'productId': value['id'],
                                                                                                'num': textProductNum,
                                                                                                'maxNum': inStockNum
                                                                                              },
                                                                                            ]
                                                                                          });
                                                                                        }
                                                                                        Navigator.of(context).pop();
                                                                                        setState(() {});
                                                                                      });
                                                                                    // if (textProductNum > inStockNum) {
                                                                                    //   Fluttertoast.showToast(msg: '库存不足');
                                                                                    // } else {
                                                                                      
                                                                                    // }
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  width: size.width * 140,
                                                                                  height: size.width * 50,
                                                                                  margin: EdgeInsets.only(bottom: size.width * 20),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                                                                                    color: Color(0xff2E6CFD),
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    '确认出库',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: size.width * 24,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ));
                                                                  },
                                                                );
                                                              });
                                                        }
                                                      }
                                                    });
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: size.width * 505,
                                                height: size.width * 75,
                                                margin: EdgeInsets.only(
                                                    bottom: size.width * 50),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              size.width * 38)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Color(0xff3174FF),
                                                      Color(0xff1C3AEA),
                                                    ],
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '确定',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: size.width * 36,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                              );
                            });
                      },
                      child: Container(
                        height: size.width * 60,
                        width: size.width * 220,
                        decoration: BoxDecoration(
                            color: Color(0xff2E6CFD),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10))),
                        alignment: Alignment.center,
                        child: Text(
                          '继续出库',
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * 30),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        if(clientName == ''){
                          Fluttertoast.showToast(msg: '请填写客户名称');
                          return;
                        }else if(clientTelephone == ''){
                          Fluttertoast.showToast(msg: '请填写联系电话');
                          return;
                        }else{
                          submitData['clientName'] = clientName;
                          submitData['clientTelephone'] = clientTelephone;
                          submitData['deliveryVoList'] = data;
                          myDio.request(
                            type: 'post',
                            url: Interface.postDelivery,
                            data: submitData
                          ).then((value) {
                            successToast('出库成功');
                            data = [];
                            setState(() {});
                          });
                        }
                      },
                      child: Container(
                        height: size.width * 60,
                        width: size.width * 220,
                        decoration: BoxDecoration(
                            color: Color(0xff09BA07),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10))),
                        alignment: Alignment.center,
                        child: Text(
                          '提交订单',
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * 30),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
