import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class OperationCard extends StatefulWidget {
  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  _getUrl(String attachment) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': '查看文件'});
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => GestureDetector(
              onTap: () {
                _getUrl(list[index]['fileUrl']);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                margin: EdgeInsets.all(size.width * 20),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 20),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size.width * 80,
                            height: size.width * 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFF1F8FF),
                                borderRadius: BorderRadius.circular(1000)),
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: size.width * 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              list[index]['name'].toString(),
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: Color(0xff333333)),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              list[index]['expireDate'].toString().length > 10
                                  ? '到期时间：' +
                                      list[index]['expireDate']
                                          .toString()
                                          .substring(0, 10)
                                  : "到期时间：永久",
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        page: true,
        listParam: "records",
        url: Interface.getOperationCard,
        method: 'get');
  }  
}
