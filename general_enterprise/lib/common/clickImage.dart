import 'dart:io';
import 'package:animations/animations.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ClickImage extends StatefulWidget {
  final String path;
  final Function callback;
  final double width, height;
  final BoxFit fit;
  const ClickImage(
    this.path, {
    Key key,
    this.callback,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  @override
  _ClickImageState createState() => _ClickImageState();
}

class _ClickImageState extends State<ClickImage> {
  bool imageType = false;
  double width = 0.0, height = 0.0;

  @override
  void didUpdateWidget(covariant ClickImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    if (widget.path.indexOf('http') > -1) {
      imageType = false;
    } else {
      imageType = true;
    }
    if (widget.width == 0 && widget.height == 0) {
      width = 50;
      height = 50;
    } else if (widget.width == 0 && widget.height > 0) {
      width = widget.height;
      height = widget.height;
    } else if (widget.width > 0 && widget.height == 0) {
      width = widget.width;
      height = widget.width;
    } else {
      width = widget.width;
      height = widget.height;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModal(
              context: context,
              builder: (_) => Column(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InteractiveViewer(
                            child: FadeInImage(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height - 40,
                                fit: BoxFit.contain,
                                placeholder: AssetImage(
                                    'assets/images/image_recent_control.jpg'),
                                image: imageType
                                    ? AssetImage(widget.path)
                                    : NetworkImage(
                                        widget.path,
                                      ))),
                      )),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: size.width * 60),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.close,
                              size: 40,
                            ),
                          )),
                    ],
                  ));
        },
        child: JudgeNetImage(widget.path, width, height)
        // child: FadeInImage(
        //     width: width,
        //     height: height,
        //     fit: widget.fit,
        //     placeholder: AssetImage('assets/images/image_recent_control.jpg'),
        //     image: imageType
        //         ? AssetImage(widget.path)
        //         : NetworkImage(
        //             widget.path,
        //           )),
        );
  }
}

enum IsRight { http, asset, error, loading }

class JudgeNetImage extends StatefulWidget {
  final String path, errorImg;
  final double width, height;
  const JudgeNetImage(this.path, this.width, this.height,
      {this.errorImg = 'assets/images/image_recent_control.jpg'});
  @override
  _JudgeNetImageState createState() => _JudgeNetImageState();
}

class _JudgeNetImageState extends State<JudgeNetImage> {
  IsRight isNet = IsRight.loading;
  HttpClient httpClient = HttpClient();
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    if (widget.path.indexOf('http') > -1) {
      Uri uri = Uri.parse(widget.path);
      HttpClientRequest _request = await httpClient.getUrl(uri);
      HttpClientResponse response = await _request.close();
      if (response.statusCode != 200) {
        isNet = IsRight.error;
      } else {
        isNet = IsRight.http;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget _judegtState() {
    switch (isNet) {
      case IsRight.http:
        return Image.network(widget.path,
            width: widget.width, height: widget.height);
      case IsRight.error:
        return Image.asset(widget.errorImg,
            width: widget.width, height: widget.height);
      case IsRight.asset:
        return Image.asset(widget.path,
            width: widget.width, height: widget.height);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _judegtState();
  }
}
