import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class LicenseDetails extends StatefulWidget {
  LicenseDetails({this.id, this.fixedType, this.type});
  final int id;
  final int fixedType;
  final String type;
  @override
  _LicenseDetailsState createState() => _LicenseDetailsState();
}

class _LicenseDetailsState extends State<LicenseDetails> {
  @override
  void initState() {
    super.initState();
    _getMsg();
  }

  Map certificate = {
    "id": 32,
    "companyId": 340,
    "name": "名称",
    "licensedObject": "对象",
    "licensedObjectId": 0,
    "coding": "963852741",
    "certificateTypeId": 78,
    "certificateParentType": 0,
    "createDate": "2020-11-30 10:24:26",
    "modifyDate": "2020-11-30 10:24:26"
  };
  List fieldsList = [
    {
      "englishName": "shenfenzhenghao",
      "chineseName": "身份证号",
      "id": 99,
      "fieldValue": "51010411111111111"
    },
  ];
  List fileList = [
    {
      "id": 33,
      "certificateId": 32,
      "companyId": 340,
      "licensedObjectId": 0,
      "certificateTypeId": 78,
      "frontPicture":
          "https://shuangkong.oss-cn-qingdao.aliyuncs.com/temp/1606703027910/u%3D1154743519%2C2612231121%26fm%3D26%26gp%3D0.jpg",
      "tailsPicture":
          "https://shuangkong.oss-cn-qingdao.aliyuncs.com/temp/1606703031554/u%3D1388335973%2C3629955725%26fm%3D26%26gp%3D0.jpg",
      "certificateParentType": 0,
      "expireDate": "",
      "grantDate": "",
      "createDate": "",
      "modifyDate": ""
    }
  ];

  _getMsg() {
    myDio
        .request(
            type: 'get',
            url: Interface.getLicenseDetails + widget.id.toString())
        .then((value) {
      if (value is Map) {
        certificate = value['certificate'];
        fieldsList = value['fields'];
        fileList = value['fileList'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      title: Text(
        '证照详情',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 36,
            color: Colors.white),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Row(
                          children: [
                            Text(
                              '证书名称：',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 30),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              certificate['name'],
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xffE5E5E5),
                        width: double.infinity,
                        height: size.width * 1,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Row(
                          children: [
                            Text(
                              '证书编号：',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 30),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              certificate['coding'].toString(),
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xffE5E5E5),
                        width: double.infinity,
                        height: size.width * 1,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Row(
                          children: [
                            Text(
                              '持证对象：',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 30),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              certificate['licensedObject'].toString(),
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  margin: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: ListView.builder(
                      itemCount: fieldsList.length,
                      shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                      physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 20),
                              child: Row(
                                children: [
                                  Text(
                                    fieldsList[index]['chineseName']
                                            .toString() +
                                        '：',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 30),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text(
                                    fieldsList[index]['fieldValue'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 28),
                                  ),
                                ],
                              ),
                            ),
                            index != fieldsList.length - 1
                                ? Container(
                                    color: Color(0xffE5E5E5),
                                    width: double.infinity,
                                    height: size.width * 1,
                                  )
                                : Container(),
                          ],
                        );
                      }),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 20, horizontal: size.width * 30),
                  margin: EdgeInsets.symmetric(vertical: size.width * 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '颁发日期：',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30),
                          ),
                          SizedBox(
                            width: size.width * 10,
                          ),
                          Text(
                            fileList[0]['grantDate'].toString().length > 10
                                ? fileList[0]['grantDate']
                                    .toString()
                                    .substring(0, 10)
                                : fileList[0]['grantDate'].toString(),
                            style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 28),
                          ),
                        ],
                      ),
                      Container(
                        color: Color(0xffE5E5E5),
                        width: double.infinity,
                        height: size.width * 1,
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      ),
                      Row(
                        children: [
                          Text(
                            '到期日期：',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30),
                          ),
                          SizedBox(
                            width: size.width * 10,
                          ),
                          Text(
                            fileList[0]['expireDate'].toString().length > 10
                                ? fileList[0]['expireDate']
                                    .toString()
                                    .substring(0, 10)
                                : '永久有效',
                            style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 28),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              fileList[0]['frontPicture'] != null &&
                                      fileList[0]['frontPicture'] != ''
                                  // ? Image.network(
                                  //     fileList[0]['frontPicture'],
                                  //     height: size.width * 194,
                                  //     width: size.width * 307,
                                  //     fit: BoxFit.cover,
                                  //   )
                                  ? ClickImage(
                                      fileList[0]['frontPicture'],
                                      width: size.width * 307,
                                      height: size.width * 194,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: size.width * 194,
                                      width: size.width * 307,
                                      alignment: Alignment.center,
                                      color: Color(0xffF9F9F9),
                                      child: Text('暂无证书'),
                                    ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '证书正面',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 24),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              fileList[0]['tailsPicture'] != null &&
                                      fileList[0]['tailsPicture'] != ''
                                  // ? Image.network(
                                  //     fileList[0]['tailsPicture'],
                                  //     height: size.width * 194,
                                  //     width: size.width * 307,
                                  //     fit: BoxFit.cover,
                                  //   )
                                  ? ClickImage(
                                      fileList[0]['tailsPicture'],
                                      width: size.width * 307,
                                      height: size.width * 194,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: size.width * 194,
                                      width: size.width * 307,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF9F9F9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Text('暂无证书'),
                                    ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '证书副页',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 24),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.type != '个人档案' ? GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/legitimate/_____licenseUpDate',
                  arguments: {
                    "id": certificate['id'],
                    'fixedType': widget.fixedType,
                  }).then((value) => {_getMsg()});
            },
            child: Container(
              height: size.width * 80,
              width: size.width * 210,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 270, vertical: size.width * 30),
              alignment: Alignment.center,
              child: Text(
                '更新',
                style: TextStyle(
                    color: Color(0xff2D69FB),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ) : Container(),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/legitimate/_____licenseHistory',
                arguments: {"fileList": fileList});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
            child: Icon(Icons.query_builder),
          ),
        )
      ],
    );
  }
}
