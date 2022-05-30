import 'package:enterprise/common/myVideoPlay.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class VideoDialog {
  static Future myVideoDialog(context, studyVideoUrl) {
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 640,
                height: size.width * 648,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 32))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.width * 32,
                    ),
                    Text(
                      '操作指南',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 32,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.width * 32,
                    ),
                    Container(
                      width: size.width * 576,
                      height: size.width * 500,
                      // margin: EdgeInsets.all(size.width * 32),
                      child: MyVideoPlay(url: studyVideoUrl),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  'assets/images/icon_close.png',
                  width: 35,
                  height: 35,
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
