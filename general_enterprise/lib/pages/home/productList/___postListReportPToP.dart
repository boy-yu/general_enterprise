import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PostListReportPToP extends StatefulWidget {
  PostListReportPToP(
      {this.type, this.rolesId, this.userId, this.title, this.dutyId, this.button, this.id});
  final int type;
  final int rolesId;
  final int userId;
  final String title;
  final int dutyId;
  final int button;
  final int id;
  @override
  _PostListReportPToPState createState() => _PostListReportPToPState();
}

class _PostListReportPToPState extends State<PostListReportPToP> {
  Map data = {};
  List reportData = [];

  @override
  void initState() {
    super.initState();
    if(widget.button == 1){
      _getMyData(widget.id);
    }else{
      _getData(widget.type, widget.rolesId, widget.userId, widget.title,widget.dutyId);
    }  
  }

  _getMyData(int id) {
    myDio.request(type: 'get', url: Interface.getCheckPostReport, queryParameters: {
      "id": id,
    }).then((value) {
      if (value is Map) {
        data = value;
        reportData = value['reportData'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getData(int type, int rolesId, int userId, String title, int dutyId) {
    myDio.request(type: 'get', url: Interface.getPostReport, queryParameters: {
      "type": type,
      "rolesId": rolesId,
      "userId": userId,
      "title": title,
      'dutyId': dutyId,
    }).then((value) {
      if (value is Map) {
        data = value;
        reportData = value['reportData'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getText(String text) {
    List strings;
    List strings2;
    String str = '';
    String string = '';
    strings = text.split('<span class=\"contolr-number\">');
    strings.forEach((f) {
      if (str == '') {
        str = "$f";
      } else {
        str = "$str$f";
      }
    });
    strings2 = str.split('</span>');
    strings2.forEach((f) {
      if (string == '') {
        string = "$f";
      } else {
        string = "$string$f";
      }
    });
    return string;
  }

  _sumbitData(){
    myDio.request(type: 'post', url: Interface.postConfirmReport, data: {
      "reportId": data['reportId'],
      "rolesId": data['rolesId'],
      "dutyId": data['dutyId']
    }).then((value) {
      successToast('成功');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_post_list_report.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: data.isNotEmpty
            ? Container(
                margin: EdgeInsets.symmetric(vertical: size.width * 150, horizontal: size.width * 55),
                    // padding: EdgeInsets.symmetric(horizontal: size.width * 50),
                child: SingleChildScrollView(
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
                              color: Color(0xff9C9C9C),
                              size: size.width * 67,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Color(0xff3072FE),
                            height: size.width * 2,
                            width: size.width * 67,
                          ),
                          SizedBox(
                            width: size.width * 28,
                          ),
                          Text(
                            '岗位责任清单报表',
                            style: TextStyle(
                                color: Color(0xff3776FE),
                                fontSize: size.width * 40,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: size.width * 28,
                          ),
                          Container(
                            color: Color(0xff3072FE),
                            height: size.width * 2,
                            width: size.width * 67,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['nickname'] == ''
                                ? '清单签收人：———'
                                : '清单签收人：${data['nickname']}',
                            style: TextStyle(
                                color: Color(0xff408CE2),
                                fontSize: size.width * 22),
                          ),
                          SizedBox(
                            width: size.width * 100,
                          ),
                          Text(
                            data['time'] == ''
                                ? '时间：———— —— ——'
                                : '时间：${data['time']}',
                            style: TextStyle(
                                color: Color(0xff408CE2),
                                fontSize: size.width * 22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                data['liabilityTitle'].toString(),
                                style: TextStyle(
                                    color: Color(0xff2B2B2B),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 40,
                      ),
                      Container(
                          width: double.infinity,
                          height: size.width * 500,
                          color: Color(0xffF6F6F6),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 20,
                              vertical: size.width * 25),
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: reportData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getText(reportData[index]['report']),
                                      style: TextStyle(
                                          color: Color(0xff373636),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            if (reportData[index]['type'] == 1) {
                                              return;
                                            }
                                            if (reportData[index]['type'] == 5) {
                                              Navigator.pushNamed(context,
                                                  '/legitimate/legitimate');
                                            } else {
                                              Navigator.pushNamed(context,
                                                  '/index/productList/PostWorkDetail',
                                                  arguments: {
                                                    "data": reportData[index]
                                                  });
                                            }
                                          },
                                          child: reportData[index]['type'] == 1 ? Container(
                                            height: size.width * 30,
                                          ) : Text(
                                            '详细',
                                            style: TextStyle(
                                                color: Color(0xff408CE2),
                                                fontSize: size.width * 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              })),
                      SizedBox(
                        height: size.width * 100,
                      ),
                      data['sign'] == ''
                          ? widget.button == 1
                            ? InkWell(
                              onTap: (){
                                _sumbitData();
                              },
                              child: Container(
                                height: size.width * 80,
                                width: size.width * 540,
                                decoration: BoxDecoration(
                                  color: Color(0xff408ce2),
                                  borderRadius: BorderRadius.all(Radius.circular(size.width * 40))
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '签收',
                                  style: TextStyle(
                                      fontSize: size.width * 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            )
                            : Text(
                                '未签收',
                                style: TextStyle(
                                    fontSize: size.width * 26,
                                    color: Color(0xff408CE2),
                                    fontWeight: FontWeight.bold),
                              )
                          : Image.network(data['sign'])
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
