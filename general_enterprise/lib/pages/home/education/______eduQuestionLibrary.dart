import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduQuestionLibrary extends StatefulWidget {
  final List compulsoryList;
  final int index;
  EduQuestionLibrary({this.compulsoryList, this.index});
  @override
  _EduQuestionLibraryState createState() => _EduQuestionLibraryState();
}

class _EduQuestionLibraryState extends State<EduQuestionLibrary> {
  int choosed = 0;

  List data = [];

  @override
  void initState() {
    super.initState();
    choosed = widget.index;
    _getEducationQuestionLibraryByresourcesId();
  }

  _getEducationQuestionLibraryByresourcesId(){
    myDio.request(
      type: "get",
      url: Interface.getEduQuestionByresourcesId + widget.compulsoryList[choosed]['id'].toString(),
    ).then((value) {
      data = value;
      setState(() {});
    });
  }

  List dropList = [
    {
      'title': '考题类型', 
      'data': [
        {
          'name': '单选题'
        },
        {
          'name': '多选题'
        },
        {
          'name': '判断题'
        },
        {
          'name': '填空题'
        },
        {
          'name': '问答题'
        },
      ], 
      'value': '', 
      'saveTitle': '考题类型'
    },
  ];

  _getTitle(int questionType){
    // 1单选 2多选 3填空 4判断 5问答
    switch (questionType) {
      case 1:
        return '单选题';
        break;
      case 2:
        return '多选题';
        break;
      case 3:
        return '填空题';
        break;
      case 4:
        return '判断题';
        break;
      case 5:
        return '问答题';
        break;
      default:
        return '';
    }
  }

  Widget _getAnswerWidget(int questionType){
    // 3填空 4判断 5问答
    switch (questionType) {
      case 3:
        return Container();
        break;
      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '正确',
              style: TextStyle(
                color: Color(0Xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '错误',
              style: TextStyle(
                color: Color(0Xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        );
        break;
      case 5:
        return Container();
        break;
      default:
        return Container();
    }
  }

  List test = [];

  _getData({String name}){
    test = [];
    switch (name) {
      case '单选题':
        for (int i = 0; i < data.length; i++) {
          if(data[i]['questionType'] == 1){
            test.add(data[i]);
          }
        }
        break;
      case '多选题':
        for (int i = 0; i < data.length; i++) {
          if(data[i]['questionType'] == 2){
            test.add(data[i]);
          }
        }
        break;
      case '填空题':
        for (int i = 0; i < data.length; i++) {
          if(data[i]['questionType'] == 3){
            test.add(data[i]);
          }
        }
        break;
      case '判断题':
        for (int i = 0; i < data.length; i++) {
          if(data[i]['questionType'] == 4){
            test.add(data[i]);
          }
        }
        break;
      case '问答题':
        for (int i = 0; i < data.length; i++) {
          if(data[i]['questionType'] == 5){
            test.add(data[i]);
          }
        }
        break;
      default:
    }
  }

  List submitData = [];

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text('根据教材选择考题'),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 100),
            height: widghtSize.height,
            color: Color(0xffeef2f5),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: size.width * 50, right: size.width * 50, bottom: size.width * 20),
                  child: MyEduDropDown(
                    dropList,
                    0,
                    callbacks: (val) {
                      _getData(name: val['name']);
                      // _getEducationQuestionLibraryByresourcesId(name: val['name']);
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: test.isNotEmpty 
                  ? ListView.builder(
                    itemCount: test.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: size.width * 10, horizontal: size.width * 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(size.width * 15))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.width * 15),
                              child: Text(
                                (index + 1).toString() + '. ' + _getTitle(test[index]['questionType']),
                              ),
                            ),
                            Container(
                              height: size.width * 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE9E9EF),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    test[index]['questionMain'],
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 25),
                                    child: test[index]['questionType'] == 1 || test[index]['questionType'] == 2 ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'A. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              test[index]['aOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ),
                                        test[index]['bOption'] != null && test[index]['bOption'] != '' ? Row(
                                          children: [
                                            Text(
                                              'B. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              test[index]['bOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ) : Container(),
                                        test[index]['cOption'] != null && test[index]['cOption'] != '' ? Row(
                                          children: [
                                            Text(
                                              'C. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              test[index]['cOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ) : Container(),
                                        test[index]['dOption'] != null && test[index]['dOption'] != '' ? Row(
                                          children: [
                                            Text(
                                              'D. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              test[index]['dOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ) : Container(),
                                      ],
                                    ) : _getAnswerWidget(test[index]['questionType']),
                                  ),
                                ],
                              )
                            ),
                            Container(
                              height: size.width * 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE9E9EF),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 30),
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: size.width * 28),
                                    children: <InlineSpan>[
                                      TextSpan(text: '正确答案：',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff333333))),
                                      TextSpan(text: test[index]['correctAnswer'], style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffA6D65E))),
                                    ]),
                              ),
                            ),
                            Container(
                              height: size.width * 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE9E9EF),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: size.width * 58,
                                    width: size.width * 140,
                                    decoration: BoxDecoration(
                                      color: Color(0xff6493F6),
                                      borderRadius: BorderRadius.all(Radius.circular(size.width * 25))
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '解析',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: size.width * 10),
                                    child: Text(
                                      test[index]['parsing'] * 10,
                                      style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 26
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                if(submitData.contains(test[index])){
                                  submitData.remove(test[index]);
                                }else{
                                  submitData.add(test[index]);
                                }
                                setState(() {});
                              },
                              child: Container(
                                color: Color(0xffF7F7F7),
                                padding: EdgeInsets.all(size.width * 20),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      submitData.contains(test[index]) ? 'assets/images/icon_edu_ques_library_checked.png' : 'assets/images/icon_edu_ques_library_unchecked.png',
                                      width: size.width * 30,
                                      height: size.width * 30,
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Text(
                                      '设为必考题',
                                      style: TextStyle(
                                        color: Color(0xff555555),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  )
                  : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: size.width * 10, horizontal: size.width * 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(size.width * 15))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.width * 15),
                              child: Text(
                                (index + 1).toString() + '. ' + _getTitle(data[index]['questionType']),
                              ),
                            ),
                            Container(
                              height: size.width * 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE9E9EF),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['questionMain'],
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 25),
                                    child: data[index]['questionType'] == 1 || data[index]['questionType'] == 2 ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'A. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              data[index]['aOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ),
                                        data[index]['bOption'] != null && data[index]['bOption'] != '' ? Row(
                                          children: [
                                            Text(
                                              'B. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              data[index]['bOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ) : Container(),
                                        data[index]['cOption'] != null && data[index]['cOption'] != '' ? Row(
                                          children: [
                                            Text(
                                              'C. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              data[index]['cOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ) : Container(),
                                        data[index]['dOption'] != null && data[index]['dOption'] != '' ? Row(
                                          children: [
                                            Text(
                                              'D. ',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Expanded(child: Text(
                                              data[index]['dOption'],
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),)
                                          ],
                                        ) : Container(),
                                      ],
                                    ) : _getAnswerWidget(data[index]['questionType']),
                                  ),
                                ],
                              )
                            ),
                            Container(
                              height: size.width * 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE9E9EF),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 30),
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: size.width * 28),
                                    children: <InlineSpan>[
                                      TextSpan(text: '正确答案：',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff333333))),
                                      TextSpan(text: data[index]['correctAnswer'], style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffA6D65E))),
                                    ]),
                              ),
                            ),
                            Container(
                              height: size.width * 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE9E9EF),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: size.width * 58,
                                    width: size.width * 140,
                                    decoration: BoxDecoration(
                                      color: Color(0xff6493F6),
                                      borderRadius: BorderRadius.all(Radius.circular(size.width * 25))
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '解析',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: size.width * 10),
                                    child: Text(
                                      data[index]['parsing'] * 10,
                                      style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 26
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                if(submitData.contains(data[index])){
                                  submitData.remove(data[index]);
                                }else{
                                  submitData.add(data[index]);
                                }
                                setState(() {});
                              },
                              child: Container(
                                color: Color(0xffF7F7F7),
                                padding: EdgeInsets.all(size.width * 20),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      submitData.contains(data[index]) ? 'assets/images/icon_edu_ques_library_checked.png' : 'assets/images/icon_edu_ques_library_unchecked.png',
                                      width: size.width * 30,
                                      height: size.width * 30,
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Text(
                                      '设为必考题',
                                      style: TextStyle(
                                        color: Color(0xff555555),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  )
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context, submitData);
                  },
                  child: Container(
                    height: size.width * 60,
                    width: size.width * 240,
                    margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    decoration: BoxDecoration(
                      color: Color(0xff0059FF),
                      borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 32
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          EduQuestionLibraryLeftBar(
            leftBar: widget.compulsoryList,
            callback: (int index) {
              choosed = index;
              dropList[0]['title'] = dropList[0]['saveTitle'];
              _getEducationQuestionLibraryByresourcesId();
              _getData();
              if (mounted) {
                setState(() {});
              }
            },
            choosed: choosed),
        ],
      ),
    );
  }
}

typedef LeftBarCallback = void Function(int index);

class EduQuestionLibraryLeftBar extends StatefulWidget {
  EduQuestionLibraryLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  _EduQuestionLibraryLeftBarState createState() => _EduQuestionLibraryLeftBarState();
}

class _EduQuestionLibraryLeftBarState extends State<EduQuestionLibraryLeftBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool isOpen = false;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animation = Tween(begin: size.width * 110, end: size.width * 350)
        .animate(_animation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return GestureDetector(
        onPanEnd: (details) {
          if (_animationController.value.toInt() == 0 ||
              _animationController.value.toInt() == 1) {
            isOpen = !isOpen;
            if (isOpen) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          }
        },
        child: Row(
          children: [
            Container(
              width: _animation.value,
              height: widghtSize.height,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            isOpen = !isOpen;
                            if (isOpen) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          },
                          child: !isOpen
                              ? Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      size.width * 20,
                                      size.width * 40,
                                      size.width * 20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 26,
                                        height: size.width * 22,
                                        margin: EdgeInsets.all(3),
                                        child: Image.asset(
                                            'assets/images/hidden_open.png'),
                                      ),
                                      Text(
                                        '展开',
                                        style: TextStyle(
                                            color: Color(0xff949494),
                                            fontSize: size.width * 16),
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 26,
                                        height: size.width * 22,
                                        margin: EdgeInsets.all(3),
                                        child: Image.asset(
                                            'assets/images/hidden_close.png'),
                                      ),
                                      Text(
                                        '收起',
                                        style: TextStyle(
                                            color: Color(0xff949494),
                                            fontSize: size.width * 16),
                                      )
                                    ],
                                  ),
                                )),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.leftBar.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (isOpen) {
                                isOpen = false;
                                _animationController.reverse();
                              }
                              widget.callback(index);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Container(
                              color: widget.choosed == index ? Color(0xffeef2f5) : Colors.white,
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: !isOpen
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(size.width * 10),
                                      ),
                                      alignment: Alignment.center,
                                      margin: !isOpen
                                          ? EdgeInsets.only(bottom: 0, top: 10)
                                          : EdgeInsets.only(
                                              bottom: 10, top: 10, left: 10),
                                      constraints: BoxConstraints.expand(
                                          height: size.width * 63.0,
                                          width: size.width * 62.0),
                                      child: Image.asset(
                                        'assets/images/jc@2x.png',
                                        width: size.width * 60,
                                        height: size.width * 60,
                                      ),
                                    ),
                                    !isOpen
                                        ? Container()
                                        : Expanded(
                                            child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              widget.leftBar[index]['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xff343434),
                                                  fontSize: size.width * 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                  ],
                                ),
                                !isOpen
                                    ? Text(
                                        widget.leftBar[index]['title']
                                            .toString().length > 2 ? widget.leftBar[index]['title']
                                            .toString().substring(0, 2) : widget.leftBar[index]['title']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: size.width * 26,
                                            color: Color(0xff999999)),
                                      )
                                    : Container(),
                              ],
                            )),
                          );
                        }),
                  )
                ],
              ),
            ),
            isOpen
                ? Expanded(
                    child: Container(
                    color: Color.fromRGBO(0, 0, 0, .3),
                  ))
                : Container()
          ],
        ));
  }
}

class MyEduDropDown extends StatefulWidget {
  const MyEduDropDown(this.list, this.index, {Key key, this.callbacks})
      : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _MyEduDropDownState createState() => _MyEduDropDownState();
}

class _MyEduDropDownState extends State<MyEduDropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (_) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                widget.list[i]['data'].map<Widget>((_ele) {
                              Color _juegeColor() {
                                Color _color = widget.list[i]['value'] == '' &&
                                        _ele['name'] == '查看全部'
                                    ? themeColor
                                    : widget.list[i]['value'] == _ele['name']
                                        ? themeColor
                                        : Colors.white;
                                return _color;
                              }
                              Color _conColors = _juegeColor();
                              return GestureDetector(
                                onTap: () {
                                  widget.list[i]['value'] = _ele['name'];
                                  if (_ele['name'] == '查看全部') {
                                    widget.list[i]['title'] =
                                        widget.list[i]['saveTitle'];
                                  } else {
                                    widget.list[i]['title'] = _ele['name'];
                                  }
                                  widget.callbacks({
                                    'name': _ele['name'],
                                  });
                                  setState(() {});
                                  // widget.getDataList();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 32),
                                  decoration: BoxDecoration(
                                      color: _conColors,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: underColor))),
                                  child: Center(
                                    child: Text(
                                      _ele['name'],
                                      style: TextStyle(
                                          fontSize: size.width * 30,
                                          color: _conColors.toString() ==
                                                  'Color(0xff6ea3f9)'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ))
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: size.width * 220,
          height: size.width * 53,
          margin: EdgeInsets.only(
              top: 10.0, left: size.width * 10.0, right: size.width * 10.0),
          padding: EdgeInsets.only(
              left: size.width * 20.0, right: size.width * 10.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: size.width * 1,
              color: Color(0xffDCDCDC),
            ),
            borderRadius: BorderRadius.circular(size.width * 26.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.list[i]['title'].toString(),
                style: TextStyle(
                    color: Color(0xff898989),
                    fontSize: size.width * 22,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff898989),
                size: size.width * 30,
              ),
            ],
          ),
        ),
      ));
    }).toList());
  }
}

