import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EduAddPeople extends StatefulWidget {
  @override
  _EduAddPeopleState createState() => _EduAddPeopleState();
}

class _EduAddPeopleState extends State<EduAddPeople> {
  final controller = TextEditingController();

  int num = 0;

  List<int> peopleIds = [];

  List test = [];

  Map queryParameters = {};

  _searchLegislation(String keywords) {
    queryParameters = {
      'keywords': keywords,
    };
  }

  ThrowFunc _throwFunc = ThrowFunc();

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return MyAppbar(
      title: Text('新增问卷执行人'),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Container(
              height: size.width * 75,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 20),
              padding: EdgeInsets.all(size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 37)),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 1.0),
                  ]),
              child: Container(
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(size.width * 17),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: '请输入关键字',
                    hintStyle: TextStyle(
                      fontSize: size.width * 28,
                      color: Color(0xffA6A6A6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  maxLines: 1,
                  onSubmitted: (value) {
                    _searchLegislation(value);
                    _context.addPeopleSearch(value);
                    _throwFunc.run(argument: queryParameters);
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: size.width * 30),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 10),
            child: Row(
              children: [
                Spacer(),
                Text(
                  '已选择执行人：' + num.toString() + '位',
                  style: TextStyle(
                      color: Color(0xff3074FF),
                      fontSize: size.width * 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: MyRefres(
                callback: (haha) {
                  test = haha;
                },
                child: (index, list) => Padding(
                  padding: EdgeInsets.only(left: size.width * 40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(list[index]['select'] == null){
                                list[index]['select'] = 1;
                                num += 1;
                              }else{
                                list[index]['select'] = null;
                                num -= 1;
                              }
                              setState(() {});
                            },
                            child: Image.asset(
                              list[index]['select'] == 1
                                      ? 'assets/images/gou@2x.png'
                                      : 'assets/images/quan@2x.png',
                                  height: size.width * 36,
                                  width: size.width * 36,
                            ),
                          ),
                          Container(
                            height: size.width * 86,
                            width: size.width * 86,
                            margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1.0,
                                  blurRadius: 1.0
                                )
                              ],
                              border: list[index]['select'] == 1 ? Border.all(color: Color(0xFF445CFE), width: size.width * 2) : null,
                            ),
                            alignment: Alignment.center,
                            child: list[index]['photoUrl'] != '' ? Container(
                              height: size.width * 69,
                              width: size.width * 69,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                image: DecorationImage(
                                  image: NetworkImage(list[index]['photoUrl']),  
                                    // fit: BoxFit.cover,
                                ),
                              ),
                            ) : Container(
                              height: size.width * 69,
                              width: size.width * 69,
                              decoration: BoxDecoration(
                                color: Color(0xffF5F5F7),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index]['nickname'],
                                style: TextStyle(
                                  color: Color(0xff191A45),
                                  fontSize: size.width * 34,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Text(
                                list[index]['deAndPo'],
                                style: TextStyle(
                                  color: Color(0xffACACBC),
                                  fontSize: size.width * 26,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffF1F2F4),
                      ),
                    ],
                  ),
                ),
                // data: data,
                // type: '风险不受控',
                // listParam: "records",
                throwFunc: _throwFunc,
                page: true,
                url: Interface.getPrincipalListAll,
                queryParameters: queryParameters,
                method: 'get'
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  peopleIds = [];
                  for (var i = 0; i < test.length; i++) {
                    if (test[i]['select'] == 1) {
                      peopleIds.add(test[i]['id']);
                    }
                  }
                  Navigator.pop(context, peopleIds);
                },
                child: Container(
                  height: size.width * 60,
                  width: size.width * 240,
                  margin: EdgeInsets.symmetric(vertical: size.width * 30),
                  decoration: BoxDecoration(
                      color: Color(0xff0059FF),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 8))),
                  alignment: Alignment.center,
                  child: Text(
                    '确定',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
