import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/empty.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class LicenseHistory extends StatefulWidget {
  LicenseHistory({this.fileList});
  final List fileList;
  @override
  _LicenseHistoryState createState() => _LicenseHistoryState();
}

class _LicenseHistoryState extends State<LicenseHistory> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('历史证照'),
        child: widget.fileList.isNotEmpty
            ? ListView.builder(
                itemCount: widget.fileList.length,
                itemBuilder: (context, index) {
                  return Container(
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
                              widget.fileList[index]['grantDate']
                                  .toString()
                                  .substring(0, 10),
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
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 20),
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
                              widget.fileList[index]['expireDate']
                                          .toString()
                                          .length >
                                      10
                                  ? widget.fileList[index]['expireDate']
                                      .toString()
                                      .substring(0, 10)
                                  : "永久有效",
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
                                widget.fileList[index]['frontPicture'] !=
                                            null &&
                                        widget.fileList[index]
                                                ['frontPicture'] !=
                                            ''
                                    // ? Image.network(
                                    //     widget.fileList[index]['frontPicture'],
                                    //     height: size.width * 194,
                                    //     width: size.width * 307,
                                    //     fit: BoxFit.cover,
                                    //   )
                                    ? ClickImage(
                                        widget.fileList[index]['frontPicture'],
                                        height: size.width * 194,
                                        width: size.width * 307,
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
                                widget.fileList[index]['tailsPicture'] !=
                                            null &&
                                        widget.fileList[index]
                                                ['tailsPicture'] !=
                                            ''
                                    // ? Image.network(
                                    //     widget.fileList[index]['tailsPicture'],
                                    //     height: size.width * 194,
                                    //     width: size.width * 307,
                                    //     fit: BoxFit.cover,
                                    //   )
                                    ? ClickImage(
                                        widget.fileList[index]['tailsPicture'],
                                        height: size.width * 194,
                                        width: size.width * 307,
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
                  );
                })
            : Empty());
  }
}
