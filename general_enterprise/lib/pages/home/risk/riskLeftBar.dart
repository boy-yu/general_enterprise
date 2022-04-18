import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class RiskLeftBar extends StatefulWidget {
  RiskLeftBar({@required this.riskLeftList, this.callback});
  final List riskLeftList;
  final Function callback;
  @override
  _RiskLeftBarState createState() => _RiskLeftBarState();
}

class _RiskLeftBarState extends State<RiskLeftBar>
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
    _animation = Tween(begin: size.width * 90, end: size.width * 270)
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
              color: Color(0xffEAEDF2),
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
                                  padding: EdgeInsets.all(size.width * 20),
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
                        itemCount: widget.riskLeftList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (isOpen) {
                                isOpen = false;
                                _animationController.reverse();
                              }
                              widget.callback(index);
                            },
                            child: Container(
                              color: widget.riskLeftList[index].color,
                              child: Row(
                                mainAxisAlignment: !isOpen
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    margin: !isOpen
                                        ? EdgeInsets.only(bottom: 10, top: 10)
                                        : EdgeInsets.only(
                                            bottom: 10, top: 10, left: 10),
                                    constraints: BoxConstraints.expand(
                                        height: size.width * 63.0,
                                        width: size.width * 62.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            widget.riskLeftList[index].bgicon),
                                        centerSlice: Rect.fromLTRB(
                                          270.0,
                                          180.0,
                                          1360.0,
                                          730.0,
                                        ),
                                      ),
                                    ),
                                    child: Image.asset(
                                      widget.riskLeftList[index].icon,
                                      width: size.width * 25,
                                      height: size.width * 25,
                                    ),
                                  ),
                                  !isOpen
                                      ? Container()
                                      : Expanded(
                                          child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            widget.riskLeftList[index].title,
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
                            ),
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
