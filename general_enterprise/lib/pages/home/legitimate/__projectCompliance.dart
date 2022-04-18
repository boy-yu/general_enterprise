import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProjectCompliance extends StatefulWidget {
  @override
  _ProjectCompliance createState() => _ProjectCompliance();
}

class _ProjectCompliance extends State<ProjectCompliance> {
  List data = [
    {
      "id": -1,
      "companyId": -1,
      "name": "",
      "attachment":
          "https://shuangkong.oss-cn-qingdao.aliyuncs.com/temp/1606468184217/%E5%8F%8C%E6%B0%B4%E5%88%86%E5%85%AC%E5%8F%B8%E5%BA%94%E6%80%A5%E9%A2%84%E6%A1%88.pdf",
      "createDate": "2020-11-27 17:09:45",
      "modifyDate": "2020-11-27 17:09:45"
    }
  ];

  @override
  void initState() {
    super.initState();
    _getProjectList();
  }

  _getProjectList() {
    myDio
        .request(
      type: 'get',
      url: Interface.projectComplianceLsit,
    )
        .then((value) {
      if (value is List) {
        data = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getUrl(String attachment) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': '查看文件'});
  }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Container(
            width: double.infinity,
            height: size.width * 700,
            // margin: EdgeInsets.only(top: size.width * 40),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                              blurRadius: 5.0, //阴影模糊程度
                              spreadRadius: 0.0 //阴影扩散程度
                              )
                        ]),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 30, horizontal: size.width * 20),
                    margin: EdgeInsets.symmetric(
                        vertical: size.width * 10, horizontal: size.width * 20),
                    child: Row(
                      children: [
                        Text(
                          data[index]['name'],
                          style: TextStyle(
                              color: Color(0xff7487A4),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (data[index]['attachment'] != '') {
                              _getUrl(data[index]['attachment']);
                            } else {
                              Fluttertoast.showToast(msg: '暂无文件');
                            }
                          },
                          child: Container(
                            height: size.width * 40,
                            width: size.width * 120,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff2D6DFF),
                                    Color(0xff7A73FF),
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Text(
                              '查看合规',
                              style: TextStyle(
                                  fontSize: size.width * 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        : Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: size.width * 300),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                ),
                Image.asset(
                  "assets/images/empty@2x.png",
                  height: size.width * 288,
                  width: size.width * 374,
                ),
                Text('暂无数据'),
              ],
            ));
  }
}
