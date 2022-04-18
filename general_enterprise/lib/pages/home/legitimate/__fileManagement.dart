import 'package:enterprise/common/CustomTree.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileManagement extends StatefulWidget {
  @override
  _FileManagementState createState() => _FileManagementState();
}

class _FileManagementState extends State<FileManagement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileTitleCard(),
        Expanded(
          child: FileList(),
        )
      ],
    );
  }
}

class FileTitleCard extends StatefulWidget {
  @override
  _FileTitleCardState createState() => _FileTitleCardState();
}

class _FileTitleCardState extends State<FileTitleCard> {
  List menuList = [];
  @override
  void initState() {
    super.initState();
    _getTitleFile();
  }

  _getTitleFile() {
    myDio.request(
        type: 'get',
        url: Interface.getFileListAll,
        queryParameters: {"type": 2}).then((value) {
      if (value != null) {
        if (value is List && value.isNotEmpty) {
          menuList = value;
          for (int i = 0; i < menuList.length; i++) {
            if (menuList[i]['expireDate'] != null &&
                menuList[i]['expireDate'] != '') {
              String expireDate =
                  menuList[i]['expireDate'].toString().substring(0, 10);
              DateTime dateTime = DateTime.now();
              String nowDate = dateTime.toString().substring(0, 10);
              int day = daysBetween(
                  DateTime.parse(expireDate), DateTime.parse(nowDate), false);
              if (0 <= day) {
                if (day <= 29) {
                  menuList[i]['dayState'] = '临期';
                } else {
                  menuList[i]['dayState'] = '正常';
                }
              } else {
                menuList[i]['dayState'] = '已过期';
              }
            } else {
              menuList[i]['dayState'] = '';
            }
          }
          if (menuList.length == 1) {
            menuList.add(
              {
                "id": -1,
                "name": "待添加文件",
                "companyId": -1,
                "type": -1,
                "needUpdated": -1,
                "fileValue": null,
                "expireDate": null,
                "createDate": "",
                "modifyDate": ""
              },
            );
            menuList.add(
              {
                "id": -1,
                "name": "待添加文件",
                "companyId": -1,
                "type": -1,
                "needUpdated": -1,
                "fileValue": null,
                "expireDate": null,
                "createDate": "",
                "modifyDate": ""
              },
            );
          } else if (menuList.length == 2) {
            menuList.add(
              {
                "id": -1,
                "name": "待添加文件",
                "companyId": -1,
                "type": -1,
                "needUpdated": -1,
                "fileValue": null,
                "expireDate": null,
                "createDate": "",
                "modifyDate": ""
              },
            );
          }
          if (mounted) {
            setState(() {});
          }
        } else {
          menuList.add(
            {
              "id": -1,
              "name": "待添加文件",
              "companyId": -1,
              "type": -1,
              "needUpdated": -1,
              "fileValue": null,
              "expireDate": null,
              "createDate": "",
              "modifyDate": ""
            },
          );
          menuList.add(
            {
              "id": -1,
              "name": "待添加文件",
              "companyId": -1,
              "type": -1,
              "needUpdated": -1,
              "fileValue": null,
              "expireDate": null,
              "createDate": "",
              "modifyDate": ""
            },
          );
          menuList.add(
            {
              "id": -1,
              "name": "待添加文件",
              "companyId": -1,
              "type": -1,
              "needUpdated": -1,
              "fileValue": null,
              "expireDate": null,
              "createDate": "",
              "modifyDate": ""
            },
          );
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ 86400000 -
          b.millisecondsSinceEpoch ~/ 86400000;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      // if (v < 0) v = -v;
      return v ~/ 86400000;
    }
  }

  _getDayStateImage(String dayState) {
    switch (dayState) {
      case '临期':
        return Image.asset(
          'assets/images/icon_legitimate_advent.png',
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      case '正常':
        return Container(
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      case '已过期':
        return Image.asset(
          'assets/images/icon_legitimate_stale.png',
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      case '':
        return Container(
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      default:
    }
  }

  _getUrl(String attachment) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': '查看文件'});
  }

  //构建数据
  List<Widget> _buildChildren() {
    List<Widget> list = [];
    for (int i = 0; i < menuList.length; i++) {
      list.add(
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (menuList[i]['fileValue'] != null &&
                    menuList[i]['fileValue'] != '') {
                  _getUrl(menuList[i]['fileValue']);
                } else {
                  Fluttertoast.showToast(msg: '暂无文件');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xff9EE9FF),
                        Color(0xff80C1FF),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 20))),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 5),
                      child: Text(
                        menuList[i]['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Image.asset(
                      'assets/images/bg_file_title_card_ikon.png',
                      height: size.width * 143,
                      width: size.width * 140,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: menuList[i]['dayState'] != null
                  ? _getDayStateImage(menuList[i]['dayState'])
                  : Container(),
            ),
          ],
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: menuList.isNotEmpty
            ? FileTitleCardGridPage(
                children: _buildChildren(),
                column: 3,
                row: 1,
                columnSpacing: size.width * 20, //列间隔
                rowSpacing: 0, //行间隔
                itemRatio: 0.75, //每个item的宽高比，默认正方形
              )
            : Container(
                width: double.infinity,
                height: size.width * 324,
              ));
  }
}

class FileList extends StatefulWidget {
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  @override
  void didUpdateWidget(FileList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getDate();
  }

  _getDate() {
    myDio.request(
        type: 'get',
        url: Interface.getFileTypeTree,
        queryParameters: {"type": 1}).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  _lookLicense(int id) {
    Navigator.pushNamed(context, '/legitimate/___fileList',
        arguments: {"id": id});
  }

  @override
  Widget build(BuildContext context) {
    return CoutomTree(
        treeData: data.isNotEmpty ? data : [], fuc: _lookLicense, file: 'file');
  }
}

/*
 *  girdview套pageview
 */
class FileTitleCardGridPage extends StatefulWidget {
  final List<Widget> children;
  final int column; //列数
  final int row; //行数
  final double columnSpacing; //列间隔
  final double rowSpacing; //行间隔
  final double itemRatio; //每个item的宽高比，默认正方形

  FileTitleCardGridPage({
    @required this.children,
    this.column = 4,
    this.row = 2,
    this.columnSpacing = 0.0,
    this.rowSpacing = 0.0,
    this.itemRatio = 1.0,
  });

  @override
  State<StatefulWidget> createState() {
    return _FileTitleCardGridPageState();
  }
}

class _FileTitleCardGridPageState extends State<FileTitleCardGridPage> {
  ///每页的个数
  int _countPerPage;

  ///总页数
  int _pageCount;

  ///当前页
  int _currentPage;

  ///控制器
  PageController _controller;

  @override
  void initState() {
    _calculatePage();
    _controller = PageController();
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: size.width * 300,
              padding: EdgeInsets.fromLTRB(size.width * 20, size.width * 20,
                  size.width * 20, size.width * 0),
              child: _buildPageView()),
          _buildCursor(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //释放资源
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  ///计算总页数及单页的item数目
  void _calculatePage() {
    assert(widget.children != null);
    _countPerPage = widget.row * widget.column;
    _pageCount = (widget.children.length / _countPerPage).ceil();
  }

  ///多个Item构建单页的GridView
  Widget _buildGrid(List<Widget> list) {
    return GridView.count(
      crossAxisCount: widget.column,
      children: list,
      mainAxisSpacing: widget.rowSpacing,
      crossAxisSpacing: widget.columnSpacing,
      childAspectRatio: widget.itemRatio,
    );
  }

  ///构建多个GridView
  List<Widget> _buildPages() {
    List<Widget> list = [];
    int index = 0;
    int realIndex;
    for (int i = 0; i < _pageCount; i++) {
      realIndex = index + _countPerPage > widget.children.length
          ? widget.children.length
          : index + _countPerPage;
      List l = widget.children.sublist(index, realIndex);
      index = realIndex;
      list.add(_buildGrid(l));
    }
    return list;
  }

  ///多个GridView构建PageView
  Widget _buildPageView() {
    return PageView(
      controller: _controller,
      children: _buildPages(),
      onPageChanged: (page) {
        setState(() {
          _currentPage = page;
        });
      },
    );
  }

  ///页标
  Widget _buildCursor() {
    List<Widget> list = [];
    for (int i = 0; i < _pageCount; i++) {
      list.add(_buildPoint(_currentPage == i));
    }
    return Container(
      child: Row(
        children: list,
        mainAxisSize: MainAxisSize.min,
      ),
      alignment: AlignmentDirectional.center,
    );
  }

  //单个点
  Widget _buildPoint(bool focus) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: size.width * 10.0,
          left: size.width * 10,
          right: size.width * 10),
      child: Container(
        width: size.width * 50,
        height: size.width * 8,
        decoration: BoxDecoration(
            color: focus ? Colors.white : Color(0xffF0F0F0).withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
      ),
    );
  }
}
