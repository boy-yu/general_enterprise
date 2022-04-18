import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myEduPlayBackVideo.dart';
// import 'package:enterprise/common/myVideoPlay.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PlaybackTextBook extends StatefulWidget {
  @override
  _PlaybackTextBookState createState() => _PlaybackTextBookState();
}

class _PlaybackTextBookState extends State<PlaybackTextBook> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map data = {
    "introduce": "",
    "name": "",
    "url": "",
    "second": 0
  };

  _getData(){
    myDio.request(
      type: "get",
      url: Interface.getPlaybackVideo,
      queryParameters: {
        'id': 1
      }
    ).then((value) {
      if (value is Map) {
        data = value;
        setState(() {
          show = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('直播回放教材'),
      child: Transtion(
        Column(
          children: [
            Text(
              data['name']
            ),
            Text(
              data['introduce']
            ),
            MyEduPlayBackVideo(url: data['url'])
          ],
        ),
        show,
      ),
    );
  }
}