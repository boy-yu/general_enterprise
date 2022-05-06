import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AffirmDialog {
  static Future myAffirmDialog(
      context, String title, String content, callback,
      {Counter counter}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Container(
                  width: size.width * 640,
                  height: size.width * 308,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 32))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.width * 32,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.width * 32,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 32),
                          child: Text(
                                    content,
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: size.width * 96,
                                width: size.width * 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xffF2F2F2),
                                        width: size.width * 2),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(size.width * 32))),
                                child: Text(
                                  '取 消',
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.width * 28),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                callback();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: size.width * 96,
                                width: size.width * 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xffF2F2F2),
                                        width: size.width * 2),
                                    borderRadius: BorderRadius.only(
                                        bottomRight:
                                            Radius.circular(size.width * 32))),
                                child: Text(
                                  '确  定',
                                  style: TextStyle(
                                      color: Color(0xff3074FF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width * 28),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        );
      },
    );
  }
}
