import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueResponse extends StatefulWidget {
  @override
  _EmergencyRescueResponseState createState() =>
      _EmergencyRescueResponseState();
}

class _EmergencyRescueResponseState extends State<EmergencyRescueResponse> {
  Map data = {
    "id": -1,
    "alarm": "",
    "informationFeedback": "",
    "centerPlace": "",
    "openInformationNetwork": "",
    "deploymentEmergencyResources": "",
    "siteCommand": "",
    "personnelRescue": "",
    "greatWall": "",
    "medicalAid": "",
    "alert": "",
    "evacuation": "",
    "environmentalProtection": "",
    "tieldMonitoring": "",
    "expertSupport": "",
    "requestReinforcements": "",
    "expandReportingHigherLevel": "",
    "siteCleaning": "",
    "removeAlert": "",
    "handling": "",
    "investigation": "",
    "companyId": -1,
    "summarizes": "",
    "createDate": "",
    "modifyDate": ""
  };

  @override
  void initState() {
    super.initState();
    _getResponseData();
  }

  _getResponseData(){
    myDio.request(
      type: 'get',
      url: Interface.getEREesponse,
      // queryParameters: {
      //   'type': '事故级别'
      // }
    ).then((value) {
      if (value is Map) {
        data = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: size.width * 29,
                    width: size.width * 7.1,
                    color: Color(0xff2D69FB),
                    margin: EdgeInsets.only(
                        top: size.width * 30,
                        bottom: size.width * 30,
                        right: size.width * 15),
                  ),
                  Text(
                    '警情判断响应级别',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 20, size.width * 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '报警：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['alarm'],
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '信息反馈：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['informationFeedback'],
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        SizedBox(
          height: size.width * 15,
        ),
        Container(
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: size.width * 29,
                    width: size.width * 7.1,
                    color: Color(0xff2D69FB),
                    margin: EdgeInsets.only(
                        top: size.width * 30,
                        bottom: size.width * 30,
                        right: size.width * 15),
                  ),
                  Text(
                    '应急启动上报派出单位',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 20, size.width * 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '中心人员到位：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['centerPlace'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '信息网络开通：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['openInformationNetwork'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '应急资源调配：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['deploymentEmergencyResources'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '现场指挥到位：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['siteCommand'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        SizedBox(
          height: size.width * 15,
        ),
        Container(
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: size.width * 29,
                    width: size.width * 7.1,
                    color: Color(0xff2D69FB),
                    margin: EdgeInsets.only(
                        top: size.width * 30,
                        bottom: size.width * 30,
                        right: size.width * 15),
                  ),
                  Text(
                    '救援行动',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 20, size.width * 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '人员救助：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['personnelRescue'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '工程抢险：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['greatWall'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '医疗救护：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['medicalAid'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '现场警戒：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['alert'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '人员疏散：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['evacuation'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '环境保护：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['environmentalProtection'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '现场监测：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['tieldMonitoring'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '专家支持：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['expertSupport'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        SizedBox(
          height: size.width * 15,
        ),
        Container(
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: size.width * 29,
                    width: size.width * 7.1,
                    color: Color(0xff2D69FB),
                    margin: EdgeInsets.only(
                        top: size.width * 30,
                        bottom: size.width * 30,
                        right: size.width * 15),
                  ),
                  Text(
                    '事态控制',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 20, size.width * 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '请求增援：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['requestReinforcements'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '扩大应急上报更高响应级别：',
                          style: TextStyle(
                              color: Color(0xff888888),
                              fontSize: size.width * 26),
                        ),
                        Expanded(
                          child: Text(
                            data['expandReportingHigherLevel'].toString(),
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 26),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        SizedBox(
          height: size.width * 15,
        ),
        Container(
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: size.width * 29,
                    width: size.width * 7.1,
                    color: Color(0xff2D69FB),
                    margin: EdgeInsets.only(
                        top: size.width * 30,
                        bottom: size.width * 30,
                        right: size.width * 15),
                  ),
                  Text(
                    '应急恢复',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 20, size.width * 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '现场清理：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['siteCleaning'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '解除警戒',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['removeAlert'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '善后处理：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Text(
                          data['handling'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffE5E5E5),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '事件调查：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data['investigation'].toString(),
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 26),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        SizedBox(
          height: size.width * 15,
        ),
        Container(
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: size.width * 29,
                    width: size.width * 7.1,
                    color: Color(0xff2D69FB),
                    margin: EdgeInsets.only(
                        top: size.width * 30,
                        bottom: size.width * 30,
                        right: size.width * 15),
                  ),
                  Text(
                    '应急结束',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 20, size.width * 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 220,
                      child: Text(
                        '总结评审：',
                        style: TextStyle(
                            color: Color(0xff888888),
                            fontSize: size.width * 26),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        data['summarizes'].toString(),
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 26),
                      ),
                    ),
                  ],
                ),
              ),
            ])),
      ],
    );
  }
}
