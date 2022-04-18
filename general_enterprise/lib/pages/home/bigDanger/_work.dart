import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class DangerWord extends StatefulWidget {
  @override
  _DangerWordState createState() => _DangerWordState();
}

class _DangerWordState extends State<DangerWord> {
  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => WorkItem(
              data: list[index],
            ),
        url: Interface.getMajorHazardList,
        method: 'get');
  }
}

class WorkItem extends StatelessWidget {
  WorkItem({Key key, this.data}) : super(key: key);
  final Map data;
  final List level = ['无', '一级', '二级', '三级', '四级'];
  _getImage(int level) {
    switch (level) {
      case 1:
        return AssetImage('assets/images/level_bg_one.png');
        break;
      case 2:
        return AssetImage('assets/images/level_bg_two.png');
        break;
      case 3:
        return AssetImage('assets/images/level_bg_three.png');
        break;
      case 4:
        return AssetImage('assets/images/level_bg_four.png');
        break;
      default:
    }
  }

  _getLevel(int level) {
    switch (level) {
      case 1:
        return '一级重大危险源';
        break;
      case 2:
        return '二级重大危险源';
        break;
      case 3:
        return '三级重大危险源';
        break;
      case 4:
        return '四级重大危险源';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/index/dangerSource',
              arguments: {"id": data['id']});
        },
        child: Container(
          //   decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   color: Color(0xffFF7171),
          // ),
          margin: EdgeInsets.symmetric(vertical: size.width * 10, horizontal: size.width * 30),
          // padding: EdgeInsets.symmetric(
          //     vertical: size.width * 20, horizontal: size.width * 40),
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: _getImage(data['level']),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  data['status'] == 1
                      ? 'assets/images/icon_type_controlled.png'
                      : 'assets/images/icon_type_uncontrolled.png',
                  height: size.width * 60,
                  width: size.width * 60,
                ),
                Container(
                  width: size.width * 450,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 5, vertical: size.width * 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '名称：${data['name'].toString()}',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 28),
                      ),
                      SizedBox(
                        height: size.width * 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '重大危险源等级',
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 24),
                          ),
                          Spacer(),
                          Text(
                            _getLevel(data['level']),
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '负责人',
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 24),
                          ),
                          Spacer(),
                          Text(
                            data['principal'],
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '危险化学品名称',
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 24),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Container(
                            width: size.width * 250,
                            child: Text(
                              data['coChemicals'] != null
                                  ? data['coChemicals']
                                      .toString()
                                  : '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ))
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //     color: Color(0xffFF7171),
        //   ),
        //   margin: EdgeInsets.only(
        //       top: size.width * 20,
        //       left: size.width * 40,
        //       right: size.width * 40),
        //   padding: EdgeInsets.symmetric(
        //       vertical: size.width * 20, horizontal: size.width * 40),
        //   child: Stack(
        //     overflow: Overflow.visible,
        //     children: [
        //       // Positioned(
        //       //     left: -size.width * 73,
        //       //     top: size.width * 0,
        //       //     child: Transform.rotate(
        //       //       angle: 3.14 / .577,
        //       //       // angle: 0,
        //       //       child: ClipPath(
        //       //         clipper: Italic(),
        //       //         child: Container(
        //       //           decoration: BoxDecoration(color: Color(0xff34df54)),
        //       //           padding:
        //       //               EdgeInsets.symmetric(horizontal: size.width * 40),
        //       //           child: Text('受控',
        //       //               style: TextStyle(
        //       //                   color: Colors.white,
        //       //                   fontSize: size.width * 22)),
        //       //         ),
        //       //       ),
        //       //     )),

        //       Container(
        //         // margin: EdgeInsets.only(left: size.width * 30),
        //         padding: EdgeInsets.symmetric(horizontal: size.width * 20),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               data['name'],
        //               style: TextStyle(
        //                   color: Colors.white, fontSize: size.width * 28),
        //             ),
        //             SizedBox(height: size.width * 10),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   '重大危险源等级',
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: size.width * 24),
        //                 ),
        //                 Text(
        //                   level[data['level']] + '重大危险源',
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: size.width * 24),
        //                 )
        //               ],
        //             ),
        //             SizedBox(height: size.width * 10),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   '负责人',
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: size.width * 24),
        //                 ),
        //                 Text(
        //                   data['principal'],
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: size.width * 24),
        //                 )
        //               ],
        //             ),
        //             SizedBox(height: size.width * 10),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   '危险化学品名称',
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: size.width * 24),
        //                 ),
        //                 SizedBox(
        //                   width: size.width * 20,
        //                 ),
        //                 Expanded(
        //                     child: Text(
        //                   data['coChemicals'] ?? '',
        //                   textAlign: TextAlign.end,
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: size.width * 24),
        //                 ))
        //               ],
        //             )
        //           ],
        //         ),
        //       ),

        //       Positioned(
        //           right: size.width * -20,
        //           bottom: size.width * 0,
        //           child: Image.asset('assets/images/weixianyuan@2x.png',
        //               width: size.width * 124, height: size.width * 110))
        //     ],
        //   ),
        // ),
        );
  }
}

class Italic extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path _path = Path();
    _path.moveTo(20, 0);
    // _path.lineTo(20, 0);
    _path.lineTo(0, size.height);
    _path.lineTo(size.width, size.height);
    _path.lineTo(size.width - 16, 0);

    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
