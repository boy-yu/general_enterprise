import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class TextbookType {
  String title;
  int id;
  bool unfold;
  List<TextbookType> textbookTypeList;
  TextbookType(
      {this.title = '',
      this.unfold = false,
      @required this.textbookTypeList,
      @required this.id});
}

class EduTextbookType extends StatefulWidget {
  final List boxData;
  const EduTextbookType({@required this.boxData});

  @override
  _EduTextbookTypeState createState() => _EduTextbookTypeState();
}

class _EduTextbookTypeState extends State<EduTextbookType> {
  bool show = false;
  @override
  void initState() {
    super.initState();
    init(widget.boxData[0]['id']);
  }

  init(int id) {
    myDio.request(
        type: 'get',
        url: Interface.getResourcesTypeSubordinate,
        queryParameters: {"parentId": id}).then((value) {
      if (value is List) {
        data.clear();
        value.forEach((element) {
          data.add(TextbookType(
              id: element["id"],
              title: element['name'],
              unfold: false,
              textbookTypeList: []));
        });
      }
      setState(() {
        show = true;
      });
    });
  }

  List<TextbookType> data = [];

  int select = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('教材类型'),
        child: Column(
          children: [
            Container(
              height: size.width * 73,
              color: Colors.white,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.boxData.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    select = index;
                    init(widget.boxData[index]['id']);
                  },
                  child: Container(
                      width: size.width * 370,
                      padding: EdgeInsets.only(top: size.width * 15),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                        widget.boxData[index]['name'] ?? '',
                          style: TextStyle(
                              color: index == select
                                  ? Color(0xff3074FF)
                                  : Color(0xff666666),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.bold)),
                              Spacer(),
                              index == select ? Container(
                                height: size.width * 5,
                                width: size.width * 150,
                                color: Colors.blue,
                              ): Container(),
                        ],
                      )),
                );
              }
            ),
            ),
            Expanded(child: Container(
                color: Color(0xffFFFFFF),
                child: Transtion(
                    ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            
                            // data[index].unfold ? Color(0xffD1E0FF) : Colors.white,
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: size.width * 25,
                            //     vertical: size.width * 10),
                            // decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.all(
                            //         Radius.circular(size.width * 5)),
                            //     boxShadow: [
                            //       BoxShadow(
                            //           color: Colors.black12,
                            //           blurRadius: 1.0,
                            //           spreadRadius: 1.0)
                            //     ]),
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      data[index].unfold = !data[index].unfold;
                                      myDio.request(
                                          type: "get",
                                          url: Interface
                                              .getResourcesTypeSubordinate,
                                          queryParameters: {
                                            "parentId": data[index].id
                                          }).then((value) {
                                        if (value is List) {
                                          data[index].textbookTypeList.clear();
                                          value.forEach((element) {
                                            data[index].textbookTypeList.add(
                                                TextbookType(
                                                    id: element["id"],
                                                    title: element['name'],
                                                    unfold: false,
                                                    textbookTypeList: []));
                                          });
                                        }
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: data[index].unfold ? Color(0xffD1E0FF) : Colors.white,
                                        border: Border.all(width: size.width * 1, color: data[index].unfold ? Color(0xff3074FF) : Color(0xffF2F2F2)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 28,
                                          vertical: size.width * 40),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/iconedu__text_book_type_two.png',
                                            height: size.width * 20,
                                            width: size.width * 24,
                                          ),
                                          SizedBox(
                                            width: size.width * 20,
                                          ),
                                          Text(
                                            data[index].title,
                                            style: TextStyle(
                                                fontSize: size.width * 24,
                                                color: Color(0xff404040),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          !data[index].unfold
                                              ? Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: size.width * 40,
                                                  color: Color(0xff404040),
                                                )
                                              : Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: size.width * 40,
                                                  color: Color(0xff404040),
                                                )
                                        ],
                                      ),
                                    )),
                                data[index].unfold &&
                                        data[index].textbookTypeList.isNotEmpty
                                    ? Column(
                                //       myCollectData
                                // .asMap()
                                // .keys
                                // .map((index) =>

                                        children: data[index]
                                            .textbookTypeList
                                            .asMap()
                                .keys
                                .map((_index) => Column(
                                                  children: [
                                                    Container(
                                                      color: _index % 2 == 0 ? Colors.white : Color(0xffF7F7F7),
                                                      padding: EdgeInsets.fromLTRB(size.width * 60, size.width * 24, size.width * 24, size.width * 24),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: size.width *
                                                                500,
                                                            child: Text(
                                                              data[index].textbookTypeList[_index].title,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          20,
                                                                  color: Color(
                                                                      0xff404040)),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      '/home/education/eduTextbookList',
                                                                      arguments: {
                                                                    "id": data[index].textbookTypeList[_index].id
                                                                  }).then(
                                                                      (value) {
                                                                // 返回值
                                                              });
                                                            },
                                                            child: Container(
                                                              height:
                                                                  size.width *
                                                                      40,
                                                              width:
                                                                  size.width *
                                                                      100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        size.width *
                                                                            10)),
                                                                border: Border.all(
                                                                    width:
                                                                        size.width *
                                                                            1,
                                                                    color: Color(
                                                                        0xff3074FF)),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                '查看',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff3074FF),
                                                                    fontSize:
                                                                        size.width *
                                                                            20),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
                                      )
                                    : Container()
                              ],
                            ),
                          );
                        }),
                    show)))
          ],
        ));
  }
}
