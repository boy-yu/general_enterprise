import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class CoutomTree extends StatefulWidget {
  CoutomTree({@required this.treeData, this.fuc, this.file});
  final List treeData;
  final Function fuc;
  final String file;
  @override
  _CoutomTreeState createState() => _CoutomTreeState();
}

class _CoutomTreeState extends State<CoutomTree> {
  List tempTree = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initData();
  }

  _initData() {
    tempTree = [];
    widget.treeData.forEach((element) {
      Map maps = element;
      Map tempCopy = new Map();
      maps.forEach((key, value) {
        tempCopy.addAll({key: value});
      });
      tempTree.add(tempCopy);
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTree(
        data: tempTree,
        fuc: widget.fuc,
        file: widget.file
      ),
    );
  }
}

class DataTree extends StatefulWidget {
  DataTree({@required this.data, this.fuc, this.file});
  final Function fuc;
  final List data;
  final String file;
  @override
  _DataTreeState createState() => _DataTreeState();
}

class _DataTreeState extends State<DataTree> {
  List tempData = [];
  @override
  void initState() {
    super.initState();
    tempData = widget.data;
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    tempData = widget.data;
  }

  _changeState(int index) {
    if (tempData[index]['isclick'] == true) {
      tempData = widget.data;
    } else {
      List deepData = [];
      tempData = [];
      widget.data.forEach((element) {
        Map maps = element;
        Map tempCopy = new Map();
        maps.forEach((key, value) {
          tempCopy.addAll({key: value});
        });
        deepData.add(tempCopy);
      });
      tempData.add(deepData[index]);
      tempData[0]['isclick'] = true;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),//禁用滑动事件
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width * 10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影模糊程度
                    spreadRadius: 3.0 //阴影扩散程度
                  )
                ]
              ),
              padding: EdgeInsets.symmetric(vertical: size.width * 30, horizontal: size.width * 20),
              margin: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: size.width * 330,
                    child: Text(
                    tempData[index]['name'].toString(),
                      style: TextStyle(
                        fontSize: size.width * 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7487A4)
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _changeState(index);
                    },
                    child: tempData[index]['children'] != null ? Image.asset(
                      'assets/images/icon_file_list.png',
                      height: size.width * 30,
                      width: size.width * 30,
                    ) : Container(),
                  ),
                  Container(
                    color: Color(0xff9CB4D9),
                    height: size.width * 60,
                    width: size.width * 1.2,
                    margin: EdgeInsets.only(left: size.width * 20, right: size.width * 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.file == '' || widget.file == null ?
                      widget.fuc(
                        tempData[index]['id'],
                        tempData[index]['fixedType'],
                      ) : widget.fuc(
                        tempData[index]['id'],
                      ) ;
                      // Fluttertoast.showToast(msg: '敬请期待');
                    },
                    child: Container(
                      height: size.width * 40,
                      width: size.width * 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff2D6DFF),
                            Color(0xff7A73FF),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 20))
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '查看',
                        style: TextStyle(
                          fontSize: size.width * 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            tempData[index]['children'] != null &&
                    tempData[index]['isclick'] == true
                ? DataTree(
                    data: tempData[index]['children'],
                    fuc: widget.fuc,
                  )
                : Container()
          ],
        );
      },
      itemCount: tempData.length,
    );
  }
}
