import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmergencyOnDuty extends StatefulWidget {
  @override
  _EmergencyOnDutyState createState() => _EmergencyOnDutyState();
}

class _EmergencyOnDutyState extends State<EmergencyOnDuty> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    myDio.request(type: 'get', url: Interface.getDutySign).then((value) {
      if (value is List) {
        data = value;
        print(data);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('应急值守'),
        elevation: 0,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(bottom: size.width * 20),
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: lineGradBlue)),
            child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    data.isNotEmpty ? Container(
                      height: size.width * 1200,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: size.width * 60),
                      padding: EdgeInsets.only(bottom: size.width * 100),
                      child: ListView.builder(
                      itemCount: data.length ,
                      itemBuilder: (context, index){
                        return Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(left: size.width * 30, right: size.width * 30, top: size.width * 50),
                          padding: EdgeInsets.only(top: size.width * 60),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: size.width * 20, top: size.width * 15),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Color(0xff3072FE)),
                                width: 3,
                                height: 3,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data[index]['shiftName'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff466DC7),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                  ),
                                  Container(
                                    height: size.width * 120,
                                    width: size.width * 650,
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                                    child: Text(
                                      '请您于 ${data[index]['startDate']} - ${data[index]['endDate']}到公司进行值班，如你已到公司，请点击确认。',
                                      style: TextStyle(
                                        color: Color(0xff466DC7),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '谢谢！',
                                    style: TextStyle(
                                      color: Color(0xff466DC7),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      myDio.request(
                                        type: 'put',
                                        url: Interface.putSignIn,
                                        data: {
                                          "id": data[index]['id'],
                                        }).then((value) {
                                          Fluttertoast.showToast(msg: '确认成功');
                                          _init();
                                          setState(() {});
                                        });
                                    },
                                    child: Container(
                                      height: size.width * 60,
                                      width: size.width * 220,
                                      margin: EdgeInsets.only(top: size.width * 20, bottom: size.width * 50),
                                      decoration: BoxDecoration(
                                        color: Color(0xff0059FF),
                                        borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '确认',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 28
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                    ) : Container(),
                    Positioned(
                        top: 0,
                        right: 20,
                        child: Image.asset('assets/images/chahua@2x.png',
                            width: size.width * 93, height: size.width * 167))
                  ],
                )
          ),
        ));
  }
}