import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/myView/myRiskButtons.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Troubleshoot extends StatefulWidget {
  Troubleshoot({this.id});
  final String id;
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
    if (!isFull) {
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
        // decoration: BoxDecoration(
        //   color: Color(0xffFfFfFf),
        //   borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width * 80))
        // ),
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: size.width * 60,
                  right: size.width * 20,
                  left: size.width * 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 60),
                        child: RiskButtons(
                          text: "正常",
                          testcolor: isFull ? selecttextColor : 0xff9A9A9A,
                          bgcolor: isFull ? selectbgColor : 0xffFFFFFF,
                          callback: () {
                            _textEditingController.text = '正常';
                            if (mounted) {
                              setState(() {
                                isFull = !isFull;
                              });
                            }
                          },
                        ),
                      ),
                      RiskButtons(
                        text: "存在隐患",
                        testcolor: isFull ? 0xff9A9A9A : 0xffffffff,
                        bgcolor: isFull ? 0xffFFFFFF : 0xffFF1818,
                        callback: () {
                          _textEditingController.text = '';
                          if (mounted) {
                            setState(() {
                              isFull = !isFull;
                            });
                          }
                        },
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 30,
                            top: size.width * 10,
                            bottom: size.width * 10),
                        child: Text(
                          isFull ? '排查人意见:' : '隐患描述：',
                          style: TextStyle(
                              color: Color(0xff343434),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: ClipRRect(
                          child: Container(
                              height: size.width * 160,
                              color: Color(0xffF2F2F2).withOpacity(0.5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            isFull ? '请输入意见...' : '请输入内容...',
                                        hintStyle: TextStyle(
                                            color: Color(0xffC8C8C8),
                                            fontSize: size.width * 24),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      !isFull
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * 30,
                                      top: size.width * 10,
                                      bottom: size.width * 10),
                                  child: Text(
                                    '拍照:',
                                    style: TextStyle(
                                        color: Color(0xff343434),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyImageCarma(
                                  title: "隐患排查",
                                  name: '',
                                  purview: '隐患排查',
                                )
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 50, right: size.width * 50),
                        child: GestureDetector(
                          onTap: _sumbit,
                          child: Container(
                            height: size.width * 75,
                            // width: size.width * 505,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: size.width * 100),
                            decoration: BoxDecoration(
                              color: Color(0xff3074FF),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 8)),
                            ),
                            child: Text(
                              '确定',
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
          ),
        ));
  }
}
