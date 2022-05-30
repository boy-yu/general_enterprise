import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class VideoDialog {
  static Future myVideoDialog(
      context) {
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
                  width: size.width * 696,
                  height: size.width * 800,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 32))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // MyVideoPlay(url: studyVideoUrl)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 50,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.black,
                      height: size.width * 100,
                      width: size.width * 100,
                    ),
                  )
                ],
              )
                ),
        );
      },
    );
  }
}
