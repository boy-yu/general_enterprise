import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

enum CustomChooseType { drop, mutipleDrop }

class CustomChoose extends StatefulWidget {
  CustomChoose(
      {this.sort, // sort list  [[{'name':'测试'}]]
      this.msg, //choose msg
      this.type = CustomChooseType.drop, // drop or mutipleDrop
      this.ownData, // allData   [{'name':'测试'}]
      this.seleted, // choose index   drop == int  mutiple list<int>
      this.chooseColor = textChooseBgColor, // custom style
      this.borderRadius,
      this.chooseUI = false, //other choose
      this.chooseUIBack, //other callback
      this.physic = false,
      @required this.callback // callback
      });
  final List sort, ownData;
  final seleted;
  final String msg;
  final CustomChooseType type;
  final Function callback, chooseUIBack;
  final Color chooseColor;
  final double borderRadius;
  final bool physic, chooseUI;
  @override
  _CustomChooseState createState() => _CustomChooseState();
}

class _CustomChooseState extends State<CustomChoose> {
  String msg = '';
  List sort = [];
  var seleted;
  List<bool> chooseState = [];

  @override
  void initState() {
    super.initState();
    msg = widget.msg;
    seleted = widget.seleted;
    _initSort();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    msg = widget.msg;
    seleted = widget.seleted;
    sort = [];
    _initSort();
  }

  _initSort() {
    List temp = [];
    for (int x = 0; x < widget.ownData.length; x++) {
      chooseState.add(false);
      temp.add(widget.ownData[x]);
      if (x % 3 == 2) {
        sort.add(temp);
        temp = [];
      }
      if (widget.ownData.length / 3 - sort.length < 1 &&
          widget.ownData.length / 3 - sort.length > 0) {
        sort.add(temp);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size currenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Wrap(
        children: widget.ownData
            .asMap()
            .keys
            .map((index) => InkWell(
                  child: Container(
                    margin: EdgeInsets.all(size.width * 10),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 5, horizontal: size.width * 10),
                    decoration: BoxDecoration(
                        color: widget.type != CustomChooseType.drop
                            ? seleted.indexOf(index) > -1
                                ? widget.chooseColor
                                : textBgColor
                            : seleted == index
                                ? widget.chooseColor
                                : textBgColor,
                        borderRadius: BorderRadius.circular(5)),
                    constraints: BoxConstraints(minWidth: currenSize.width / 4),
                    child: widget.ownData[index] != null
                        ? Text(widget.ownData[index]['name'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.type != CustomChooseType.drop
                                  ? seleted.indexOf(index) > -1
                                      ? Colors.white
                                      : Colors.black
                                  : seleted == index
                                      ? Colors.white
                                      : Colors.black,
                            ))
                        : Container(),
                  ),
                  onTap: () {
                    msg = '';
                    if (widget.type != CustomChooseType.drop) {
                      if (seleted.indexOf(index) == -1) {
                        setState(() {
                          seleted.add(index);
                          seleted.forEach((element) {
                            msg += widget.ownData[element]['name'] + '|';
                          });
                        });
                      } else {
                        setState(() {
                          seleted.remove(index);
                          seleted.forEach((element) {
                            msg += widget.ownData[element]['name'] + '|';
                          });
                          if (seleted.length == 0) {
                            msg = '';
                          }
                          if (seleted.indexOf(index) == -1) {
                            chooseState[index] = false;
                            widget.chooseUIBack(widget.ownData[index]['id'],
                                widget.ownData[index]['name'], false);
                          }
                        });
                      }
                    } else {
                      setState(() {
                        seleted = index;
                        msg = widget.ownData[seleted]['name'];
                      });
                    }
                    if (widget.callback != null) {
                      widget.callback(index, msg);
                    }
                  },
                ))
            .toList(),
      ),
    );

    //  Row(
    //                     mainAxisAlignment: widget.chooseUI != null
    //                         ? MainAxisAlignment.spaceAround
    //                         : MainAxisAlignment.center,
    //                     children: [
    //                       widget.chooseUI
    //                           ? GestureDetector(
    //                               onTap: () {
    //                                 _operChooseUi(index,);
    //                               },
    //                               child: Container(
    //                                   margin: EdgeInsets.symmetric(
    //                                       horizontal: size.width * 10),
    //                                   decoration: BoxDecoration(
    //                                       border: Border.all(
    //                                           width: 1,
    //                                           color:
    //                                               underColor.withOpacity(0.6))),
    //                                   child: chooseState[index * 3]
    //                                       ? Padding(
    //                                           padding: EdgeInsets.all(0),
    //                                           child: Icon(
    //                                             Icons.check,
    //                                             size: size.width * 40,
    //                                             color: Colors.white,
    //                                           ))
    //                                       : Padding(
    //                                           padding: EdgeInsets.all(
    //                                               size.width * 20))),
    //                             )
    //                           : Container(),
    //                     ],
  }
}
