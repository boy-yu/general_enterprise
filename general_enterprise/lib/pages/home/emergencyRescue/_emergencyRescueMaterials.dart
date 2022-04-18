
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmergencyRescueMaterials extends StatefulWidget {
  @override
  _EmergencyRescueMaterialsState createState() => _EmergencyRescueMaterialsState();
}

class _EmergencyRescueMaterialsState extends State<EmergencyRescueMaterials> {
  List data = [
    {
      'name': '救援队伍',
      'bgimg': 'assets/images/bg_rescue_team.png',
      'icon': 'assets/images/icon_rescue_team.png',
      'router': '/emergencyRescue/__emergencyRescueTeamList',
    },
    {
      'name': '救援专家',
      'bgimg': 'assets/images/bg_specialists.png',
      'icon': 'assets/images/icon_specialists.png',
      'router': '/emergencyRescue/__emergencyRescueExpert',
    },
    {
      'name': '救援物资',
      'bgimg': 'assets/images/bg_inside_materials.png',
      'icon': 'assets/images/icon_inside_materials.png',
      'router': '/emergencyRescue/__emergencyRescueInsideMaterials',
    },
    // {
    //   'name': '周边救援物资',
    //   'bgimg': 'assets/images/bg_rim_materials.png',
    //   'icon': 'assets/images/icon_rim_materials.png',
    //   'router': '',
    // },
    {
      'name': '周边资源',
      'bgimg': 'assets/images/bg_rim_resource.png',
      'icon': 'assets/images/icon_rim_resource.png',
      'router': '/emergencyRescue/__emergencyRescueRim',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
        return InkWell(
          onTap: (){
            if(data[index]['router'] == ''){
              Fluttertoast.showToast(msg: '....');
            }else{
              Navigator.pushNamed(
                context, 
                data[index]['router'],
              );
            }
          },
          child: Container(
            height: size.width * 130,
            width: size.width * 570,
            margin: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 25),
            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                image: AssetImage(data[index]['bgimg']),  
                fit: BoxFit.cover
              ),
            ),
            child: Row(
              children: [
                Text(
                  data[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 32
                  ),
                ),
                Spacer(),
                Image.asset(
                  data[index]['icon'],
                  width: size.width * 65,
                  height: size.width * 65,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}