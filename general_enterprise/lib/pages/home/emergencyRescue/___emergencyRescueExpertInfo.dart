import 'package:enterprise/common/DashedDecoration.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueExpertInfo extends StatefulWidget {
  EmergencyRescueExpertInfo({this.id});
  final int id;
  @override
  _EmergencyRescueExpertInfoState createState() => _EmergencyRescueExpertInfoState();
}

class _EmergencyRescueExpertInfoState extends State<EmergencyRescueExpertInfo> {
  Map data = {
    "id": -1,
    "name": "",
    "photo": "",
    "sex": "",
    "organizationCode": "",
    "national": "",
    "birthDate": "",
    "nativePlace": "",
    "idNo": "",
    "health": "",
    "politicsStatus": "",
    "schoolGraduation": "",
    "professional": "",
    "education": "",
    "workUnits": "",
    "entryDate": "",
    "unitZipCode": "",
    "unitZipAddress": "",
    "officePhone": "",
    "fax": "",
    "dutyName": "",
    "duty": "",
    "expertsType": "",
    "phone": "",
    "familyPhone": "",
    "email": "",
    "familyAddress": "",
    "expertSkills": "",
    "jobResume": "",
    "accidentDisposalExperience": "",
    "createDate": "",
    "modifyDate": "",
    "isGovernmentCreate": 0,
    "qualification": ""
  };

  @override
  void initState() {
    super.initState();
    _getExpertInfo();
  }

  _getExpertInfo(){
    myDio.request(
      type: 'get',
      url: Interface.getERExperts + widget.id.toString(),
      // queryParameters: {"type": 2}
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
    return MyAppbar(
      title: Text('专家信息'),
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.width * 25, horizontal: size.width * 20),
              decoration: DashedDecoration(
                dashedColor: Color(0xffDCDCDC),
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(size.width * 30),
                    constraints: BoxConstraints.expand(
                      width: size.width * 113,
                      height: size.width * 113
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: data['photo'] != '' ? NetworkImage(data['photo']) : AssetImage('assets/images/test_paper.jpg')
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 40, vertical: size.width * 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_expert_info_name.png',
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      '姓名        ',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: size.width * 28
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  data['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_expert_info_nation.png',
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      '民族',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: size.width * 28
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  data['national'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_expert_info_sex.png',
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      '性别        ',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: size.width * 28
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  data['sex'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_expert_info_date.png',
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      '出生日期',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: size.width * 28
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  data['birthDate'].toString().length > 10 ? data['birthDate'].toString().substring(0, 10) : '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_expert_info_origo.png',
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      '籍贯',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: size.width * 28
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  data['nativePlace'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_expert_info_health.png',
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      '健康状况',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: size.width * 28
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  data['health'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '身份证号',
                            style: TextStyle(
                              color: Color(0xffB1B1B1),
                              fontSize: size.width * 28
                            ),
                          ),
                        ),
                        Text(
                          data['idNo'],
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '移动电话',
                            style: TextStyle(
                              color: Color(0xffB1B1B1),
                              fontSize: size.width * 28
                            ),
                          ),
                        ),
                        Text(
                          data['phone'],
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '电子邮箱',
                            style: TextStyle(
                              color: Color(0xffB1B1B1),
                              fontSize: size.width * 28
                            ),
                          ),
                        ),
                        Text(
                          data['email'],
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '传真',
                            style: TextStyle(
                              color: Color(0xffB1B1B1),
                              fontSize: size.width * 28
                            ),
                          ),
                        ),
                        Text(
                          data['fax'],
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '家庭电话',
                            style: TextStyle(
                              color: Color(0xffB1B1B1),
                              fontSize: size.width * 28
                            ),
                          ),
                        ),
                        Text(
                          data['familyPhone'],
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width * 220,
                          child: Text(
                            '家庭地址',
                            style: TextStyle(
                              color: Color(0xffB1B1B1),
                              fontSize: size.width * 28
                            ),
                          ),
                        ),
                        Text(
                          data['familyAddress'],
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.width * 10,
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                  child: Text(
                    '教育信息和政治面貌',
                    style: TextStyle(
                      fontSize: size.width * 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffE9E9E9),
                  height: size.width * 2,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '最高学历：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['education'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),                      
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '政治面貌：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['politicsStatus'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '毕业院校：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['schoolGraduation'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ), 
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '所学专业：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['professional'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 10,
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                  child: Text(
                    '工作信息',
                    style: TextStyle(
                      fontSize: size.width * 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffE9E9E9),
                  height: size.width * 2,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '工作单位：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['workUnits'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '机构代码：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['organizationCode'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '入职日期：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['entryDate'].toString().length > 10 ? data['entryDate'].toString().substring(0, 10) : '',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '单位地址：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['unitZipAddress'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '办公室电话：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['officePhone'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '行政职务：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['duty'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: size.width * 250,
                      //       child: Text(
                      //         '工作简历描述：',
                      //         style: TextStyle(
                      //           color: Color(0xff888888),
                      //           fontSize: size.width * 26
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //       data['jobResume'],
                      //         style: TextStyle(
                      //           color: Color(0xff333333),
                      //           fontSize: size.width * 26
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: size.width * 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 10,
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                  child: Text(
                    '专业信息',
                    style: TextStyle(
                      fontSize: size.width * 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffE9E9E9),
                  height: size.width * 2,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '专家类型：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['expertsType'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: size.width * 250,
                      //       child: Text(
                      //         '专业特长描述：',
                      //         style: TextStyle(
                      //           color: Color(0xff888888),
                      //           fontSize: size.width * 26
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //         data['expertSkills'],
                      //         style: TextStyle(
                      //           color: Color(0xff333333),
                      //           fontSize: size.width * 26
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // Container(
                      //   height: size.width * 1,
                      //   width: double.infinity,
                      //   color: Color(0xffE5E5E5),
                      //   margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      // ),
                     
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: size.width * 250,
                      //       child: Text(
                      //         '事故处置经历：',
                      //         style: TextStyle(
                      //           color: Color(0xff888888),
                      //           fontSize: size.width * 26
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //         data['accidentDisposalExperience'],
                      //         style: TextStyle(
                      //           color: Color(0xff333333),
                      //           fontSize: size.width * 26
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // Container(
                      //   height: size.width * 1,
                      //   width: double.infinity,
                      //   color: Color(0xffE5E5E5),
                      //   margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      // ),
                      
                      Row(
                        children: [
                          Container(
                            width: size.width * 250,
                            child: Text(
                              '职称：',
                              style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26
                              ),
                            ),
                          ),
                          Text(
                            data['dutyName'],
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 10,
          ),
          Container(
            color: Colors.white,
            height: size.width * 50,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}