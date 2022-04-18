import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/hiddenData.dart';
import 'package:enterprise/pages/home/checkLisk/data/spotCheckData.dart';
import 'package:enterprise/pages/home/work/_workPlan.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WorkPlanDialog extends StatefulWidget {
  WorkPlanDialog({@required this.data, @required this.callback});
  final Function callback;
  final Map data;
  @override
  _WorkPlanDialogState createState() => _WorkPlanDialogState();
}

class _WorkPlanDialogState extends State<WorkPlanDialog> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // 检测网络
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool network = true;

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        // setState(() => _connectionStatus = result.toString());
        if (result.toString() == 'ConnectivityResult.none') {
          network = false;
          setState(() {});
        } else {
          network = true;
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  bool _assginWorkPlan(Counter _context, Map post) {
    bool _bool = true;
    String tempTitle = '作业计划';
    post["workName"] = _assginValue(_context.submitDates, '作业名称', tempTitle);
    post["region"] = _assginValue(_context.submitDates, '作业区域', tempTitle);
    post['regionId'] =
        _assginValue(_context.submitDates, '作业区域', tempTitle, field: 'id');
    post["description"] = _assginValue(_context.submitDates, '作业内容', tempTitle);
    post["territorialUnit"] =
        _assginValue(_context.submitDates, '属地单位', tempTitle);
    post["territorialUnitId"] =
        _assginValue(_context.submitDates, '属地单位', tempTitle, field: 'id');
    post["riskIdentifierUserIds"] =
        _assginValue(_context.submitDates, '作业风险辨识人', tempTitle);

    post["planDate"] = _assginValue(_context.submitDates, '作业时间', tempTitle);
    // post["isfavorites"] = _assginValue(_context.submitDates, '是否收藏', tempTitle);
    for (var item in post.values) {
      if (item == '') {
        Fluttertoast.showToast(msg: '请填写完整');
        _bool = false;
        break;
      }
    }
    return _bool;
    // post['id'] = widget.id;
  }

  /// return T
  _assginValue(data, name, title, {String field}) {
    var value;
    data[title].forEach((element) {
      if (element['title'] == name) {
        if (element['value'] != null) {
          if (field != null) {
            value = element['id'].toString();
          } else {
            value = element['value'];
          }
        }
      }
    });
    return value ?? '';
  }

  Map post = {};
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('作业计划'),
      child: WorkPlan(
        circuit: 1,
        sumbitWidget: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(themeColor)),
          onPressed: () {
            if (_assginWorkPlan(context.read<Counter>(), post)) {
              post['planApprovalDepartmentUids'] = [];
              if (post['riskIdentifierUserIds'] is List) {
                for (var i = 0; i < post['riskIdentifierUserIds'].length; i++) {
                  if (post['riskIdentifierUserIds'][i] is Map) {
                    post['riskIdentifierUserIds'][i] =
                        post['riskIdentifierUserIds'][i]['id'];
                  }
                }
              }

              if (post['planApprovalUserIds'] is List) {
                for (var i = 0; i < post['planApprovalUserIds'].length; i++) {
                  if (post['planApprovalUserIds'][i] is Map) {
                    post['planApprovalUserIds'][i] =
                        post['planApprovalUserIds'][i]['id'];
                  }
                }
              }

              post.forEach((key, value) {
                widget.data[key] = value;
              });
              widget.data['planApprovalDepartmentUids'] = [];
              if (network) {
                myDio
                    .request(
                        type: 'post',
                        url: Interface.postHiddenDangereConfirm,
                        data: widget.data)
                    .then((value) {
                  for (int i = 0;
                      i < HiddenData.instance.download.length;
                      i++) {
                    if (HiddenData.instance.download[i]['id'] ==
                        widget.data['id']) {
                      HiddenData.instance.download
                          .remove(HiddenData.instance.download[i]);
                    }
                  }
                  for (int j = 0;
                      j < SpotCheckData.instance.download.length;
                      j++) {
                    if (SpotCheckData.instance.download[j]['id'] ==
                        widget.data['id']) {
                      SpotCheckData.instance.download
                          .remove(SpotCheckData.instance.download[j]);
                    }
                  }
                  Fluttertoast.showToast(
                      msg: '成功',
                      backgroundColor: themeColor,
                      textColor: Colors.white,
                      webPosition: "center");
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
                print(widget.data);
              } else {
                print(widget.data);
                AlreadySubmitData.instance.submitData.add({
                  'url': Interface.postHiddenDangereConfirm,
                  'data': widget.data,
                  'type': '确认隐患',
                  'name': widget.data['keyParameterIndex'],
                });
                for (int i = 0; i < HiddenData.instance.download.length; i++) {
                  if (HiddenData.instance.download[i]['id'] ==
                      widget.data['id']) {
                    HiddenData.instance.download
                        .remove(HiddenData.instance.download[i]);
                  }
                }
                for (int j = 0;
                    j < SpotCheckData.instance.download.length;
                    j++) {
                  if (SpotCheckData.instance.download[j]['id'] ==
                      widget.data['id']) {
                    SpotCheckData.instance.download
                        .remove(SpotCheckData.instance.download[j]);
                  }
                }
                Fluttertoast.showToast(msg: '保存成功');
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
          child: Text('提交'),
        ),
      ),
    );
  }
}
