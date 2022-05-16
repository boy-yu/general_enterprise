import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenDialog {
  static Future myHiddenDialog(
      context, String title, bool isTakePhotos, String editTitle, callback,
      {Counter counter}) {
    String editStr = '';
    String image = '';
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Container(
                  width: size.width * 640,
                  height: isTakePhotos ? size.width * 710 : size.width * 480,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 32))),
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus.unfocus();
                      }
                    },
                    child: Column(
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    editTitle,
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Container(
                                height: size.width * 160,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFEEEEEE),
                                      style: BorderStyle.solid,
                                      width: size.width * 1),
                                ),
                                child: TextField(
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: '请输入' + editTitle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: size.width * 10,
                                          vertical: size.width * 10),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: size.width * 28,
                                          color: Color(0xff7F8A9C)),
                                    ),
                                    onChanged: (str) {
                                      editStr = str;
                                    }),
                              ),
                              isTakePhotos
                                  ? SizedBox(
                                      height: size.width * 10,
                                    )
                                  : Container(),
                              isTakePhotos
                                  ? Row(
                                      children: [
                                        Text(
                                          '拍照',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              isTakePhotos
                                  ? MyImageCarma(
                                      title: editTitle,
                                      name: '',
                                      purview: editTitle,
                                    )
                                  : Container(),
                            ],
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
                                Map submitData = {};
                                // callback(editStr);
                                print(editStr);
                                if (editStr == '') {
                                  Fluttertoast.showToast(msg: '请填写内容');
                                } else if (isTakePhotos) {
                                  if (counter.submitDates[editTitle] != null) {
                                    counter.submitDates[editTitle]
                                        .forEach((ele) {
                                      if (ele['title'] == editTitle) {
                                        for (var i = 0;
                                            i < ele['value'].length;
                                            i++) {
                                          if (i == ele['value'].length - 1) {
                                            image += ele['value'][i];
                                          } else {
                                            image += ele['value'][i] + '|';
                                          }
                                        }
                                      }
                                    });
                                    if (image == '') {
                                      Fluttertoast.showToast(msg: '请拍照');
                                    } else {
                                      submitData['editStr'] = editStr;
                                      submitData['image'] = image;
                                      callback(submitData);
                                      Navigator.of(context).pop();
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: '请拍照');
                                  }
                                } else {
                                  submitData['editStr'] = editStr;
                                  callback(submitData);
                                  Navigator.of(context).pop();
                                }
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
                  ))),
        );
      },
    );
  }
}
