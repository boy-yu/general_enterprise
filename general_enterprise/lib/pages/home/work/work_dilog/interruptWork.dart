import 'package:animations/animations.dart';
import 'package:enterprise/common/loding.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/newMyInput.dart';
import 'package:enterprise/common/newMySearchPeople.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
enum InterruptWorkType { termination, terminationBig, onlyChange, all, add }

class InterruptWork {
  static InterruptWork ts = InterruptWork();
  static detailInterrup(
    LongPressStartDetails details,
    BuildContext context,
    int bookId,
    Function callback, {
    Widget replace,
    Widget addtion,
    InterruptWorkType type = InterruptWorkType.all,
  }) {
    showModal(
        context: context,
        builder: (_) => Stack(
              children: [
                Positioned(
                    left: 100,
                    top: details.globalPosition.dy + 100 >
                            MediaQuery.of(context).size.height
                        ? details.globalPosition.dy - 200
                        : details.globalPosition.dy - 50,
                    child: Container(
                        constraints: BoxConstraints(
                          minWidth: 200,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                type == InterruptWorkType.termination ||
                                        type == InterruptWorkType.terminationBig
                                    ? ts.termination(context, bookId, callback,
                                        type: type)
                                    : Container(),
                                type == InterruptWorkType.onlyChange
                                    ? ts.onlyChange(context, bookId, callback)
                                    : Container(),
                                type == InterruptWorkType.all
                                    ? Column(
                                        children: [
                                          ts.termination(
                                              context, bookId, callback,
                                              type: type),
                                          Container(
                                              height: 1,
                                              constraints:
                                                  BoxConstraints(minWidth: 240),
                                              color: placeHolder),
                                          ts.onlyChange(
                                              context, bookId, callback)
                                        ],
                                      )
                                    : Container(),
                                type == InterruptWorkType.add
                                    ? Column(
                                        children: [
                                          ts.addNewWork(
                                              context, bookId, callback),
                                          Container(
                                              height: 1,
                                              constraints:
                                                  BoxConstraints(minWidth: 240),
                                              color: placeHolder),
                                          ts.reNewWork(
                                              context, bookId, callback),
                                          Container(
                                              height: 1,
                                              constraints:
                                                  BoxConstraints(minWidth: 240),
                                              color: placeHolder),
                                          ts.termination(
                                              context, bookId, callback)
                                        ],
                                      )
                                    : Container(),
                                Container(
                                    height: 1,
                                    constraints: BoxConstraints(minWidth: 240),
                                    color: placeHolder),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            themeColor),
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      constraints:
                                          BoxConstraints(minWidth: 200),
                                      child: Text('取消',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    )),
                                Container(
                                    height: 1,
                                    constraints: BoxConstraints(minWidth: 240),
                                    color: placeHolder),
                              ],
                            )
                          ],
                        )))
              ],
            ));
  }

  Widget termination(BuildContext context, int bookId, Function callback,
      {InterruptWorkType type = InterruptWorkType.termination}) {
    return ElevatedButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.red.shade300),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          List<String> _list = [];
          String sumbit = '';
          Navigator.pop(context);
          List<String> result = [
            '恶劣天气（5级风及以上禁止室外动火、6级风以上禁止露天吊装',
            '作业相关生产装置存在异常',
            '作业安全措施未落实',
            '作业环境不满足作业要求',
            '未进行气体检测分析或检测分析不合格',
            '风险辨识不到位',
            '实际作业内容和作业许可证不符',
            '作业监护人员不在作业现场',
            '作业人员无安全防护措施或防护不足、不到位',
            '作业人员身体条件不允许进行作业',
          ];
          WorkDialog.myDialog(
            context,
            () {},
            2,
            widget: StatefulBuilder(
                builder: (context, state) => Column(
                      children: [
                        Text('终断原因'),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: size.width * 300,
                            child: SingleChildScrollView(
                              child: Wrap(
                                children: result
                                    .map((e) => Container(
                                          margin: EdgeInsets.only(
                                              right: size.width * 10,
                                              bottom: size.width * 10),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        _list.indexOf(e) > -1
                                                            ? Color(0xff3174FF)
                                                            : Colors.white),
                                                shape: MaterialStateProperty
                                                    .all(RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))))),
                                            onPressed: () {
                                              if (_list.indexOf(e) == -1) {
                                                _list.add(e);
                                              } else {
                                                _list.remove(e);
                                              }

                                              state(() {});
                                            },
                                            child: Text(e,
                                                style: TextStyle(
                                                    color: _list.indexOf(e) > -1
                                                        ? Colors.white
                                                        : Color(0xff1A1A1A),
                                                    fontSize: size.width * 26)),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: NewMyInput(
                            title: '',
                            line: 4,
                            placeHolder: '请输入原因',
                            onChange: (String value) {
                              sumbit = value;
                            },
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff3174FF)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))))),
                            onPressed: () {
                              _list.forEach((element) {
                                sumbit += '\n $element';
                              });
                              myDio.request(
                                  type: 'put',
                                  url: type == InterruptWorkType.all
                                      ? Interface.putInterrupReceipt
                                      : Interface.putInterrupWork,
                                  data: {
                                    "bookId": bookId,
                                    "interruptReason": sumbit
                                  }).then((value) {
                                Navigator.pop(context);
                                callback();
                              });
                            },
                            child: Container(
                              width: size.width * 500,
                              child: Center(
                                child: Text('确定'),
                              ),
                            ))
                      ],
                    )),
          );
        },
        child: Container(
          constraints: BoxConstraints(minWidth: 200),
          child: Text('终止', style: Theme.of(context).textTheme.subtitle1),
        ));
  }

  Widget onlyChange(BuildContext context, int bookId, Function callback) {
    return ElevatedButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.red.shade300),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () async {
          Navigator.pop(context);
          showDialog(
              context: context, builder: (contexts) => PopOnlyChange(bookId));
        },
        child: Container(
          constraints: BoxConstraints(minWidth: 200),
          child: Text('变更监护人', style: Theme.of(context).textTheme.subtitle1),
        ));
  }

  Widget commonButton(Widget child, {Function callback}) {
    return ElevatedButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.red.shade300),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: callback,
        child: child);
  }

  Widget addNewWork(BuildContext context, int bookId, Function callback) {
    return commonButton(
        Container(
          constraints: BoxConstraints(minWidth: 200),
          child: Text('新增作业', style: Theme.of(context).textTheme.subtitle1),
        ), callback: () {
      Navigator.pop(context);
      context.read<Counter>().emptySubmitDates();
      Navigator.pushNamed(context, '/home/work/WorkTicker', arguments: {
        'circuit': 1,
        "operable": true,
        "executionMemo": '',
        "outSide": true,
        "parentId": bookId,
        "bookId": bookId
      }).then((value) {});
    });
  }

  Widget reNewWork(BuildContext context, int bookId, Function callback) {
    return commonButton(
        Container(
          constraints: BoxConstraints(minWidth: 200),
          child: Text('续票', style: Theme.of(context).textTheme.subtitle1),
        ), callback: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home/work/reNewWork',
          arguments: {"bookId": bookId});
    });
  }
}

class PopOnlyChange extends StatefulWidget {
  final int bookId;

  const PopOnlyChange(this.bookId, {Key key}) : super(key: key);

  @override
  _PopOnlyChangeState createState() => _PopOnlyChangeState();
}

class _PopOnlyChangeState extends State<PopOnlyChange> {
  bool showChange = false;
  List filiterId = [1];

  @override
  void initState() {
    super.initState();
    _getChangeFilter();
  }

  _getChangeFilter() {
    showChange = false;
    myDio.request(
        type: "get",
        url: Interface.getWorkCrowdReceipyid,
        queryParameters: {"receiptId": widget.bookId}).then((value) {
      if (value is Map) {
        showChange = true;
        filiterId = value['userIds'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return showChange
        ? ChoosePeople(
            filterId: filiterId,
            changeMsg: (value) {
              if (value.isNotEmpty) {
                String memo = '';
                WorkDialog.myDialog(context, () {}, 2,
                    widget: Column(
                      children: [
                        Text('更改原因',
                            style: TextStyle(
                                color: Color(0xff0059FF),
                                fontSize: size.width * 36)),
                        Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 20,
                                vertical: size.width * 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffF1F5FD)),
                            child: Stack(
                              children: [
                                TextField(
                                  minLines: 3,
                                  maxLines: 5,
                                  autofocus: true,
                                  style: TextStyle(fontSize: size.width * 30),
                                  onChanged: (value) => memo = value,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "请填写更改监护人原因"),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Image.asset(
                                      'assets/images/changeGrantionbj@2x.png',
                                      width: size.width * 36,
                                      height: size.width * 36,
                                    ))
                              ],
                            )),
                        ElevatedButton(
                            onPressed: () {
                              myDio.request(
                                  type: 'post',
                                  url: Interface.postChangeGuardian,
                                  data: {
                                    "receiptId": widget.bookId,
                                    "userId": value[0].id,
                                    "changeMemo": memo
                                  }).then((value) {
                                successToast('监护变更待确认');
                                Navigator.pop(myContext);
                              });
                            },
                            child: Text(
                              '确定',
                              style: TextStyle(fontSize: size.width * 30),
                            )),
                        SizedBox(height: 30)
                      ],
                    ));
              }
            },
            way: true,
          )
        : StaticLoding();
  }
}
