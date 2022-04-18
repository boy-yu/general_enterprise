import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/bigDanger/_dangerEquiment.dart';
import 'package:enterprise/pages/home/bigDanger/_dangerList.dart';
import 'package:enterprise/pages/home/productList/productList.dart';
import 'package:enterprise/service/context.dart';
// import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';

class DangerSourece extends StatefulWidget {
  DangerSourece({@required this.leftbar, this.id, this.index});
  final List leftbar;
  final int id;
  final int index;
  @override
  _DangerSoureceState createState() => _DangerSoureceState();
}

class _DangerSoureceState extends State<DangerSourece> {
  List leftbar = [];
  int choosed = 0;
  // ThrowFunc _throwFunc = ThrowFunc();
  @override
  void initState() {
    super.initState();
    choosed = widget.index ?? 0;
    leftbar = [
      {
        "name": "危化品清单",
        'title': '涉及危险化学品清单',
        'icon': "assets/images/list@2x.png",
        'unIcon': 'assets/images/unlist@2x.png',
        "widget": DangerList(
          id: widget.id,
        )
      },
      {
        "name": "设施设备",
        'title': '主要设施设备',
        'icon': "assets/images/guanli@2x.png",
        'unIcon': 'assets/images/unguanli@2x.png',
        "widget": DangerEquiment(
          id: widget.id,
          choose: 1,
        )
      },
      {
        "name": "安全附件",
        'title': '安全设备及安全附件',
        'icon': "assets/images/qiye@2x.png",
        'unIcon': 'assets/images/unqiye@2x.png',
        "widget": DangerEquiment(
          id: widget.id,
          choose: 2,
        )
      },
      {
        "name": "监控警报",
        'title': '安全监控报警系统',
        'icon': "assets/images/renyuan@2x.png",
        'unIcon': 'assets/images/unrenyuan@2x.png',
        "widget": DangerEquiment(
          id: widget.id,
          choose: 3,
        )
      },
      {
        "name": "救援器材",
        'title': '应急救援器材',
        'icon': "assets/images/shebei@2x.png",
        'unIcon': 'assets/images/unshebei@2x.png',
        "widget": DangerEquiment(
          id: widget.id,
          choose: 4,
        )
      },
      {
        "name": "大修/保修",
        'title': '大修/拆除保修情况',
        'icon': "assets/images/shengcan@2x.png",
        'unIcon': 'assets/images/unshengcan@2x.png',
        "widget": DangerEquiment(
          id: widget.id,
          choose: 5,
        )
      },
      // {
      //   "name": "操作规程",
      //   'title': '操作规程',
      //   'icon': "assets/images/icon_list_contingency_checked.png",
      //   'unIcon': 'assets/images/icon_list_contingency_unchecked.png',
      //   "widget": DangerEquiment(
      //     id: widget.id,
      //     choose: 5,
      //   )
      // },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 100),
            color: Color(0xffF6F9FF),
            child: widget.leftbar == null
                ? leftbar[choosed]['widget']
                : widget.leftbar[choosed]['widget'],
          ),
          ProductListHomeLeftBar(
              leftBar: widget.leftbar ?? leftbar,
              callback: (int index) {
                choosed = index;
                // _throwFunc.run(argument: {'id': widget.id, 'choose': choosed});
                if (mounted) {
                  setState(() {});
                }
              },
              choosed: choosed)
        ],
      ),
      title: Text('重大危险源文档'),
    );
  }
}
