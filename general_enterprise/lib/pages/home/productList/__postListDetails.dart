import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/newMyImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostListDetails extends StatefulWidget {
  PostListDetails({this.userId, this.rolesId});
  final int userId;
  final int rolesId;
  @override
  _PostListDetailsState createState() => _PostListDetailsState();
}

class _PostListDetailsState extends State<PostListDetails> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getRolesList();
  }

  _getRolesList() {
    myDio.request(type: 'get', url: Interface.getPostList, queryParameters: {
      "userId": widget.userId,
      "rolesId": widget.rolesId
    }).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('责任清单'),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return PostDetail(
                  data: data[index], i: index, callback: _getRolesList);
            }));
  }
}

// ignore: must_be_immutable
class PostDetail extends StatelessWidget {
  final Map data;
  final int i;
  final int button;
  final Function callback;
  PostDetail({Key key, this.data, @required this.i, this.button, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
     * traceable = 2 不可追溯数据
     * traceable = 1 可以点击
     *   （type = 1 有状态：status = 0未完成 = 1已完成）
     *   （type = 2 无状态 查看按钮）
     *   （type = 3 有状态：status = 0未完成 = 1已完成）
     */
    return data['traceable'] == 1
        ? InkWell(
            onTap: () {
              if (data['type'] == 2) {
                Navigator.pushNamed(
                    context, '/index/productList/postListThreeType',
                    arguments: {
                      "type": data['type'],
                      "rolesId": data['rolesId'],
                      'userId': data['userId'],
                      'title': data['title']
                    });
              } else {
                if (button == 1) {
                  Navigator.pushNamed(
                      context, '/index/productList/postListReportPToP',
                      arguments: {
                        'id': data['id'],
                        'button': button,
                      }).then((value) {
                    callback();
                  });
                } else {
                  Navigator.pushNamed(
                      context, '/index/productList/postListReportPToP',
                      arguments: {
                        "type": data['type'],
                        "rolesId": data['rolesId'],
                        'userId': data['userId'],
                        'title': data['title'],
                        'dutyId': data['dutyId'],
                        'button': button,
                      });
                }
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 15),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 4)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 2.0, //阴影模糊程度
                        spreadRadius: 2.0 //阴影扩散程度
                        ),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 20,
                  ),
                  Container(
                    height: size.width * 61,
                    width: size.width * 45,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/lan@2x.png'),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      i + 1 < 10
                          ? '0' + (i + 1).toString()
                          : (i + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 20,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.width * 20),
                    child: Text(
                      data['title'].toString(),
                      style: TextStyle(
                        fontSize: size.width * 26,
                        color: Color(0xff333333),
                      ),
                      maxLines: 4,
                    ),
                  )),
                  data['type'] == 1 || data['type'] == 3
                      ? Container(
                          height: size.width * 50,
                          width: size.width * 125,
                          margin: EdgeInsets.all(size.width * 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 8)),
                            border: Border.all(
                                width: size.width * 2,
                                color: data['status'] == 0 ||
                                        data['status'] == null
                                    ? Color(0xffFF6600)
                                    : Color(0xff36B334)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            data['status'] == 0 || data['status'] == null
                                ? '待签收'
                                : '已签收',
                            style: TextStyle(
                                color: data['status'] == 0 ||
                                        data['status'] == null
                                    ? Color(0xffFF6600)
                                    : Color(0xff36B334),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          height: size.width * 50,
                          width: size.width * 125,
                          margin: EdgeInsets.all(size.width * 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 8)),
                            border: Border.all(
                                width: size.width * 2,
                                color: Color(0xff3699FF)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '查看',
                            style: TextStyle(
                                color: Color(0xff3699FF),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
            ),
          )
        : button == 1 // button == 1 表示从 我的清单模块 进入页面
            ? InkWell(
                onTap: () {
                  if (data['means'] == 1) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ShowDialog(
                              //这里引用
                              child: Center(
                            child: Container(
                              height: size.width * 600,
                              width: size.width * 690,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 10))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20,
                                    vertical: size.width * 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            size: size.width * 40,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '落实岗责',
                                      style: TextStyle(
                                          fontSize: size.width * 36,
                                          color: Color(0xff0059FF),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 30,
                                    ),
                                    Text(
                                      '请确认岗责：',
                                      style: TextStyle(
                                          fontSize: size.width * 30,
                                          color: Color(0xff9D9D9D)),
                                    ),
                                    SizedBox(
                                      height: size.width * 20,
                                    ),
                                    Expanded(
                                        child: SingleChildScrollView(
                                      child: Text(
                                        data['title'].toString(),
                                        style: TextStyle(
                                            color: Color(0xff444444),
                                            fontSize: size.width * 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        myDio.request(
                                            type: 'post',
                                            url: Interface.addListJobCarriedOut,
                                            data: {
                                              "dutyId": data['id'],
                                              "data": '',
                                            }).then((value) {
                                          successToast('成功');
                                          Navigator.pop(context);
                                          callback();
                                        });
                                      },
                                      child: Container(
                                        height: size.width * 76,
                                        width: size.width * 505,
                                        margin: EdgeInsets.only(
                                            bottom: size.width * 50),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 38)),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff3174FF),
                                              Color(0xff1C3AEA),
                                            ],
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '确定',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 36),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        });
                  } else {
                    String carmaStr = '';
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ShowDialog(
                              //这里引用
                              child: Center(
                            child: Container(
                              height: size.width * 800,
                              width: size.width * 690,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 10))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20,
                                    vertical: size.width * 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            size: size.width * 40,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '落实岗责',
                                      style: TextStyle(
                                          fontSize: size.width * 36,
                                          color: Color(0xff0059FF),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 30,
                                    ),
                                    Text(
                                      '请确认岗责：',
                                      style: TextStyle(
                                          fontSize: size.width * 30,
                                          color: Color(0xff9D9D9D)),
                                    ),
                                    SizedBox(
                                      height: size.width * 20,
                                    ),
                                    Text(
                                      data['title'].toString(),
                                      style: TextStyle(
                                          color: Color(0xff444444),
                                          fontSize: size.width * 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        height: size.width * 300,
                                        child: ListView(
                                          children: [
                                            NewMyImageCarma(
                                              title: "确认岗责",
                                              name: '',
                                              score: 3,
                                              callback: (List image) {
                                                if (image.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: '请拍照');
                                                  return '';
                                                }
                                                carmaStr = '';
                                                for (var i = 0;
                                                    i < image.length;
                                                    i++) {
                                                  if (i == image.length - 1) {
                                                    carmaStr += image[i];
                                                  } else {
                                                    carmaStr += image[i] + '|';
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        )),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (carmaStr != '') {
                                          myDio.request(
                                              type: 'post',
                                              url: Interface
                                                  .addListJobCarriedOut,
                                              data: {
                                                "dutyId": data['id'],
                                                "data": carmaStr,
                                              }).then((value) {
                                            successToast('成功');
                                            Navigator.pop(context);
                                            callback();
                                          });
                                        } else {
                                          Fluttertoast.showToast(msg: '请拍照');
                                        }
                                      },
                                      child: Container(
                                        height: size.width * 76,
                                        width: size.width * 505,
                                        margin: EdgeInsets.only(
                                            bottom: size.width * 50),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 38)),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff3174FF),
                                              Color(0xff1C3AEA),
                                            ],
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '确定',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 36),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 15),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 4)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                            blurRadius: 2.0, //阴影模糊程度
                            spreadRadius: 2.0 //阴影扩散程度
                            ),
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Container(
                        height: size.width * 61,
                        width: size.width * 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/a@2x.png'),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          i + 1 < 10
                              ? '0' + (i + 1).toString()
                              : (i + 1).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Expanded(
                          child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Text(
                          data['title'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 26,
                            color: Color(0xff999999),
                          ),
                          maxLines: 4,
                        ),
                      )),
                      Container(
                        height: size.width * 50,
                        width: size.width * 125,
                        margin: EdgeInsets.all(size.width * 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 8)),
                          border: Border.all(
                              width: size.width * 2, color: Color(0xff5FC754)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          data['means'] == 1 || data['means'] == null
                              ? '待确认'
                              : '待拍照',
                          style: TextStyle(
                              color: Color(0xff5FC754),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  // statusTwo = 0 待完成; 1 已完成
                  List imageData = [];
                  imageData = data['data'].toString().split('|');
                  if (data['statusTwo'] == 1) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ShowDialog(
                              child: Center(
                            child: Container(
                              height: size.width * 600,
                              width: size.width * 690,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 10))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20,
                                    vertical: size.width * 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            size: size.width * 40,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '详情',
                                      style: TextStyle(
                                          fontSize: size.width * 36,
                                          color: Color(0xff0059FF),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 30,
                                    ),
                                    Text(
                                      data['title'].toString(),
                                      style: TextStyle(
                                          color: Color(0xff444444),
                                          fontSize: size.width * 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 20,
                                    ),
                                    // means 1: 签名详情, 2：拍照详情照片列表
                                    data['means'] == 1
                                        ? Center(
                                            child: Image.network(data['data']))
                                        : Expanded(
                                            child: GridView.builder(
                                                itemCount: imageData.length,
                                                //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        //横轴元素个数
                                                        crossAxisCount: 4,
                                                        //纵轴间距
                                                        mainAxisSpacing: 20.0,
                                                        //横轴间距
                                                        crossAxisSpacing: 10.0,
                                                        //子组件宽高长度比例
                                                        childAspectRatio: 1.0),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  //Widget Function(BuildContext context, int index)
                                                  return FadeInImage(
                                                    placeholder: AssetImage(
                                                        'assets/images/image_recent_control.jpg'),
                                                    image: NetworkImage(
                                                        imageData[index]),
                                                    width: size.width * 145,
                                                    height: size.width * 145,
                                                    fit: BoxFit.cover,
                                                  );
                                                }),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                        });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 15),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 4)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                            blurRadius: 2.0, //阴影模糊程度
                            spreadRadius: 2.0 //阴影扩散程度
                            ),
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Container(
                        height: size.width * 61,
                        width: size.width * 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/a@2x.png'),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          i + 1 < 10
                              ? '0' + (i + 1).toString()
                              : (i + 1).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Expanded(
                          child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Text(
                          data['title'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 26,
                            color: Color(0xff999999),
                          ),
                          maxLines: 4,
                        ),
                      )),
                      Container(
                        height: size.width * 50,
                        width: size.width * 125,
                        margin: EdgeInsets.all(size.width * 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(size.width * 8)),
                          border: Border.all(
                              width: size.width * 2,
                              color:
                                  data['status'] == 0 || data['status'] == null
                                      ? Color(0xffFF6600)
                                      : Color(0xff36B334)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          data['statusTwo'] == 0 || data['statusTwo'] == null
                              ? '未完成'
                              : '详情',
                          style: TextStyle(
                              color:
                                  data['status'] == 0 || data['status'] == null
                                      ? Color(0xffFF6600)
                                      : Color(0xff36B334),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}

class ShowDialog extends Dialog {
  final Widget child;
  ShowDialog({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        //透明层
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: size.width * 467,
                        margin: EdgeInsets.only(
                            left: size.width * 90,
                            right: size.width * 90,
                            bottom: size.width * 30,
                            top: size.width * 10),
                        decoration: BoxDecoration(
                          //背景装饰
                          color: Color.fromRGBO(255, 255, 255, 0.15),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(""))),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: size.width * 561,
                      margin: EdgeInsets.only(
                          left: size.width * 45,
                          right: size.width * 45,
                          bottom: size.width * 53,
                          top: size.width * 25),
                      decoration: BoxDecoration(
                        //背景装饰
                        color: Color.fromRGBO(255, 255, 255, 0.15),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )),
                Container(
                    width: size.width * 690,
                    decoration: BoxDecoration(
                      //背景装饰
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(
                        bottom: size.width * 74, top: size.width * 35),
                    child: Column(
                      children: <Widget>[
                        //内容
                        child
                      ],
                    ))
              ],
            )
          ],
        ));
  }
}
