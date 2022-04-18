import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class SafetyManagement extends StatefulWidget {
  @override
  _SafetyManagement createState() => _SafetyManagement();
}

class _SafetyManagement extends State<SafetyManagement> {
  @override
  void initState() {
    super.initState();
    _handlerRefresh();
  }

  List coMechanismFields = [];

  Future<Null> _handlerRefresh() async {
    myDio.request(type: 'get', url: Interface.safetyManagement).then((value) {
      coMechanismFields = value;
      for (int i = 0; i < coMechanismFields.length; i++) {
        coMechanismFields[i]['unfold'] = false;
        coMechanismFields[i]['isShow'] = true;
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return RefreshIndicator(
      child: coMechanismFields.isNotEmpty
          ? ListView.builder(
              itemCount: coMechanismFields.length,
              itemBuilder: (builder, index) {
                return _items(width, context, index);
              },
              physics: const AlwaysScrollableScrollPhysics(),
            )
          : Container(
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
                  Text('暂无数据'),
                ],
              )),
      // 刷新方法
      onRefresh: () => _handlerRefresh(),
    );
  }

  getListLength(int length, int index) {
    if (coMechanismFields[index]['unfold']) {
      return length;
    } else {
      return 3;
    }
  }

  // item控件
  Widget _items(width, context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(1.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                    blurRadius: 1.0, //阴影模糊程度
                    spreadRadius: 0.0 //阴影扩散程度
                    )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 20),
                    child: Text(
                      coMechanismFields[index]['coMechanism']['name']
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 32,
                      ),
                    ),
                  ),
                  Spacer(),
                  coMechanismFields[index]['isShow']
                      ? GestureDetector(
                          onTap: () {
                            coMechanismFields[index]['unfold'] = true;
                            coMechanismFields[index]['isShow'] = false;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xff4988FD),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: size.width * 20,
                  )
                ],
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE6E6E6),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 20, horizontal: size.width * 30),
                child: ListView.builder(
                    shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                    physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                    itemCount:
                        coMechanismFields[index]['coMechanismFields'].length > 3
                            ? getListLength(
                                coMechanismFields[index]['coMechanismFields']
                                    .length,
                                index)
                            : coMechanismFields[index]['coMechanismFields']
                                .length,
                    itemBuilder: (builder, _index) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              coMechanismFields[index]['coMechanismFields']
                                          [_index]['field']
                                      .toString() +
                                  '：',
                              style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 32,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          Spacer(flex: 1),
                          Expanded(
                            child: Text(
                              coMechanismFields[index]['coMechanismFields']
                                      [_index]['fieldValue']
                                  .toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE6E6E6),
                margin: EdgeInsets.only(left: size.width * 40),
              ),
              !coMechanismFields[index]['isShow']
                  ? GestureDetector(
                      onTap: () {
                        coMechanismFields[index]['unfold'] = false;
                        coMechanismFields[index]['isShow'] = true;
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                            child: Text(
                              '收起',
                              style: TextStyle(
                                color: Color(0xff4988FD),
                                fontSize: size.width * 24,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_up,
                            color: Color(0xff4988FD),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
