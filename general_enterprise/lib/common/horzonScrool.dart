import 'package:flutter/material.dart';

class HorizonScroll extends StatefulWidget {
  final List<Widget> data;
  final PageController pageController;
  HorizonScroll(this.data, this.pageController);
  @override
  _HorzionScrollState createState() => _HorzionScrollState();
}

class _HorzionScrollState extends State<HorizonScroll> {
  List<Widget> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => data[index],
      itemCount: data.length,
    );
  }
}
