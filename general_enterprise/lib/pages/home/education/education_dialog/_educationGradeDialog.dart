import 'package:enterprise/common/myRatingBar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EducationGradeDialog extends StatefulWidget {
  EducationGradeDialog(
      {this.interfaceId, this.resourcesId, this.typeId, this.callback});
  final int interfaceId;
  final int resourcesId;
  final int typeId;
  final Function callback;
  @override
  _EducationGradeDialogState createState() => _EducationGradeDialogState();
}

class _EducationGradeDialogState extends State<EducationGradeDialog> {
  double score;
  Widget build(BuildContext context) {
    return Container(
      //弹出框的具体事件
      child: Material(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: size.width * 467,
                          margin: EdgeInsets.only(
                              left: size.width * 90,
                              right: size.width * 90,
                              bottom: size.width * 30,
                              top: size.width * 10),
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(""))),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: size.width * 561,
                          margin: EdgeInsets.only(
                              left: size.width * 45,
                              right: size.width * 45,
                              bottom: size.width * 53,
                              top: size.width * 25),
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(""))),
                  Container(
                    width: size.width * 655,
                    height: size.width * 500,
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: []),
                    margin: EdgeInsets.only(
                        bottom: size.width * 74, top: size.width * 35),
                    padding: EdgeInsets.all(size.width * 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.width * 20),
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: size.width * 5,
                                      child: Container(
                                        height: size.width * 11,
                                        width: size.width * 267,
                                        color: Color(0xffFFAB1D),
                                      )),
                                  Text(
                                    '期待你的评分',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 44,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.clear,
                                color: Color(0xffC9C9C9),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 50,
                        ),
                        RatingBar(
                          clickable: true,
                          size: 40,
                          borderStars:
                              "assets/images/icon_unchecked_starts.png",
                          stars: "assets/images/icon_checked_emptyStars.png",
                          padding: 10,
                          onValueChangedCallBack: (value) {
                            score = value;
                          },
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Map data = {
                              "resourcesId": widget.resourcesId,
                              "typeId": widget.typeId,
                              "score": score,
                            };
                            myDio
                                .request(
                                    type: 'post',
                                    url: Interface.postScoreByResourcesId,
                                    data: data)
                                .then((value) {
                              Fluttertoast.showToast(msg: '成功');
                              Navigator.pop(context);
                              widget.callback();
                            });
                          },
                          child: Container(
                            width: size.width * 497,
                            height: size.width * 84,
                            margin: EdgeInsets.only(bottom: size.width * 50),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff3174FF),
                                    Color(0xff1C3AEA),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            alignment: Alignment.center,
                            child: Text(
                              '提交',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 32),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
