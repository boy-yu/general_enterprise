import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class SupplierManagement extends StatefulWidget {
  @override
  _SupplierManagementState createState() => _SupplierManagementState();
}

class _SupplierManagementState extends State<SupplierManagement> {
  ThrowFunc _throwFunc = new ThrowFunc();
  TextEditingController _editingController = TextEditingController();

  void _textFieldChanged(String str) {
    queryParameters = {'keywords': str};
    _throwFunc.run(argument: queryParameters);
  }

  Map queryParameters;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(size.width * 30),
      child: Column(
        children: [
          Container(
            height: size.width * 76,
            decoration: BoxDecoration(
              color: Color(0xffFAFAFB),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
              border: Border.all(width: size.width * 4, color: Color(0xffF0F0F2)),
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
                    textInputAction: TextInputAction.search,
                    controller: _editingController,
                    onChanged: _textFieldChanged,
                    onSubmitted: _textFieldChanged,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: size.width * 20, bottom: size.width * 40),
                      hintText: '请输入姓名/电话/出库编码',
                      hintStyle: TextStyle(
                          color: Color(0xffACACBC), fontSize: size.width * 24),
                      border: InputBorder.none,
                    ),
                    autofocus: false,
                    // textAlign: TextAlign.end,
                  ), 
                )
              ],
            )
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Expanded(child: MyRefres(
          child: (index, data) => InkWell(
                onTap: (){
                  Navigator.pushNamed(context, 
                    "/fireworksCrackers/supplierDetails",
                    arguments: {'data': data[index]}
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.width * 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data[index]['name'].toString(),
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.bold
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Image.asset(
                              data[index]['licenseUrl'] != '' ? "assets/images/zhizhao-yi@2x.png" : "assets/images/zhizhao-wei@2x.png",
                              width: size.width * 31,
                              height: size.width * 28,
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            data[index]['licenseUrl'] != '' 
                            ? Text(
                              '已上传',
                              style: TextStyle(
                                fontSize: size.width * 22,
                                color: Color(0xff57CA6D),
                                fontWeight: FontWeight.w700
                              ),
                            ) 
                            : Text(
                              '未上传',
                              style: TextStyle(
                                fontSize: size.width * 22,
                                color: Color(0xffE63D3D),
                                fontWeight: FontWeight.w700
                              ),
                            ) 
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffEFEFEF),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.width * 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '地址：' + data[index]['address'].toString(),
                              style: TextStyle(
                                fontSize: size.width * 22,
                                color: Color(0xff848484)
                              ),
                            ),
                            SizedBox(
                              height: size.width * 20,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(fontSize: size.width * 20, fontWeight: FontWeight.w700),
                                  children: <InlineSpan>[
                                    TextSpan(text: '供应产品：',style: TextStyle(color: Color(0xff3073FE))),
                                    TextSpan(text: data[index]['products'].toString(), style: TextStyle(color: Color(0xff333333))),
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
          url: Interface.getSupplierList,
          throwFunc: _throwFunc,
          queryParameters: queryParameters,
          method: 'get'),)
        ],
      ),
    );
  }
}