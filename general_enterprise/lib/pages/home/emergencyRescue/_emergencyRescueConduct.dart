import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueConduct extends StatefulWidget {
  @override
  _EmergencyRescueConductState createState() => _EmergencyRescueConductState();
}

class _EmergencyRescueConductState extends State<EmergencyRescueConduct> {
  Map data = {
    "id": -1,
    "commanderName": "",
    "commanderPhone": "",
    "deputyCommanderName": "",
    "deputyCommanderPhone": "",
    "directorName": "",
    "directorPhone": "",
    "directorPosition": "",
  };

  bool isShow = false;

  List teams = [];

  @override
  void initState() {
    super.initState();
    _getConductData();
    _getTeamsData();
  }

  _getConductData(){
    myDio.request(
      type: 'get',
      url: Interface.getEREmergencyHeadquarters,
      queryParameters: {"type": 1}
    ).then((value) {
      if (value is Map) {
        data = value['erHeadquartersAndOffice'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getTeamsData(){
    myDio.request(
      type: 'get',
      url: Interface.getERHeadquartersRescueTeam,
      queryParameters: {
        "current": 1,
        'size': 1000
      }
    ).then((value) {
      if (value is Map) {
        teams = value['records'];
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
          padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '指挥部',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      isShow = !isShow;
                      setState(() {});
                    },
                    child: Icon(
                      isShow ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Color(0xff4988FD),
                      size: 30,
                    ),
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                color: Color(0xffE6E6E6),
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: size.width * 10),
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 180,
                    child: Text(
                      '指挥长：',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: size.width * 26
                      ),
                    ),
                  ),
                  Text(
                    data['commanderName'] != null ? data['commanderName'].toString() : '',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 26
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context, 
                        '/emergencyRescue/__emergencyRescueHeadDetails',
                      );
                    },
                    child: Text(
                      '详情',
                      style: TextStyle(
                        color: Color(0xff3174FF),
                        fontSize: size.width * 26
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.width * 10,
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 180,
                    child: Text(
                      '指挥长电话：',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: size.width * 26
                      ),
                    ),
                  ),
                  Text(
                    data['commanderPhone'] != null ? data['commanderPhone'].toString() : '',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 26
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.width * 10,
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 180,
                    child: Text(
                      '副指挥：',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: size.width * 26
                      ),
                    ),
                  ),
                  Text(
                    data['deputyCommanderName'] != null ? data['deputyCommanderName'].toString() : '',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 26
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.width * 10,
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 180,
                    child: Text(
                      '副指挥电话：',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: size.width * 26
                      ),
                    ),
                  ),
                  Text(
                    data['deputyCommanderPhone'] != null ? data['deputyCommanderPhone'].toString() : '',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 26
                    ),
                  ),
                ],
              ),        
            ],
          ),
        ),
        isShow ? Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE6E6E6),
                margin: EdgeInsets.only(bottom: size.width * 10),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 40),
                child: Text(
                  '应急办公室',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: size.width * 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.width * 1,
                      width: double.infinity,
                      color: Color(0xffE6E6E6),
                      margin: EdgeInsets.symmetric(vertical: size.width * 10),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: size.width * 180,
                                child: Text(
                                  '负责人：',
                                  style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 26
                                  ),
                                ),
                              ),
                              Text(
                                data['directorName'] != null ? data['directorName'].toString() : '',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 26
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(
                                    context, 
                                    '/emergencyRescue/__emergencyRescueOfficeDetails',
                                  );
                                },
                                child: Text(
                                  '详情',
                                  style: TextStyle(
                                    color: Color(0xff3174FF),
                                    fontSize: size.width * 26
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: size.width * 180,
                                child: Text(
                                  '职务：',
                                  style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 26
                                  ),
                                ),
                              ),
                              Text(
                                data['directorPosition'] != null ? data['directorPosition'].toString() : '',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 26
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: size.width * 180,
                                child: Text(
                                  '负责人电话：',
                                  style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 26
                                  ),
                                ),
                              ),
                              Text(
                                data['directorPhone'] != null ? data['directorPhone'].toString() : '',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 26
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) 
        : Container(),
        Padding(
          padding: EdgeInsets.all(size.width * 20),
          child: Text(
            '救援队伍',
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: size.width * 30,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        teams.isNotEmpty ? ListView.builder(
          itemCount: teams.length,
          shrinkWrap: true, 								//解决无限高度问题
		      physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(
                  context, 
                  '/emergencyRescue/__emergencyRescueTeamDetails',
                  arguments: {"id": teams[index]['id']}
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: size.width * 20, right: size.width * 20, bottom: size.width * 20),
                padding: EdgeInsets.symmetric(vertical: size.width * 10, horizontal: size.width * 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '队伍名称：',
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 28
                          ),
                        ),
                        Spacer(),
                        Text(
                          teams[index]['rescueTeamName'].toString(),
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '主要负责人：',
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 28
                          ),
                        ),
                        Spacer(),
                        Text(
                          teams[index]['mainHead'].toString(),
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '电话：',
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 28
                          ),
                        ),
                        Spacer(),
                        Text(
                          teams[index]['onDutyPhone'].toString(),
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ) : Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: size.width * 100),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/empty@2x.png",
                  height: size.width * 288,
                  width: size.width * 374,
                ),
                Text('暂无救援队伍')
              ],
            )),
      ],
    );
  }
}