import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlay extends StatefulWidget {
  final String url;
  final ThrowFunc throwFunc;
  MyVideoPlay({this.url,this.throwFunc});
  @override
  _MyVideoPlayState createState() => _MyVideoPlayState();
}

class _MyVideoPlayState extends State<MyVideoPlay>
    with TickerProviderStateMixin {
  VideoPlayerController videoPlayerController;
   ChewieController chewieController;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _init();
    widget.throwFunc?.init([pause]);
  }

  pause({dynamic argument}){
    chewieController?.pause();
  }

  _init() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize().then((value) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
      );
     
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  void dispose() {
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
          ? Chewie(
              controller: chewieController,
            )
          : Container(),
    );
  }
}
