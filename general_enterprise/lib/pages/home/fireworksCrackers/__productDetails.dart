import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:enterprise/common/myDragContainer.dart';
import 'package:drag_container/drag/drag_controller.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({this.id});
  final int id;
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Text('产品详情'),
      child: Stack(
        children: [
          ProductScrollTop(id: widget.id),
          ProductBuildDragWidget(id: widget.id),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 
              "/fireworksCrackers/productDeliveryRecord",
              arguments: {
                'id': widget.id,
              }
            );
          },
          child: Container(
              padding: EdgeInsets.all(size.width * 30),
              child: Image.asset(
                "assets/images/icon_chuku_jilu.png",
                height: size.width * 40,
                width: size.width * 40,
              )),
        ),
      ],
    );
  }
}

extension JudgeHasCharacter on String {
  bool judgeHasCharacter() {
    if (this == '') return false;
    bool _bool = false;
    for (var i = 0; i < this.codeUnits.length; i++) {
      if (this.codeUnits[i] > 200) {
        _bool = true;
      }
    }
    return _bool;
    // return this.codeUnits[0] > 200 ? true : false;
  }
}

class ProductScrollTop extends StatefulWidget {
  ProductScrollTop({this.id});
  final int id;
  @override
  _ProductScrollTopState createState() => _ProductScrollTopState();
}

class _ProductScrollTopState extends State<ProductScrollTop> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Map data;

  _init() {
    myDio.request(
      type: 'get',
      url: Interface.getWarehousingProductById,
      queryParameters: {
        "id": widget.id
      }
    ).then((value) {
      if (value is Map) {
        data = value;
        data.forEach((key, value) {
          dropData.forEach((element) {
            if (element['bindKey'] == key) {
              element['value'] = value ?? '';
            }
          });
        });
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  List<Map> dropData = [
    {"name": "产品名称", "value": '', "bindKey": 'name'},

    {"name": "产品级别", "value": '', "bindKey": 'productLevel'},
    {"name": "产品类别", "value": '', "bindKey": 'productType'},
    {"name": "组合类型", "value": '', "bindKey": 'combinationType'},

    {"name": "组合发数", "value": '', "bindKey": 'combinationNum'},
    {"name": "箱含量", "value": '', "bindKey": 'boxContent'},
    {"name": "单筒药量", "value": '', "bindKey": 'monocularDose'},

    {"name": "总药量", "value": '', "bindKey": 'totalDose'},
    {"name": "毛重", "value": '', "bindKey": 'grossWeight'},
    {"name": "体积", "value": '', "bindKey": 'volume'},

    {"name": "燃放效果", "value": '', "bindKey": 'setOffEffect'},
    {"name": "燃放者最低年龄要求", "value": '', "bindKey": 'offEffectAgeLimit'},

    {"name": "燃放安全距离", "value": '', "bindKey": 'setOffSafetyDistance'},

    {"name": "供应商", "value": '', "bindKey": 'suppliers'},

    {"name": "条形码", "value": '', "bindKey": 'barCode'},
  ];

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    print(dropData);
    return Container(
        width: widghtSize.width,
        height: widghtSize.height,
        padding: EdgeInsets.only(bottom: size.width * 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: lineGradBlue),
        ),
        child: ListView.builder(
          itemCount: dropData.length,
          itemBuilder: (context, index) {
            return 
            // 暂时不显示条形码图片
              // dropData[index]['name'] != '条形码' ? 
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                    child: InkWell(
                      onTap: () {},
                      child: 
                      // dropData[index]['value'].toString() == ''
                      //     ? Container()
                      //     : 
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dropData[index]['name'].toString() + ":",
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: dropData[index]['value']
                                            .toString()
                                            .judgeHasCharacter()
                                        ? null
                                        : 1.1,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(
                                    dropData[index]['value'].toString() == '' ? '无' : dropData[index]['value'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                              ],
                            ),
                    ),
                  );
                // : Padding(
                //     padding: EdgeInsets.only(top: size.width * 30),
                //     child: Center(
                //       child: BarCodeImage(
                //         params: UPCABarCodeParams(
                //           dropData[index]['value'].toString(),
                //           withText: true,
                //         ),
                //         foregroundColor: Colors.blue,
                //       ),
                //     ),
                //   );
          },
        ));
  }
}

class ProductBuildDragWidget extends StatefulWidget {
  ProductBuildDragWidget({this.id});
  final int id;
  @override
  _ProductBuildDragWidgetState createState() => _ProductBuildDragWidgetState();
}

class _ProductBuildDragWidgetState extends State<ProductBuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();

  @override
  void initState() {
    super.initState();
    _getList();
  }

  List data = [];

  _getList(){
    myDio.request(
      type: 'get',
      url: Interface.getProductLibraryById,
      queryParameters: {
        "id": widget.id
      }
    ).then((value) {
      if (value != null) {
        data = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        //抽屉的子Widget
        dragWidget: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(size.width * 30),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/cahnpinchucun2@2x.png",
                    height: size.width * 32,
                    width: size.width * 32,
                  ),
                  SizedBox(
                    width: size.width * 20,
                  ),
                  Text(
                    '产品储存量',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 28
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Column(
                      children: [
                        Container(
                          height: size.width * 1,
                          width: double.infinity,
                          color: Color(0xfff0f0f0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '仓库名称：${data[index]['name']}',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 28
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 15,
                                  ),
                                  Text(
                                    '仓库负责人：${data[index]['warehouseSecurityOfficer']}',
                                    style: TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: size.width * 24
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                width: size.width * 180,
                                child: Row(
                                  children: [
                                    Image.asset(
                                "assets/images/huowuchucun@2x.png",
                                height: size.width * 32,
                                width: size.width * 32,
                              ),
                              SizedBox(
                                width: size.width * 15,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Color(0xff3172FE)),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: data[index]['stock'].toString(),
                                          style: TextStyle(fontSize: size.width * 40)),
                                      TextSpan(
                                          text: '件',
                                          style: TextStyle(fontSize: size.width * 20)),
                                    ]),
                              ),
                                  ],
                                )
                              )
                            ],
                          ),
                        )
                      ],
                  );
                }
              )
            )
          ],
        ),
        //抽屉关闭时的高度 默认0.4
        // initChildRate: 0.1,
        maxChildRate: .8,
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
      ),
    );
  }
}