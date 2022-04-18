import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ProductsInAndOut extends StatefulWidget {
  @override
  _ProductsInAndOutState createState() => _ProductsInAndOutState();
}

class _ProductsInAndOutState extends State<ProductsInAndOut> {
  dynamic _value;

  List<DropdownMenuItem> items = [];

  List warehouseList = [];

  @override
  void initState() {
    super.initState();
    _getWarehouseList();
  }

  String commodityName = '';
  int doseNum;

  void _textNameChanged(String str) {
    commodityName = str;
  }

  void _textDoseChanged(String str) {
    doseNum = int.parse(str);
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

  _getBarcode() {
    scanner.scan().then((barCodeString) {
      myDio.request(
        type: 'post',
        url: Interface.postAddProductWarehousing,
        data: {
          "barCode": barCodeString.toString(),
          "warehousingId": _value['id'],
          "type": 1
        }).then((value) {
          if(value is Map){
            print('status---------------------' + value['status'].toString());
            // status 0.没有该商品 1.添加成功 2.仓库已满
            switch (value['status']) {
              case 0:
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
                                        Radius.circular(size.width * 10))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 20,
                                      vertical: size.width * 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '添加商品信息',
                                        style: TextStyle(
                                            fontSize: size.width * 36,
                                            color: Color(0xff0059FF),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 30,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '商品名称',
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
                                      Row(
                                        children: [
                                          Text(
                                            '单件总药量',
                                            style: TextStyle(
                                              fontSize: size.width * 30,
                                              color: Color(0xff5A5A5B),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(10.0),
                                                hintText: '请输入',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffC1C1C1),
                                                    fontSize: size.width * 30),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: _textDoseChanged,
                                              autofocus: false,
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          if(commodityName == ''){
                                            Fluttertoast.showToast(msg: '请填写商品名称');
                                          }else if(doseNum == null){
                                            Fluttertoast.showToast(msg: '请填写单件总药量');
                                          }else{
                                            myDio.request(
                                              type: 'post',
                                              url: Interface.postAddProduct,
                                              data: {
                                                "name": commodityName,
                                                "warehousingId": _value['id'],
                                                "totalDose": doseNum,
                                                "barCode": barCodeString.toString()
                                              }).then((value) {
                                                Fluttertoast.showToast(msg: '添加商品成功');
                                                _getBarcode();
                                                Navigator.of(context).pop();
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: size.width * 505,
                                          height: size.width * 75,
                                          margin: EdgeInsets.only(
                                              bottom: size.width * 50),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
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
                                            '确认入库',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 36,
                                                fontWeight: FontWeight.bold),
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
                break;
              case 1:
                Fluttertoast.showToast(msg: '入库成功');
                _getBarcode();
                break;
              case 2:
                Fluttertoast.showToast(msg: '入库成功, 仓库容量已超标');
                _getBarcode();
                break;
            }
          }
      });
    });
  }

  _getEXWarehouseBarcode() {
    scanner.scan().then((barCodeString) {
      print('barCodeString--------------------------' + barCodeString);
      myDio.request(
        type: 'post',
        url: Interface.postAddProductWarehousing,
        data: {
          "barCode": barCodeString.toString(),
          "warehousingId": _value['id'],
          "type": 0
        }).then((value) {
          Fluttertoast.showToast(msg: '出库成功');
          _getEXWarehouseBarcode();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size.width * 400),
      width: double.infinity,
      alignment: Alignment.center,
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
          Row(
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
                                                fontSize: size.width * 30),
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            iconSize: size.width * 50,
                                            iconEnabledColor: Colors.black,
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
                                        onTap: () {
                                          if (_value == null) {
                                            Fluttertoast.showToast(
                                                msg: '请选择仓库');
                                          } else {
                                            Permission.camera.request().then((value) {
                                              Navigator.of(context).pop();
                                              _getBarcode();
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: size.width * 505,
                                          height: size.width * 75,
                                          margin: EdgeInsets.only(
                                              bottom: size.width * 50),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
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
                                                fontWeight: FontWeight.bold),
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
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 10))),
                  alignment: Alignment.center,
                  child: Text(
                    '入库',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 24),
                  ),
                ),
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
                                                fontSize: size.width * 30),
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            iconSize: size.width * 50,
                                            iconEnabledColor: Colors.black,
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
                                        onTap: () {
                                          if (_value == null) {
                                            Fluttertoast.showToast(
                                                msg: '请选择仓库');
                                          } else {
                                            Permission.camera.request().then((value) {
                                              Navigator.of(context).pop();
                                              _getEXWarehouseBarcode();
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: size.width * 505,
                                          height: size.width * 75,
                                          margin: EdgeInsets.only(
                                              bottom: size.width * 50),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
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
                                                fontWeight: FontWeight.bold),
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
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 10))),
                  alignment: Alignment.center,
                  child: Text(
                    '出库',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 24),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
