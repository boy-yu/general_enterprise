import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/empty@2x.png",
                        height: size.width * 288,
                        width: size.width * 374,
                      ),
                      Text(
                        '暂无数据'
                      )
                    ],
                  )
                );
  }
}
