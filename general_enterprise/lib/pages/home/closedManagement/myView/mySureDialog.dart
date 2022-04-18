import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MySureDialog {
  static Future mySureDialog(context, callback,List gateList, int type, int id) {
    List ids = [];
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Center(
              child: Container(
            width: size.width * 690,
            height: size.width * 600,
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 29,
                ),
                Text(
                  '提示',
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.width * 35,
                ),
                Text(
                  '请选择允许进入闸机',
                  style: TextStyle(
                      color: Color(0xFFFF5454),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: gateList.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          if(ids.isEmpty){
                            ids.add(gateList[index]['id']);
                          }else{
                            if(ids.contains(gateList[index]['id'])){
                              ids.remove(gateList[index]['id']);
                            }else{
                              ids.add(gateList[index]['id']);
                            }
                          }
                          state(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 20,vertical: size.width * 20),
                          child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  ids.contains(gateList[index]['id']) ? 'assets/images/icon_check_box.png' : 'assets/images/un_icon_check_box.png',
                                  height: size.width * 26,
                                  width: size.width * 26,
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Text(
                                  gateList[index]['name'] + (gateList[index]['direction'] == 1 ? "（入口）" : "(出口)"),
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 28,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 20,
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                            )
                          ],
                        ),
                        )
                      );
                    }
                  )
                ),
                // Expanded(
                //   child: StaggeredGridView.countBuilder(
                //     crossAxisCount: 2, // 每行个数, 
                //     itemCount: gateList.length,
                //     staggeredTileBuilder: (int index) => StaggeredTile.fit(1), // 重点
                //     shrinkWrap: true,
                //     itemBuilder: (context, index){
                //       return CheckboxListTile(
                //         value: gateList[index]['ispass'], 
                //         onChanged: (value){
                //           state(() {
                //             gateList[index]['ispass'] = value;
                //           });
                //         }
                //       );
                //     }, 
                //   )
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 65,
                            vertical: size.width * 19),
                        decoration: BoxDecoration(
                            color: Color(0xFF939393),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          '取消',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 26),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 79,
                    ),
                    GestureDetector(
                      onTap: (){
                        print(ids);
                        if(ids.isEmpty){
                          Fluttertoast.showToast(msg: "请选择闸机入口");
                        }else{
                          Map submitData = {
                              "deviceSns": [],
                              "equipmentId": [],
                              "id": 0,
                              "isPass": 1,
                              "result": "",
                              "type": 0
                            };
                          // type 1 人员 2车辆
                          if(type == 1){
                            submitData['deviceSns'] = ids;
                          }else{
                            submitData['equipmentId'] = ids;
                          }
                          submitData['type'] = type;
                          submitData['id'] = id;
                          myDio.request(
                            type: 'put', 
                            url: Interface.putSubscribeApproval,
                             data: submitData
                          ).then((value) {
                              successToast('审批完成');
                              callback();
                              Navigator.of(context).pop();
                            });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 65,
                            vertical: size.width * 19),
                        decoration: BoxDecoration(
                            color: Color(0xFF3072FE),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          '确认',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 26),
                        ),
                      ),
                    ),
                  ],
                ),
                )
              ],
            ),
          ));
        });
        // Scaffold(
        //   backgroundColor: Colors.transparent,
        //   body:
        // );
      },
    );
  }
}
