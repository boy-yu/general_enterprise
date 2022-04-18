import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EnterprisePromise extends StatefulWidget {
  @override
  _EnterprisePromiseState createState() => _EnterprisePromiseState();
}

class _EnterprisePromiseState extends State<EnterprisePromise> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  int _isOpenCar = 0;
  int _isControl = 0;
  bool _buttonPromise = false;
  Map _data = {};
  List<String> _renderlist = [];
  _init() {
    myDio.request(type: 'get', url: Interface.getConotice).then((value) {
      if (value is Map) {
        _data = value;
        _renderlist = value['content'].toString().split('\$');
        _isOpenCar = value['inProduction'];
        _isControl = value['majorHazardsControlled'];
        if (_data['principal'].toString().isEmpty) {
          _buttonPromise = true;
        }

        setState(() {});
      }
    });
  }

  Widget _widget(String e, {TextStyle style}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 20),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: size.width * 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff3072FE)),
              width: 3,
              height: 3),
          Expanded(
              child:
                  Text(e, style: style ?? TextStyle(fontSize: size.width * 28)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('企业风险研判承诺'),
        elevation: 0,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(bottom: size.width * 20),
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: lineGradBlue)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            myprefs.getString('enterpriseName'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 34),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '风险研判承诺',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 34),
                          ),
                          SizedBox(height: 10),
                        ])),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.only(
                          right: size.width * 100, left: size.width * 20),
                      width:
                          MediaQuery.of(context).size.width - size.width * 40,
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 137),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  _renderlist.map((e) => _widget(e)).toList()),
                          _widget('企业是否处于开车状态:'),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: _isOpenCar,
                                  onChanged: (value) {
                                    setState(() {
                                      _isOpenCar = value;
                                    });
                                  },
                                  title: Text('是'),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  value: 0,
                                  groupValue: _isOpenCar,
                                  onChanged: (value) {
                                    setState(() {
                                      _isOpenCar = value;
                                    });
                                  },
                                  title: Text('否'),
                                ),
                              )
                            ],
                          ),
                          _widget('企业重大危险源是否处于安全管控状态'),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: _isControl,
                                  onChanged: (value) {
                                    setState(() {
                                      _isControl = value;
                                    });
                                  },
                                  title: Text('是'),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  value: 0,
                                  groupValue: _isControl,
                                  onChanged: (value) {
                                    setState(() {
                                      _isControl = value;
                                    });
                                  },
                                  title: Text('否'),
                                ),
                              )
                            ],
                          ),
                          _widget(
                              '今天我公司已进行安全风险研判，各项安全风险防控措施已落实到位，我承诺所有生产装置处于安全运行状态，重大危险源安全风险得到有效管',
                              style: TextStyle(
                                  color: themeColor,
                                  fontSize: size.width * 28)),
                          Row(
                            children: [
                              Spacer(),
                              Column(
                                children: [
                                  Text('主要负责人: ${_data['principal']}   ',
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: size.width * 28)),
                                  Text(
                                      _data['modifyDate'] ??
                                          DateTime.now().toLocal().toString(),
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: size.width * 28)),
                                ],
                              )
                            ],
                          ),
                          _buttonPromise
                              ? Center(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  themeColor)),
                                      onPressed: () {
                                        _data['inProduction'] = _isOpenCar;
                                        _data['majorHazardsControlled'] =
                                            _isControl;

                                        myDio
                                            .request(
                                                type: 'put',
                                                url:
                                                    Interface.putPromiseNotice +
                                                        _data['id'].toString(),
                                                data: _data)
                                            .then((value) {
                                          successToast('承诺成功');
                                        }).catchError((error) {
                                          successToast('承诺失败,请稍后重试');
                                          setState(() {
                                            _buttonPromise = true;
                                          });
                                        });
                                        setState(() {
                                          _buttonPromise = false;
                                        });
                                      },
                                      child: Text('承诺')))
                              : Container()
                        ],
                      ),
                    ),
                    Positioned(
                        top: -50,
                        right: 20,
                        child: Image.asset('assets/images/chahua@2x.png',
                            width: size.width * 93, height: size.width * 167))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
