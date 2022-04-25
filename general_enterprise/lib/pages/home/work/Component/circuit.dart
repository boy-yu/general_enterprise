import 'package:drag_container/drag_container.dart';
import 'package:enterprise/common/MyWebView.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/myView/myDragContainer.dart';
import 'package:enterprise/pages/home/work/Component/gasDetectList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkCircuit extends StatefulWidget {
  WorkCircuit(
      {this.child,
      @required this.circuit,
      this.changeState,
      this.circuitInt,
      this.bookId,
      this.id,
      this.outSide,
      this.type});
  final Widget child;
  final List circuit;
  final Function changeState;
  final int circuitInt, id, bookId;
  final bool outSide;
  final String type;
  @override
  _WorkCircuitState createState() => _WorkCircuitState();
}

class _WorkCircuitState extends State<WorkCircuit> {
  SharedPreferences _preferences;
  String url = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  GlobalKey<_TopStackState> _globalKey = GlobalKey();
  List data = [];
  _getData() async {
    _preferences = await SharedPreferences.getInstance();
    url = webUrl +
        '/work-plan-flow?workId=${widget.bookId}&bigFlow=true&token=${_preferences.getString('token')}';
    setState(() {});
    if (widget.circuitInt > 1) {
      // myDio
      //     .request(
      //         type: 'get', url: Interface.getWorkDetail + widget.id.toString())
      //     .then((value) async {
      //   if (value is Map) {
      //     value.remove('planApprovalUserIds');
      //     value.remove('riskIdentifierUserIds');
      //     value.remove('bookId');
      //     data = await mytranslate.generateList(value);
      //     setState(() {});
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        widget.circuitInt != 1 && url != ''
            ? Container(
                width: windowSize.width,
                height: windowSize.height * 0.1 + 20,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: lineGradBlue)),
                child: Center(
                  child: Text(
                    '台账',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Container(),
        TopStack(
            key: _globalKey,
            circuitInt: widget.circuitInt,
            url: url,
            outSide: widget.outSide,
            windowSize: windowSize),
        widget.outSide == true
            ? BuildDragWidget(
                scollCall: (bool isOpen) {
                  // _globalKey.currentState.show = !isOpen;
                  _globalKey.currentState.setState(() {});
                },
                type: widget.type,
                windowSize: windowSize,
                bookId: widget.bookId,
                circuitInt: widget.circuitInt,
                circuit: widget.circuit,
                child: widget.child,
                changeState: widget.changeState)
            : Container(),
      ],
    );
  }
}

class TopStack extends StatefulWidget {
  TopStack({Key key, this.circuitInt, this.url, this.windowSize, this.outSide})
      : super(key: key);
  final int circuitInt;
  final String url;
  final Size windowSize;
  final bool outSide;
  @override
  _TopStackState createState() => _TopStackState();
}

class _TopStackState extends State<TopStack> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.circuitInt != 1 && widget.url != '' && Contexts.mobile
        ? Container(
            width: widget.windowSize.width,
            height: widget.windowSize.height - size.width * 100,
            margin: EdgeInsets.only(
                bottom: size.width * 140,
                top: widget.windowSize.height * .1 + 20),
            child: WebViewExample(
              url: widget.url,
            ),
          )
        : Container();
  }
}

class BuildDragWidget extends StatefulWidget {
  BuildDragWidget(
      {this.windowSize,
      this.circuitInt,
      this.circuit,
      this.child,
      this.scollCall,
      this.changeState,
      this.type,
      this.bookId});
  final Size windowSize;
  final int circuitInt, bookId;
  final List circuit;
  final Widget child;
  final String type;
  final Function changeState, scollCall;
  @override
  _BuildDragWidgetState createState() => _BuildDragWidgetState();
}

class _BuildDragWidgetState extends State<BuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return widget.circuitInt != 1
        ? Align(
            alignment: Alignment.bottomCenter,
            child: DragContainer(
              //抽屉关闭时的高度 默认0.4
              initChildRate: 0.1,
              //抽屉打开时的高度 默认0.4
              maxChildRate: 0.8,
              //是否显示默认的标题
              isShowHeader: true,
              //背景颜色
              backGroundColor: Colors.white,
              //背景圆角大小
              cornerRadius: 0,
              //自动上滑动或者是下滑的分界值
              maxOffsetDistance: 0,
              //抽屉控制器
              controller: dragController,
              //滑动控制器
              scrollController: scrollController,
              //自动滑动的时间
              duration: Duration(milliseconds: 800),
              //抽屉的子Widget
              dragWidget: widget.type != '3'
                  ? Row(
                      children: [
                        CircuitList(
                          circuit: widget.circuit,
                          changeState: widget.changeState,
                        ),
                        Expanded(child: widget.child)
                      ],
                    )
                  : GasDectList(bookId: widget.bookId),

              //抽屉标题点击事件回调
              dragCallBack: (isOpen) {
                widget.scollCall(isOpen);
              },
            ),
          )
        : Row(
            children: [
              CircuitList(
                circuit: widget.circuit,
                changeState: widget.changeState,
              ),
              Expanded(child: widget.child)
            ],
          );
  }
}

class CircuitList extends StatefulWidget {
  CircuitList({@required this.circuit, this.changeState});
  final List circuit;
  final Function changeState;
  @override
  _CircuitListState createState() => _CircuitListState();
}

class _CircuitListState extends State<CircuitList> {
  int choose = 0;

  @override
  void didUpdateWidget(covariant CircuitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (var i = 0; i < widget.circuit.length; i++) {
      if (widget.circuit[i]['choosed'] == true) {
        choose = i;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 140,
      height: double.infinity,
      padding: EdgeInsets.only(bottom: size.width * 30),
      decoration: BoxDecoration(color: Color(0xffEAEDF2)),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                choose = index;
                if (widget.circuit[index]['allowClick'] == true) {
                  if (widget.changeState != null) {
                    widget.changeState(index);
                  }
                }
              },
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 35, vertical: size.width * 20),
                  child: Column(children: [
                    Container(
                        child: Image.asset(
                            widget.circuit[index]['allowClick'] == true
                                ? widget.circuit[index]['isClick']
                                : widget.circuit[index]['notClick'],
                            width: size.width * 62,
                            height: size.width * 60),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: widget.circuit[index]['allowClick'] ==
                                        true
                                    ? choose == index
                                        ? [Color(0xff56E0FF), Color(0xff2182FF)]
                                        : [
                                            Color(0xff56E0FF).withOpacity(.6),
                                            Color(0xff2182FF).withOpacity(.6)
                                          ]
                                    : [
                                        Color(0xffF7F7F7),
                                        Color(0xffF7F7F7),
                                      ])),
                        padding: EdgeInsets.all(size.width * 10)),
                    Text(widget.circuit[index]['name'].toString(),
                        style: TextStyle(
                            color: placeHolder, fontSize: size.width * 22))
                  ]))
              // Positioned(
              //     right: size.width * 28,
              //     top: size.width * 32,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: widget.circuit[index]['type'] == 1
              //             ? Color(0xff09B907)
              //             : Colors.white,
              //       ),
              //       width: size.width * 25,
              //       height: size.width * 25,
              //       margin: EdgeInsets.all(2),
              //       child: Center(
              //         child: Text(
              //           '审',
              //           style: TextStyle(
              //               fontSize: size.width * 15,
              //               color: widget.circuit[index]['type'] == 1
              //                   ? Colors.white
              //                   : placeHolder),
              //         ),
              //       ),
              //     ))

              );
        },
        itemCount: widget.circuit.length,
      ),
    );
  }
}
