import 'package:chewie/chewie.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyEduPlayBackVideo extends StatefulWidget {
  MyEduPlayBackVideo({this.url});
  final String url;
  @override
  _MyEduPlayBackVideoState createState() => _MyEduPlayBackVideoState();
}

class _MyEduPlayBackVideoState extends State<MyEduPlayBackVideo> {
  VideoPlayerController videoPlayerController;
   ChewieController chewieController;
  double opacity = 1.0;
  // 已经播放过的秒数
  int alreadyPlaySec = 0;

  @override
  void initState() {
    super.initState();
    alreadyPlaySec = 10;
    _init();
  }

  pause({dynamic argument}){
    chewieController?.pause();
  }

  _init() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize().then((value) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        startAt: Duration(seconds: alreadyPlaySec),
        allowPlaybackSpeedChanging: false,
        // customControls: Container(),
        // showControls: false,
        showControlsOnInitialize: true
      );
      print('inSeconds-------------------------------' + videoPlayerController.value.duration.inSeconds.toString());
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  void dispose() {
    print('disposeduration-------------------------------' + videoPlayerController.value.duration.inSeconds.toString());
    print('disposeposition----------------------------------' + videoPlayerController.value.position.inSeconds.toString());
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1 - opacity,
      duration: Duration(seconds: 1),
      child: videoPlayerController.value.isInitialized
          ? Container(
            height: size.width * 500,
            child: Chewie(
              controller: chewieController,
            ),
          )
          : Container(),
    );
  }
}