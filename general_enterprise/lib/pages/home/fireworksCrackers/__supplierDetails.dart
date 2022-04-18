import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SupplierDetails extends StatefulWidget {
  SupplierDetails({this.data});
  final Map data;
  @override
  _SupplierDetailsState createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('供应商详情'),
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '名称',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.data['name'].toString(),
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffE4E4E4),
                  height: size.width * 1,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '地址',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.data['address'].toString(),
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffE4E4E4),
                  height: size.width * 1,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '电话',
                        style: TextStyle(
                          fontSize: size.width * 30,
                          color: Color(0xff5A5A5B),
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.data['telephone'].toString(),
                        style: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontSize: size.width * 30
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width * 30,
                ),
                Text(
                  '营业执照：',
                  style: TextStyle(
                      fontSize: size.width * 30,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: widget.data['licenseUrl'] != '' ? Image.network(
                    widget.data['licenseUrl'],
                    height: size.width * 258,
                    width: size.width * 372,
                  ) : Image.asset(
                    "assets/images/image_supplier_zhanwu.png",
                    height: size.width * 258,
                    width: size.width * 372,
                  ),
                ),
                SizedBox(
                  height: size.width * 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width * 30,
                ),
                Text(
                  '供应产品：',
                  style: TextStyle(
                      fontSize: size.width * 30,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 30),
                  child: Text(
                    widget.data['products'].toString(),
                    style: TextStyle(
                      color: Color(0xff5A5A5B),
                      fontSize: size.width * 30
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}