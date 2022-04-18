import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class MyRefuseDialog{
  static Future myRefuseDialog(context, callback){
    String strReason = '';
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Container(
            width: size.width * 690,
            height: size.width * 427,
            padding: EdgeInsets.symmetric(horizontal: size.width * 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 30,
                ),
                Text(
                  '提示',
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Row(
                  children: [
                    Text(
                      '未通过原因',
                      style: TextStyle(
                          color: Color(0xFFFF5454),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Container(
                  height: size.width * 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xFFEEEEEE),
                        style: BorderStyle.solid,
                        width: size.width * 1),
                  ),
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '请输入未通过原因',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: size.width * 10,
                          vertical: size.width * 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: size.width * 28, color: Colors.grey),
                    ),
                    onChanged: (str){
                      strReason = str;
                    }
                  ),
                ),
                SizedBox(
                  height: size.width * 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      onTap: () {
                        callback(strReason);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 65,
                            vertical: size.width * 19),
                        decoration: BoxDecoration(
                            color: Color(0xFF3072FE),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          '提交',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 26),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}