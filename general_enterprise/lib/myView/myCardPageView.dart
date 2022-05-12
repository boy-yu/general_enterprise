import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class MyCardPageView extends StatefulWidget {
  MyCardPageView({this.children, this.height});
  final List<Widget> children;
  final double height;
  @override
  State<MyCardPageView> createState() => _MyCardPageViewState();
}

class _MyCardPageViewState extends State<MyCardPageView> {
  //总页数
  int _pageCount;
  ///当前页
  int _currentPage;
  //控制器
  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    _pageCount = widget.children.length;
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
              height: widget.height == null ? size.width * 430 : widget.height,
              child: _buildPageView()),
          SizedBox(
            height: size.width * 32,
          ),
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

  Widget _buildPageView() {
    return PageView(
      controller: _controller,
      children: widget.children,
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
          bottom: size.width * 40.0,
          left: size.width * 8),
      child: focus ? Container(
        width: size.width * 40,
        height: size.width * 12,
        decoration: BoxDecoration(
            color: Color(0xff3074FF),
            borderRadius: BorderRadius.all(Radius.circular(size.width * 12))),
      ) : Container(
        width: size.width * 12,
        height: size.width * 12,
        decoration: BoxDecoration(
            color: Color(0xffE0E0E0),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
    );
  }
}