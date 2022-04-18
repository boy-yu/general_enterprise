import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      child: AboutContext(),
      title: Text('关于我们'),
    );
  }
}

class AboutContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(top: size.width * 70, bottom: size.width * 30),
          child: Image.asset(
            'assets/images/ic_launcher.png',
            width: size.width * 80,
            height: size.width * 80,
          ),
        ),
        Text(
          '天顺慧智',
          style: TextStyle(
              fontSize: size.width * 30,
              color: Color.fromRGBO(110, 170, 250, 1)),
        ),
        SizedBox(
          height: size.width * 34,
        ),
        Text(
          '公司简介',
          style: TextStyle(
            fontSize: size.width * 36,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: size.width * 32, horizontal: size.width * 60),
          child: Text(
            '\t\t\t\t\t\t\t\t四川省天顺慧智安全科技有限公司，提供web端、手机App、微信小程序、微信公众号等开发服务。 我们秉承着“创新风格，品质服务”的理念，致力于计算机软件、网络技术开发，为客户提供更优质的服务。',
            style: TextStyle(fontSize: size.width * 30),
          ),
        )
      ],
    );
  }
}
