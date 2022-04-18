import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class EmergencyRescueTeamList extends StatefulWidget {
  @override
  _EmergencyRescueTeamListState createState() =>
      _EmergencyRescueTeamListState();
}

class _EmergencyRescueTeamListState extends State<EmergencyRescueTeamList> {
  List data = [
    {
      'name': '矿山救援队',
      'num': 10,
      'icon': 'assets/images/icon_teamlist_mine.png',
    },
    {
      'name': '危化救援队',
      'num': 10,
      'icon': 'assets/images/icon_teamlist_dangerous.png',
    },
    {
      'name': '其他救援队',
      'num': 10,
      'icon': 'assets/images/icon_teamlist_rests.png',
    },
    {
      'name': '医疗救援队',
      'num': 10,
      'icon': 'assets/images/icon_teamlist_medical.png',
    },
    {
      'name': '地震救援队',
      'num': 10,
      'icon': 'assets/images/icon_teamlist_earthquake.png',
    },
    {
      'name': '消防救援队',
      'num': 10,
      'icon': 'assets/images/icon_teamlist_fire.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('救援队伍'),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: size.width * 20),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ShaIcon(
                nums: data[index]['num'],
                name: data[index]['name'],
                icon: data[index]['icon'],
                onTap: () {
                  Navigator.pushNamed(
                      context, '/emergencyRescue/___emergencyRescueSingleTeam',
                      arguments: {'title': data[index]['name']});
                },
              );
            }),
      ),
    );
  }
}

class ShaIcon extends StatefulWidget {
  ShaIcon(
      {@required this.onTap,
      @required this.name,
      @required this.nums,
      this.icon,
      this.icons,
      this.descrpit});
  final Function onTap;
  final String name, icon, descrpit;
  final int nums;
  final Icon icons;
  @override
  _ShaIconState createState() => _ShaIconState();
}

class _ShaIconState extends State<ShaIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.width * 15, horizontal: size.width * 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                  blurRadius: 2.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
                  )
            ]),
        child: Row(
          children: [
            Container(
              width: size.width * 11,
              height: size.width * 100,
              decoration: BoxDecoration(
                color: Color(0xff3174FF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 20, horizontal: size.width * 30),
                child: Row(
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: Color(0xff1A1A1A),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    ShadowIcon(icon: widget.icon, icons: widget.icons)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShadowIcon extends StatelessWidget {
  ShadowIcon({
    this.width = 35,
    this.height = 35,
    this.padding,
    this.icons,
    this.icon,
  });
  final String icon;
  final Icon icons;
  final double width, height;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Container(
            padding: padding,
            height: width,
            width: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xff3174FF),
                    Color(0xff87AEFF),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff86ADFF),
                    offset: Offset(1.0, 2.0), //阴影xy轴偏移量
                    blurRadius: 6.0, //阴影模糊程度
                    // spreadRadius: 1.0 //阴影扩散程度
                  )
                ]),
            alignment: Alignment.center,
            child: Image.asset(
              icon,
              height: size.width * 38,
              width: size.width * 38,
            ))
        : icons;
  }
}
