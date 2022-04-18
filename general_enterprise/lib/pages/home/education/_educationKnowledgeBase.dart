import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

/*
 *  知识库 
 */
class EducationKnowledgeBase extends StatefulWidget {
  @override
  _EducationKnowledgeBaseState createState() => _EducationKnowledgeBaseState();
}

class _EducationKnowledgeBaseState extends State<EducationKnowledgeBase> {
  List knowledgeBaseList = [
    {
      'title': 'MSDS数据库',
      'icon': "assets/images/icon_MSDS_database.png",
    },
    {
      'title': '重点监管危险化学品数据库',
      'icon': "assets/images/icon_hazardous_database.png",
    },
    {
      'title': '重点监管化工工艺数据库',
      'icon': "assets/images/icon_process_database.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('知识库'),
        child: ListView.builder(
            itemCount: knowledgeBaseList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      '/home/education/educationDatabaseList',
                      arguments: {
                        "title": knowledgeBaseList[index]['title'],
                        "kBIndex": index + 1
                      }).then((value) {
                    // 返回值
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 20, vertical: size.width * 10),
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(size.width * 20),
                      child: Row(
                        children: [
                          Image.asset(
                            knowledgeBaseList[index]['icon'],
                            height: size.width * 88,
                            width: size.width * 88,
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            knowledgeBaseList[index]['title'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xffBEC2CD),
                          ),
                        ],
                      ),
                    ))),
              );
            }));
  }
}
