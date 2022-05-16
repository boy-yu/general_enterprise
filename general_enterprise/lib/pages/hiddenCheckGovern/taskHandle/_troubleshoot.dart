import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Troubleshoot extends StatefulWidget {
  Troubleshoot({this.id, this.checkMeans});
  final String id;
  final String checkMeans;
  @override
  State<Troubleshoot> createState() => _TroubleshootState();
}

class _TroubleshootState extends State<Troubleshoot> {
  TextEditingController _textEditingController = TextEditingController();
  bool isFull = false;
  int selectbgColor = 0xff0ABA08;
  int selecttextColor = 0xffffffff;
  Counter _counter = Provider.of(myContext);

  List _generateImage({String state}) {
    List image = [];
    if (_counter.submitDates['隐患排查'] == null) {
      // Fluttertoast.showToast(msg: '请拍照');
    } else {
      bool next = false;
      _counter.submitDates['隐患排查'].forEach((ele) {
        if (ele['title'] == '隐患排查') {
          image = ele['value'];
          if (image.length > 0) {
            next = true;
          }
        }
      });
      if (!next && state != '数据录入') {
        Fluttertoast.showToast(msg: '请拍照');
      }
    }
    return image;
  }

  _sumbit() async {
    if (_textEditingController.text == '') {
      Fluttertoast.showToast(msg: '请输入隐患描述');
      return;
    }
    dynamic submitData = {
      "id": widget.id,
      "checkOpinion": _textEditingController.text,
      "checkStatus": isFull ? '0' : '1',
    };
    if (!isFull || widget.checkMeans == '1') {
      List image = _generateImage();
      if (image.isEmpty) {
        Fluttertoast.showToast(msg: '请拍照');
        return;
      }
      String carmaStr = '';
      for (var i = 0; i < image.length; i++) {
        if (i == image.length - 1) {
          carmaStr += image[i];
        } else {
          carmaStr += image[i] + '|';
        }
      }
      submitData['checkUrl'] = carmaStr;
    }
    myDio
        .request(
            type: 'post', url: Interface.postImplementTask, data: submitData)
        .then((value) {
      successToast('排查完成');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.width * 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFull = !isFull;
                        });
                      },
                      child: Container(
                        height: size.width * 72,
                        width: size.width * 196,
                        decoration: BoxDecoration(
                          color: isFull
                              ? Color(0xff3074FF).withOpacity(0.1)
                              : Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 8)),
                          border: Border.all(
                              width: size.width * 2,
                              color: isFull
                                  ? Color(0xff3074FF)
                                  : Color(0XFFECECEC)),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: size.width * 28,
                              width: size.width * 28,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    width: size.width * 4,
                                    color: isFull
                                        ? Color(0xff3074FF)
                                        : Color(0XFFE0E0E0)),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 8,
                            ),
                            Text(
                              '正常',
                              style: TextStyle(
                                  color: isFull
                                      ? Color(0xff3074FF)
                                      : Color(0xff7F8A9C),
                                  fontSize: size.width * 32,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFull = !isFull;
                        });
                      },
                      child: Container(
                        height: size.width * 72,
                        width: size.width * 196,
                        decoration: BoxDecoration(
                          color: !isFull
                              ? Color(0xff3074FF).withOpacity(0.1)
                              : Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 8)),
                          border: Border.all(
                              width: size.width * 2,
                              color: !isFull
                                  ? Color(0xff3074FF)
                                  : Color(0XFFECECEC)),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: size.width * 28,
                              width: size.width * 28,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    width: size.width * 4,
                                    color: !isFull
                                        ? Color(0xff3074FF)
                                        : Color(0XFFE0E0E0)),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 8,
                            ),
                            Text(
                              '存在隐患',
                              style: TextStyle(
                                  color: !isFull
                                      ? Color(0xff3074FF)
                                      : Color(0xff7F8A9C),
                                  fontSize: size.width * 32,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: size.width * 40,
                          width: size.width * 8,
                          decoration: BoxDecoration(
                              color: Color(0xffFF943D),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(size.width * 24))),
                        ),
                        SizedBox(
                          width: size.width * 32,
                        ),
                        Text(
                          isFull ? '排查人意见:' : '隐患描述：',
                          style: TextStyle(
                              color: Color(0xff343434),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 40),
                      child: Container(
                        height: size.width * 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 8)),
                          border: Border.all(
                              width: size.width * 2, color: Color(0XFFECECEC)),
                        ),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: isFull ? '请输入意见...' : '请输入内容...',
                            hintStyle: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 28),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: size.width * 16, vertical: 0),
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 40,
                    ),
                    !isFull || widget.checkMeans == '1'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: size.width * 40,
                                    width: size.width * 8,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFF943D),
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(
                                                size.width * 24))),
                                  ),
                                  SizedBox(
                                    width: size.width * 32,
                                  ),
                                  Text(
                                    '拍照:',
                                    style: TextStyle(
                                        color: Color(0xff343434),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 40),
                                  child: MyImageCarma(
                                    title: "隐患排查",
                                    name: '',
                                    purview: '隐患排查',
                                  )),
                            ],
                          )
                        : Container(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 40),
                      child: GestureDetector(
                        onTap: _sumbit,
                        child: Container(
                          height: size.width * 80,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: size.width * 100),
                          decoration: BoxDecoration(
                            color: Color(0xff3074FF),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 8)),
                          ),
                          child: Text(
                            '确 定',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: size.width * 36),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
