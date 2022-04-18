import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddPeople extends StatefulWidget {
  DialogAddPeople({this.onPress});
  final Function onPress;
  @override
  _DialogAddPeopleState createState() => _DialogAddPeopleState();
}

class _DialogAddPeopleState extends State<DialogAddPeople> {
  final controller = TextEditingController();
  TextEditingController _certificateController = TextEditingController();
  Counter _counter = Provider.of<Counter>(myContext);
  _empty() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.changeSubmitDates("申请作业", {"title": "新增作业人", "value": []});
    });
  }

  @override
  void initState() {
    super.initState();
    _empty();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                bottom: size.width * 20,
                left: size.width * 57,
                right: size.width * 57),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text(
                    '请添加人员',
                    style: TextStyle(
                        color: Color(0xff666666), fontSize: size.width * 28),
                  ),
                ),
                Center(
                  child: Container(
                    height: size.width * 80,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: '请输入姓名',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xffB1B1B3)),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xFFDEE2FC), width: 0.5),
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Center(
                  child: Container(
                    height: size.width * 80,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _certificateController,
                      decoration: InputDecoration(
                        hintText: '请输入证书名称',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xffB1B1B3)),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xFFDEE2FC), width: 0.5),
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Container(
                    height: size.width * 300,
                    child: MyImageCarma(
                      purview: "申请作业",
                      title: "新增作业人",
                      score: 3,
                    )),
                Container(
                  width: size.width * 500,
                  height: size.width * 75,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff3174FF))),
                    onPressed: () {
                      List imageList = [];
                      String image = '';
                      _counter.submitDates['申请作业'].forEach((ele) {
                        if (ele['title'] == '新增作业人') {
                          imageList = ele['value'];
                        }
                      });
                      for (var i = 0; i < imageList.length; i++) {
                        if (i == imageList.length - 1) {
                          image += imageList[i];
                        } else {
                          image += imageList[i] + '|';
                        }
                      }
                      widget.onPress(
                          image: image,
                          name: controller.text,
                          certificateName: _certificateController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '提交',
                      style: TextStyle(fontSize: size.width * 36),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
