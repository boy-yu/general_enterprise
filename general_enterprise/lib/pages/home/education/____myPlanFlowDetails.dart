import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/education/My/demand.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class MyPlanFlowDetails extends StatefulWidget {
  MyPlanFlowDetails({this.id});
  final int id;
  @override
  _MyPlanFlowDetailsState createState() => _MyPlanFlowDetailsState();
}

class _MyPlanFlowDetailsState extends State<MyPlanFlowDetails> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Map data = {
    "resourcesList": [],
    "departmentNum": 0,
    "departmentList": []
  };

  List resourcesList = [];

  _init(){
    myDio.request(
        type: "get",
        url: Interface.getPlanDetailsById,
        queryParameters: {'id': widget.id}
    ).then((value) {
      if (value is Map) {
        data = value;
        resourcesList = data['resourcesList'];
      } 
      setState(() {
        show = true;
      });
    });
  }

  _click(bool type, List list) {
    WorkDialog.myDialog(context, () {}, 2,
        widget: Container(
            height: size.width * 600,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: list
                      .asMap()
                      .keys
                      .map((index) => Container(
                          width: size.width * 250,
                          height: size.width * 50,
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 20),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 20,
                              vertical: size.width * 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: placeHolder)),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Image.asset(
                                type
                                    ? 'assets/images/8691619248054_.pic_hd@2x.png'
                                    : 'assets/images/8681619248047_.pic_hd@2x.png',
                                height: size.width * 27,
                                width: size.width * 24,
                              ),
                              SizedBox(
                                width: size.width * 5,
                              ),
                              Expanded(
                                  child: Text(list[index]['name'],
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xff333333)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          )))
                      .toList()),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('在线学习计划'),
        child: Transtion(
            ListView(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("参训对象：",
                              style: TextStyle(fontSize: size.width * 25)),
                          SizedBox(width: 30),
                          GestureDetector(
                            onTap: (){
                                _click(true, data['departmentList']);
                            },
                            child: Container(
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  color: Color(0xff3869FC),
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Text(
                                "共${data['departmentList'].length}个部门",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "员工必修教材>",
                        style: TextStyle(
                          fontSize: size.width * 26, 
                          color: Color(0xff333333), 
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Column(
                        children: resourcesList
                            .asMap()
                            .keys
                            .map((index) => DemandTextBook(
                                data: resourcesList[index],
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0))
                        ).toList()
                      ),
                    ],
                  )
                ),
              ],
            ),
            show));
  }
}
