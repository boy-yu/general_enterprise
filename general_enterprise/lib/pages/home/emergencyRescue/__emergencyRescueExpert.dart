import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

// class EmergencyRescueExpert extends StatefulWidget {
//   @override
//   _EmergencyRescueExpertState createState() => _EmergencyRescueExpertState();
// }

// class _EmergencyRescueExpertState extends State<EmergencyRescueExpert> {
//   List expertData = [
//     {
//       "index": 0,
//       "title": "专家",
//       "descript": "选择需要使用的",
//       "img": "assets/images/look.png",
//       "isClick": false
//     },
//     {
//       "index": 1,
//       "title": "专家库",
//       "descript": "选择需要使用的",
//       "img": "assets/images/apply.png",
//       "isClick": true
//     },
//   ];

//   PageController _controller;
//   int choosed = 0;
//   int oldPage = 0;

//   void initState() {
//     super.initState();
//     _controller = PageController(initialPage: choosed);
//     _controller.addListener(() {
//       if (oldPage != _controller.page.toInt()) {
//         choosed = _controller.page.toInt();
//         oldPage = choosed;
//         if (mounted) {
//           setState(() {});
//         }
//       }
//     });
//   }

//   Widget _changeTitle(width, item) {
//     Widget _widget;
//     if (item['title'] == '专家')
//       _widget = Expert();
//     else if (item['title'] == '专家库') _widget = ExpertDatabase();
//     return _widget;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyAppbar(
//       title: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
//             borderRadius: BorderRadius.all(Radius.circular(28))),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: expertData.map<Widget>((ele) {
//             return GestureDetector(
//               onTap: () {
//                 choosed = ele['index'];
//                 _controller.animateToPage(choosed,
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.easeIn);
//                 if (mounted) {
//                   setState(() {});
//                 }
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: choosed == ele['index'] ? Colors.white : null,
//                     borderRadius: BorderRadius.all(Radius.circular(50))),
//                 child: Text(
//                   ele['title'],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color:
//                           choosed == ele['index'] ? themeColor : Colors.white,
//                       fontSize: size.width * 35),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                     horizontal: size.width * 40, vertical: size.width * 10),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       child: PageView.builder(
//         controller: _controller,
//         itemBuilder: (context, index) => _changeTitle(size.width, expertData[index]),
//         itemCount: expertData.length,
//       ),
//     );
//   }
// }

class EmergencyRescueExpert extends StatefulWidget {
  @override
  _EmergencyRescueExpertState createState() => _EmergencyRescueExpertState();
}

class _EmergencyRescueExpertState extends State<EmergencyRescueExpert> {
  List data = [
    {
      'name': '张三',
      'major': '合成氨',
      'phone': '18942436698',
      'address': '成都市锦江区春熙路商圈',
      'type1': '资质',
      'type2': '协议'
    },
    {
      'name': '张三',
      'major': '合成氨',
      'phone': '18942436698',
      'address': '成都市锦江区春熙路商圈',
      'type1': '资质',
      'type2': '协议'
    },
    {
      'name': '张三',
      'major': '合成氨',
      'phone': '18942436698',
      'address': '成都市锦江区春熙路商圈',
      'type1': '资质',
      'type2': '协议'
    },
  ];

  @override
  void initState() {
    super.initState();
    _getExpert();
  }

  _getExpert() {
    myDio
        .request(
      type: 'get',
      url: Interface.getErExpertsListBySigning,
      // queryParameters: {"type": 2}
    )
        .then((value) {
      if (value is Map) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('专家'),
        child: data.isNotEmpty ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/emergencyRescue/___emergencyRescueExpertInfo',
                    arguments: {'id': data[index]['id']}
                  );
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 25),
                  margin: EdgeInsets.only(bottom: size.width * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.width * 30,
                            width: size.width * 6,
                            margin:
                                EdgeInsets.symmetric(vertical: size.width * 25),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      0.0,
                                      1.0
                                    ], //[渐变起始点, 渐变结束点]
                                    colors: [
                                      Color(0xff2AC79B),
                                      Color(0xff3174FF),
                                    ])),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            data[index]['name'],
                            style: TextStyle(
                                color: Color(0xff1C1C1D),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: size.width * 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 1,
                                horizontal: size.width * 15),
                            decoration: BoxDecoration(
                                color: Color(0xff3174FF).withOpacity(0.14),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            alignment: Alignment.center,
                            child: Text(
                              data[index]['education'].toString(),
                              style: TextStyle(
                                  color: Color(0xff3174FF),
                                  fontSize: size.width * 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Container(
                            height: size.width * 30,
                            width: size.width * 74,
                            decoration: BoxDecoration(
                                color: Color(0xff3174FF).withOpacity(0.14),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            alignment: Alignment.center,
                            child: Text(
                              data[index]['sex'].toString(),
                              style: TextStyle(
                                  color: Color(0xff3174FF),
                                  fontSize: size.width * 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffDCDCDC),
                        margin: EdgeInsets.only(bottom: size.width * 10),
                      ),
                      Row(
                        children: [
                          Text(
                            '所学专业：  ',
                            style: TextStyle(
                                color: Color(0xff858888),
                                fontSize: size.width * 26),
                          ),
                          Text(
                            data[index]['professional'].toString(),
                            style: TextStyle(
                              color: Color(0xff1C1C1D),
                              fontSize: size.width * 26,
                              // fontWeight: FontWeight.bold
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
                            '移动电话：  ',
                            style: TextStyle(
                                color: Color(0xff858888),
                                fontSize: size.width * 26),
                          ),
                          Text(
                            data[index]['phone'],
                            style: TextStyle(
                              color: Color(0xff1C1C1D),
                              fontSize: size.width * 26,
                              // fontWeight: FontWeight.bold
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
                            '家庭住址：  ',
                            style: TextStyle(
                                color: Color(0xff858888),
                                fontSize: size.width * 26),
                          ),
                          Text(
                            data[index]['familyAddress'].toString(),
                            style: TextStyle(
                              color: Color(0xff1C1C1D),
                              fontSize: size.width * 26,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 20,
                      ),
                    ],
                  ),
                ),
              );
            }) : Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: size.width * 300),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/empty@2x.png",
                  height: size.width * 288,
                  width: size.width * 374,
                ),
                Text('暂无专家')
              ],
            )),
    );
  }
}

// class ExpertDatabase extends StatefulWidget {
//   @override
//   _ExpertDatabaseState createState() => _ExpertDatabaseState();
// }

// class _ExpertDatabaseState extends State<ExpertDatabase> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
