import 'package:flutter/material.dart';

class Notify {
  Notify(this.name, this.value);
  String name;
  Map<String, dynamic> value;
}

class Counter with ChangeNotifier {
  // notifiWaitWork
  Map<String, Map<String, List>> _notity = {};
  Map<String, Map<String, List>> get notity => _notity;
  void assginNotity(Notify data) {
    if (_notity.containsKey(data.name)) {
      data.value.forEach((key, value) {
        if (_notity[data.name][key] is Map) {
          _notity[data.name][key].add(value);
        } else {
          _notity[data.name][key] = [value];
        }
      });
    } else {
      data.value.forEach((key, value) {
        _notity.addAll({
          data.name: {
            key: [value]
          }
        });
      });
    }

    notifyListeners();
  }

  void emptyNotity({String name, String account}) {
    if (name != null) {
      if (account == null) {
        _notity.remove(name);
      } else {
        if (_notity[name] is Map) {
          _notity[name].remove(account);
          if (_notity[name].isEmpty) {
            _notity.remove(name);
          }
        }
      }
    } else {
      _notity.clear();
    }

    notifyListeners();
  }

  // chatList scroll event
  int _chatListIndex = -1;
  int get chatListIndex => _chatListIndex;
  void assginChatListIndex(int index) {
    _chatListIndex = index;
    notifyListeners();
  }

  // backpage grab state

  // submit work data
  Map _submitDate = {};
  Map get submitDates => _submitDate;

  List _signState = [];
  List get signState => _signState;

  dynamic signArr = {};
  dynamic get signArrs => signArr;

  List _guardianSearch = [];
  List get guardianSearch => _guardianSearch;

  bool _dateStyle = false;
  bool get dateStyle => _dateStyle;
  //  apply parents all dates;

  // myRefre toggle trigger state
  bool _refresh = false;
  bool get refresh => _refresh;

  void refreshFun(bool state) {
    _refresh = state;
    notifyListeners();
  }

  void changeDateStyle(bool change) {
    _dateStyle = !change;
    notifyListeners();
  }

  List smallTicket = [];
  List get smallTickets => smallTicket;

  void changeGuardianSearch(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void legislationSearch(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void addPeopleSearch(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void emergencyRescueFirmSearch(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void emergencyRescueFirmSearchHis(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void emergencyRescueFileSearchHis(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void educationSearch(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void workPeopleSearch(String name) {
    if (name != '') {
      if (_guardianSearch.indexOf(name) == -1) {
        _guardianSearch.insert(0, name);
      }
    }
  }

  void emptyGuardianSearch({Function callback}) {
    _guardianSearch = [];
    if (callback != null) {
      callback();
    }
  }

  void changeSignState(String value) {
    bool isadd = true;
    _signState.forEach((element) {
      if (element == value) {
        isadd = false;
      }
    });
    if (isadd) _signState.add(value);
    // print(_signState);
  }

  void emptySignState() {
    _signState = [];
  }

  void assginSmallTicket(List data) {
    smallTicket = data;
    // notifyListeners();
  }

  _recursionSmallTicket(List path, String value, assginData,
      {String names, String type}) {
    if (path.length > 1) {
      var tempIndex = path[0];
      path.removeRange(0, 1);
      _recursionSmallTicket(path, value, assginData[tempIndex],
          names: names, type: type);
    } else {
      if (type.toString().indexOf('table') > -1) {
        String assginValue = '';
        String temp = assginData[path[0]]['value'];
        String severId = temp.substring(0, temp.indexOf('-') + 1);
        int index = int.parse(type.split('|')[1]);
        String values = temp.substring(temp.indexOf('-') + 1);
        List valueArr = values.split('|');
        if (index == 0) {
          valueArr[index] = value;
        } else {
          for (int n = 0; n < index + 1; n++) {
            if (valueArr.length <= n) {
              valueArr.add('');
            }
          }
          valueArr[index] = value;
        }
        assginValue = valueArr
            .toString()
            .replaceAll(RegExp(r', '), '|')
            .replaceAll(RegExp(r'\['), '')
            .replaceAll(RegExp(r'\]'), '');
        // print(assginValue);
        // delete end |
        if (assginValue.length > 1) {
          if (assginValue.indexOf('|', assginValue.length - 1) > -1) {
            int deleteEnd = assginValue.indexOf('|', assginValue.length - 1);
            if (deleteEnd == assginValue.length - 1) {
              assginValue = assginValue.substring(0, deleteEnd);
            }
          }
        }
        assginData[path[0]]['value'] = severId + assginValue;
      } else if (type.toString().indexOf('images') > -1) {
        String assginValue = '';
        String temp = assginData[path[0]]['value'];
        String severId = temp.substring(0, temp.indexOf('-') + 1);
        int index = int.parse(type.split('|')[1]);
        String values = temp.substring(temp.indexOf('-') + 1);
        List valueArr = values.split('|');
        if (index == 0) {
          valueArr[index] = value;
        } else {
          for (int n = 0; n < index + 1; n++) {
            if (valueArr.length <= n) {
              valueArr.add('');
            }
          }
          valueArr[index] = value;
        }
        for (var i = valueArr.length - 1; i > -1; i--) {
          if (type.toString().indexOf('images') > -1 && valueArr[i] == '') {
          } else {
            assginValue += valueArr[i] + "|";
          }
        }
        // print(valueArr[index]);
        // delete end |
        if (assginValue.length > 1) {
          if (assginValue.indexOf('|', assginValue.length - 1) > -1) {
            int deleteEnd = assginValue.indexOf('|', assginValue.length - 1);
            if (deleteEnd == assginValue.length - 1) {
              assginValue = assginValue.substring(0, deleteEnd);
            }
            if (assginValue.indexOf('|') == 0) {
              assginValue = assginValue.substring(1, assginValue.length);
            }
          }
        }
        assginData[path[0]]['value'] = severId + assginValue;
      } else if (type.toString().indexOf('remove') > -1) {
        String assginValue = '';
        String temp = assginData[path[0]]['value'];
        String severId = temp.substring(0, temp.indexOf('-') + 1);
        int index = int.parse(type.split('|')[1]);
        String values = temp.substring(temp.indexOf('-') + 1);
        List valueArr = values.split('|');
        if (valueArr.length - 1 >= index) {
          valueArr.removeAt(index);
        }

        valueArr.asMap().keys.forEach((i) {
          if (i == 0) {
            assginValue = valueArr[i];
          } else {
            assginValue += '|' + valueArr[i];
          }
        });
        // print(assginValue);
        assginData[path[0]]['value'] = severId + assginValue;
      } else {
        if (names != null) {
          String temp = assginData[path[0]][names];
          String severId =
              temp.toString().substring(0, temp.toString().indexOf('-') + 1);
          assginData[path[0]][names] = severId + value;
        } else {
          String temp = assginData[path[0]]['value'];
          String severId = temp.substring(0, temp.indexOf('-') + 1);
          assginData[path[0]]['value'] = severId + value;
        }
      }
      print(assginData[path[0]]);
    }
  }

  void changeSmallTicket(List path, String value, {String names, String type}) {
    List _path = [];
    path.forEach((element) {
      _path.add(element);
    });
    _recursionSmallTicket(_path, value, smallTicket, names: names, type: type);
  }

  void changeSubmitDates(String purview, Map value, {callBack}) {
    bool adds = true;
    _submitDate.forEach((key, values) {
      if (key == purview) {
        adds = false;
        bool objectAssgin = true;
        values.forEach((element) {
          if (element['title'] == value['title']) {
            element['value'] = value['value'];
            if (value['id'] != null) {
              element['id'] = value['id'];
            }
            objectAssgin = false;
          }
        });
        if (objectAssgin) {
          values.add(value);
        }
      } else {}
    });
    // print(title);
    // // write here because submitDate.length is not execution
    if (adds) {
      _submitDate[purview] = [];
      _submitDate[purview].add(value);
    }

    // exception
    // if (value['title'] == '作业区域' && value['id'] != null) {
    //   myDio
    //       .request(
    //     type: 'get',
    //     url: Interface.territorialUrl + value['id'].toString(),
    //   )
    //       .then((res) {
    //     if (res != null) {
    //       print(res);
    //       changeSubmitDates(
    //           purview, {"title": '属地单位', "value": res['name'], "id": res['id']},
    //           callBack: callBack);
    //     } else {
    //       if (callBack != null) {
    //         callBack('请在PC端进行配置');
    //       }
    //     }
    //   }).catchError((onError) {
    //     if (callBack != null) {
    //       callBack(onError);
    //     }
    //   });
    // }
    if (value['title'] == '属地单位') {
      if (callBack != null) {
        callBack();
      }
    }
    notifyListeners();
  }

  void delectSubmitDates({@required int title, @required String key}) {
    if (_submitDate[key] is List) {
      for (var i = submitDates[key].length - 1; i >= 0; i--) {
        print("title$title");
        print(submitDates[key][i]['title']);
        if (submitDates[key][i]['title'] == title) {
          _submitDate[key].removeAt(i);
        } else if (submitDates[key][i]['title'] > title) {
          submitDates[key][i]['title'] = submitDates[key][i]['title'] - 1;
        }
      }
    }
  }

  void emptySubmitDates({String key}) {
    if (key == null) {
      _submitDate = {};
    } else {
      _submitDate[key] = [];
    }

    notifyListeners();
  }

  void changeSignArrs(String name, String sign) {
    signArr[name] = sign;
    notifyListeners();
  }

  void emtpySignArrs() {
    signArr = {};
    notifyListeners();
  }
}
