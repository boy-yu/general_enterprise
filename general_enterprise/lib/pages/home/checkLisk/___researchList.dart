import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ResearchList extends StatefulWidget {
  @override
  _ResearchListState createState() => _ResearchListState();
}

class _ResearchListState extends State<ResearchList> {
  _getText(int status, int isPrincipal) {
    if (status == 0) {
      if (isPrincipal == 0) {
        return '投票';
      } else {
        return '选定教材';
      }
    } else {
      if (isPrincipal == 0) {
        return '修改投票';
      } else {
        return '修改选定';
      }
    }
  }

  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('培训需求问卷'),
        child: Container(
          color: Colors.white,
          child: MyRefres(
              child: (index, list) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          '/checkList/researchListDetails',
                          arguments: {
                            'isPrincipal': list[index]['isPrincipal'],
                            'name': list[index]['name'].toString(),
                            'id': list[index]['id']
                          }).then((value) {
                        // 返回值
                        _throwFunc.run();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 30,
                          vertical: size.width * 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 8)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1.0,
                                blurRadius: 1.0)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(size.width * 25),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_mylist_edu_twolist.png',
                                    height: size.width * 90,
                                    width: size.width * 90,
                                  ),
                                  SizedBox(width: size.width * 25),
                                  Container(
                                    width: size.width * 230,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index]['name'],
                                          style: TextStyle(
                                              color: Color(0xff404040),
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: size.width * 15,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: size.width * 22),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: '发起部门：',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff404040))),
                                                TextSpan(
                                                    text: list[index][
                                                            'sponsorDepartment']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff3074FF))),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: size.width * 40,
                                        width: size.width * 119,
                                        decoration: BoxDecoration(
                                            color: Color(0xff3869FC),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 4))),
                                        alignment: Alignment.center,
                                        child: Text(
                                          _getText(list[index]['status'],
                                              list[index]['isPrincipal']),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.width * 16,
                                      ),
                                      Text(
                                        list[index]['isPrincipal'] == 0
                                            ? '请选择您想学习的教材'
                                            : '请为您此次调研提供学习意见',
                                        style: TextStyle(
                                            fontSize: size.width * 20,
                                            color: Color(0xff3666FB)),
                                      )
                                    ],
                                  )
                                ],
                              )),
                          Container(
                            width: double.infinity,
                            height: size.width * 1,
                            color: Color(0xffE8E8E8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 25,
                                vertical: size.width * 15),
                            child: Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style:
                                          TextStyle(fontSize: size.width * 20),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '发起人：',
                                            style: TextStyle(
                                                color: Color(0xff404040),
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: list[index]['sponsorName']
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xff404040))),
                                      ]),
                                ),
                                Spacer(),
                                RichText(
                                  text: TextSpan(
                                      style:
                                          TextStyle(fontSize: size.width * 20),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '截止时间：',
                                            style: TextStyle(
                                                color: Color(0xff404040),
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        list[index]['endTime'])
                                                .toString()
                                                .substring(0, 10)
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xff404040))),
                                      ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              // data: data,
              // type: '风险不受控',
              // listParam: "records",
              throwFunc: _throwFunc,
              page: true,
              url: Interface.getEducationTrainingResearchProcessingList,
              method: 'get'),
        ));
  }
}
