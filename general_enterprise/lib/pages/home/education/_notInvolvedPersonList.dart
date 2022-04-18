import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class NotInvolvedPersonList extends StatefulWidget {
  NotInvolvedPersonList({this.notInvolvedList});
  final List notInvolvedList;
  @override
  _NotInvolvedPersonListState createState() => _NotInvolvedPersonListState();
}

class _NotInvolvedPersonListState extends State<NotInvolvedPersonList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('未计划培训人员列表'),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: size.width * 68,
              color: Color(0xffF7F7F7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 150,
                    alignment: Alignment.center,
                    child: Text(
                      '序号',
                      style: TextStyle(
                        fontSize: size.width * 24,
                        color: Color(0xffA8A8A8)
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 220,
                    alignment: Alignment.center,
                    child: Text(
                      '姓名',
                      style: TextStyle(
                        fontSize: size.width * 24,
                        color: Color(0xffA8A8A8)
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 370,
                    alignment: Alignment.center,
                    child: Text(
                      '部门职务',
                      style: TextStyle(
                        fontSize: size.width * 24,
                        color: Color(0xffA8A8A8)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: widget.notInvolvedList.isNotEmpty ? ListView.builder(
                itemCount: widget.notInvolvedList.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Container(
                        height: size.width * 68,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: size.width * 150,
                              alignment: Alignment.center,
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff414040)
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 220,
                              alignment: Alignment.center,
                              child: Text(
                                widget.notInvolvedList[index]['nickname'],
                                style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff414040)
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 370,
                              alignment: Alignment.center,
                              child: Text(
                                widget.notInvolvedList[index]['deAndPo'],
                                style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xffA8A8A8)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xffDDDDDD),
                        height: size.width * 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  );
                }
              ) : Center(
                child: Text(
                  '暂无数据'
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}