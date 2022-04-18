import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  @override
  const VideoPlay({Key key, this.videoUrl}) : super(key: key);
  final String videoUrl;
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  @override
  // ignore: override_on_non_overriding_member
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  void initState() {
    super.initState();
    _videoPlayerController1 = widget.videoUrl.indexOf("http://") != -1
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.file(File(widget.videoUrl));
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        autoPlay: false,
        showControls: false,
        showControlsOnInitialize: false,
        aspectRatio: 1 / 1,
        fullScreenByDefault: true,
        allowFullScreen: true,
        looping: false,
        autoInitialize: true);
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
