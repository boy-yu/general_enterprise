import 'package:flutter/material.dart';

class EmergencyRescueEvacuatePic extends StatefulWidget {
  @override
  _EmergencyRescueEvacuatePicState createState() => _EmergencyRescueEvacuatePicState();
}

class _EmergencyRescueEvacuatePicState extends State<EmergencyRescueEvacuatePic> {
  List data = [
    {
      'name': '应急疏散图',
      'bgimg': 'assets/images/bg_evacuate.png',
      'icon': 'assets/images/icon_evacuate.png',
      'router': '/emergencyRescue/__emergencyRescueEvacuate',
    },
    {
      'name': '个人和社会可接受风险图',
      'bgimg': 'assets/images/bg_risk_pic.png',
      'icon': 'assets/images/icon_risk_pic.png',
      'router': '/emergencyRescue/__emergencyRescueRiskPic',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset('assets/images/emergencyRescue.png'),
      );
    // ListView.builder(
    //   itemCount: data.length,
    //   itemBuilder: (context, index){
    //     return InkWell(
    //       onTap: (){
    //         if(data[index]['router'] == ''){
    //           Fluttertoast.showToast(msg: '....');
    //         }else{
    //           Navigator.pushNamed(
    //             context, 
    //             data[index]['router'],
    //           );
    //         }
    //       },
    //       child: Container(
    //         height: size.width * 130,
    //         width: size.width * 570,
    //         margin: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 25),
    //         padding: EdgeInsets.symmetric(horizontal: size.width * 20),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
    //           image: DecorationImage(
    //             image: AssetImage(data[index]['bgimg']),  
    //             fit: BoxFit.cover
    //           ),
    //         ),
    //         child: Row(
    //           children: [
    //             Text(
    //               data[index]['name'],
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: size.width * 32
    //               ),
    //             ),
    //             Spacer(),
    //             Image.asset(
    //               data[index]['icon'],
    //               width: size.width * 65,
    //               height: size.width * 65,
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //   }
    // );
  }
}