import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/education/My/demand.dart';
import 'package:flutter/material.dart';

class DemanVideoList extends StatefulWidget {
  final Widget widget;
  final String title;
  final List data;
  final int id;
  const DemanVideoList({Key key, this.widget, this.title = "", this.data, this.id})
      : super(key: key);

  @override
  _DemanVideoListState createState() => _DemanVideoListState();
}

class _DemanVideoListState extends State<DemanVideoList> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(widget.title),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.widget ?? Container(),
            Expanded(
                child: widget.data.isNotEmpty ? ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return DemandTextBook(
                        data: widget.data[index],
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      );
                    }) : Container()
            ), 
          ],
        ));
  }
}

class EduDemandDetail extends StatefulWidget {
  @override
  _EduDemandDetailState createState() => _EduDemandDetailState();
}

class _EduDemandDetailState extends State<EduDemandDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
