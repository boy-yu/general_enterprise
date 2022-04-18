import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class DangerList extends StatefulWidget {
  DangerList({@required this.id});
  final int id;
  @override
  _DangerListState createState() => _DangerListState();
}

class _DangerListState extends State<DangerList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
      child: (index, list) => ListItem(
        data: list[index],
      ),
      url: Interface.getChemicalList,
      method: 'get',
      queryParameters: {"majorId": widget.id},
    );

    // ListView.builder(
    //   itemBuilder: (context, index) => Padding(
    //     padding: EdgeInsets.only(
    //         left: size.width * 20,
    //         right: size.width * 20,
    //         top: size.width * 10),
    //     child: ,
    //   ),
    //   itemCount: data.length,
    // );
  }
}

class ListItem extends StatelessWidget {
  ListItem({this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          size.width * 20, size.width * 20, size.width * 20, 0),
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Text(data['chemicalCnName'].toString()),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Row(
                      children: [
                        Text(
                          '危险化学品类型：',
                          style: TextStyle(color: Colors.black.withOpacity(.6)),
                        ),
                        Expanded(child: Text(data['chemicalCnName'].toString()))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Row(
                      children: [
                        Text(
                          '危险化学品种类：',
                          style: TextStyle(color: Colors.black.withOpacity(.6)),
                        ),
                        Text(data['chemicalsType'].toString())
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Row(
                      children: [
                        Text('CAS号：',
                            style:
                                TextStyle(color: Colors.black.withOpacity(.6))),
                        Text(data['casNo'].toString())
                      ],
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 20),
                      child: Row(
                        children: [
                          Text('产品生产能力：',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6))),
                          Expanded(
                            child: Text(
                                data['productionCapacityYears'].toString()),
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Row(
                      children: [
                        Text('产品最大储量：',
                            style:
                                TextStyle(color: Colors.black.withOpacity(.6))),
                        Text(
                          data['maxReserves'].toString(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/index/dangerListOne',
                    arguments: {'id': data['msdsId'], 'url': data['labelUrl']});
              },
              child: Container(
                margin: EdgeInsets.only(right: size.width * 20),
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 5, horizontal: size.width * 22),
                decoration: BoxDecoration(
                    color: Color(0xff3869FC),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  '查看',
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 22),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
