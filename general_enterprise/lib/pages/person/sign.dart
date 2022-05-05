import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/myView/myCancelSign.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonSign extends StatefulWidget {
  @override
  _PersonSignState createState() => _PersonSignState();
}

class _PersonSignState extends State<PersonSign> {
  SharedPreferences prefs;
  String signUrl = '';
  Counter _counter = Provider.of(myContext);
  @override
  void initState() {
    super.initState();
    _init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: 'mySign');
    });
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    signUrl = prefs.getString('sign');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MyAppbar(
          title: Text('我的签名'),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(size.width * 50),
                child: CancelSign(
                  title: '请点击进行签名',
                  purview: 'mySign',
                  url: signUrl,
                ),
              )),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: () {
                    bool next = false;
                    if (_counter.submitDates['mySign'] is List) {
                      _counter.submitDates['mySign'].forEach((element) {
                        if (element['title'] == '请点击进行签名') {
                          next = true;
                          signUrl = element['value'];
                        }
                      });
                    }
                    if (next) {
                      myDio.request(
                          type: 'put',
                          url: Interface.amendSign,
                          data: {"sign": signUrl}).then((value) {
                        // print({"sign": signUrl});
                        prefs.setString('sign', signUrl);
                        successToast('修改成功');
                        Navigator.pop(context);
                      });
                    } else {
                      Fluttertoast.showToast(msg: '签字不能为空');
                    }
                  },
                  child: Text('确认修改', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
        onWillPop: () async {
          if (prefs.getString('sign') == '' ||
              prefs.getString('sign') == null) {
            Fluttertoast.showToast(msg: '为了正常使用app,请先进行签字');
            return false;
          } else {
            return true;
          }
        });
  }
}
