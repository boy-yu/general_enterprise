import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/newChooseTIme.dart';
import 'package:enterprise/common/newMyDrop.dart';
import 'package:enterprise/common/newMyInput.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

enum InputType {
  input,
  choose,
  mutiuple,
  chooseDep,
  addtion,
  chooseTextBook,
  choosePeople,
  time,
  chooseExam
}

class InterActiveType {
  String lable;
  InputType type;
  String url;
  List data;
  String placeHolder;
  TextInputType textInputType;
  dynamic value;
  InterActiveType(
      {this.lable = "",
      this.type = InputType.input,
      this.data,
      this.url,
      this.textInputType,
      this.placeHolder});
  Widget widgets({EdgeInsets padding, EdgeInsets margin, List educationTrainingResources}) {
    if (type == InputType.input) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: NewMyInput(
          title: lable,
          onChange: (e) {
            value = e;
          },
          keyboardType: textInputType,
        ),
      );
    } else if (type == InputType.choose) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: NewMyDrop(
          title: lable,
          data: data,
          callSetstate: (data) {
            value = data;
          },
        ),
      );
    } else if (type == InputType.chooseDep) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: ExamAddDep(
          lable: lable,
          callback: (data){
            value = data;
          },
        ),
      );
    } else if (type == InputType.addtion) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: ExamAddtion(this),
      );
    } else if (type == InputType.chooseTextBook) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: ExamAddTextBook(
          lable: lable,
          callback: (data){
            value = data;
            educationTrainingResources = value;
          },
          educationTrainingResources: educationTrainingResources ??[]
        ),
      );
    } else if (type == InputType.choosePeople) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: ExamAddPeople(
          lable: lable,
          callback: (data){
            value = data;
          },
        ),
      );
    } else if (type == InputType.time) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: ChooseTime(
          lable: lable,
          callback: (data){
            value = data;
          },
        ),
      );
    } else if (type == InputType.chooseExam) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.black.withOpacity(.1)))),
        child: ChooseExam(
          lable: lable,
          callback: (data){
            value = data;
          },
          educationTrainingResources: educationTrainingResources
        ),
      );
    }
    return Container();
  }
}

class ChooseExam extends StatefulWidget {
  ChooseExam({this.lable, this.callback, this.educationTrainingResources});
  final String lable;
  final Function callback;
  final List educationTrainingResources;
  @override
  _ChooseExamState createState() => _ChooseExamState();
}

class _ChooseExamState extends State<ChooseExam> {
  List educationTrainingPlanExaminationVoList = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            width: size.width * 300,
            child: Text(widget.lable)),
        Expanded(
            child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/home/education/eduAddExam',
              arguments: {
                'educationTrainingResources': widget.educationTrainingResources
              }
            ).then((value) {
              if(value is List){
                educationTrainingPlanExaminationVoList = value;
                widget.callback(value);
                setState(() {});
              }
            });
          },
          child: Text(
            educationTrainingPlanExaminationVoList.length == 0 ? "请选择" : '已制定'+ educationTrainingPlanExaminationVoList.length.toString() + '阶段考试',
            textAlign: TextAlign.end,
            style: TextStyle(color: Color(0xffA6A6A6)),
          ),
        )),
        Icon(Icons.keyboard_arrow_right),
      ],
    );
  }
}

class ChooseTime extends StatefulWidget {
  ChooseTime({this.lable, this.callback});
  final String lable;
  final Function callback;
  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  String time = '请选择';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            width: size.width * 300,
            child: Text(widget.lable)),
        Expanded(
            child: InkWell(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now().toLocal(),
              firstDate: DateTime(DateTime.now().toLocal().year - 30),
              lastDate: DateTime(
                DateTime.now().toLocal().year + 30)
              ).then((value) {
                if (value != null) {
                  widget.callback(value);
                  setState(() {
                    time = value.toString().substring(0, 10);
                  });
                }
              }
            );
          },
          child: Text(
            time,
            textAlign: TextAlign.end,
            style: TextStyle(color: Color(0xffA6A6A6)),
          ),
        )),
        Icon(Icons.keyboard_arrow_right),
      ],
    );
  }
}

class ExamAddDep extends StatefulWidget {
  ExamAddDep({this.lable, this.callback});
  final String lable;
  final Function callback;
  @override
  _ExamAddDepState createState() => _ExamAddDepState();
}

class _ExamAddDepState extends State<ExamAddDep> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            width: size.width * 300,
            child: Text(widget.lable)),
        Expanded(
            child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(
              '/home/education/eduAddDep',
            ).then((value) {
              if(value is List){
                widget.callback(value);
                num = value.length;
                setState(() {});
              }
              // 返回值
            });
          },
          child: Text(
            num == 0 ? "请选择" : '已选择'+ num.toString() +'个部门',
            textAlign: TextAlign.end,
            style: TextStyle(color: Color(0xffA6A6A6)),
          ),
        )),
        Icon(Icons.keyboard_arrow_right),
      ],
    );
  }
}

class ExamAddPeople extends StatefulWidget {
  ExamAddPeople({this.lable, this.callback});
  final String lable;
  final Function callback;
  @override
  _ExamAddPeopleState createState() => _ExamAddPeopleState();
}

class _ExamAddPeopleState extends State<ExamAddPeople> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            width: size.width * 300,
            child: Text(widget.lable)),
        Expanded(
            child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(
              '/home/education/eduAddPeople',
            ).then((value) {
              if(value is List){
                widget.callback(value);
                num = value.length;
                setState(() {});
              }
              // 返回值
            });
          },
          child: Text(
            num == 0 ? "请选择" : '已选择'+ num.toString() +'位执行人',
            textAlign: TextAlign.end,
            style: TextStyle(color: Color(0xffA6A6A6)),
          ),
        )),
        Icon(Icons.keyboard_arrow_right),
      ],
    );
  }
}

class ExamAddTextBook extends StatefulWidget {
  ExamAddTextBook({this.lable, this.callback, this.educationTrainingResources});
  final String lable;
  final Function callback;
  final List educationTrainingResources;
  @override
  _ExamAddTextBookState createState() => _ExamAddTextBookState();
}

class _ExamAddTextBookState extends State<ExamAddTextBook> {
  int num = 0;

  @override
  void initState() {
    super.initState();
    if(widget.educationTrainingResources.isNotEmpty){
      num = widget.educationTrainingResources.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            width: size.width * 300,
            child: Text(widget.lable)),
        Expanded(
            child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(
              '/home/education/eduAddTextBook',
              arguments: {
                'educationTrainingResources': widget.educationTrainingResources
              }
            ).then((value) {
              if(value is List){
                widget.callback(value);
                num = value.length;
                setState(() {});
              }
              // 返回值
            });
          },
          child: Text(
            num == 0 ? "请选择" : '已选择'+ num.toString() +'本教材',
            textAlign: TextAlign.end,
            style: TextStyle(color: Color(0xffA6A6A6)),
          ),
        )),
        Icon(Icons.keyboard_arrow_right),
      ],
    );
  }
}

class ExamAddtionChildrenType {
  List topic;
  String endTime, time;
  int grade;
}

class ExamAddtionType {
  int choose;
  List<ExamAddtionChildrenType> children;
  ExamAddtionType({this.choose = 0, List<ExamAddtionChildrenType> childrens}) {
    children = childrens ?? [];
  }
}

class ExamAddtion extends StatefulWidget {
  final InterActiveType data;
  ExamAddtion(this.data);

  @override
  _ExamAddtionState createState() => _ExamAddtionState();
}

class _ExamAddtionState extends State<ExamAddtion> {
  ExamAddtionType _type = ExamAddtionType();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: size.width * 300, child: Text(widget.data.lable)),
              Expanded(
                  child: InkWell(
                onTap: () {
                  List<String> _replace = ['零', '一', '二', '三', '四', '五', '六'];
                  List<int> _counter = [0, 1, 2, 3, 4, 5, 6];

                  showModalBottomSheet(
                      context: context,
                      builder: (_) => StatefulBuilder(
                          builder: (_, state) => Column(
                                children: [
                                  Expanded(
                                      child: Wrap(
                                    children: _counter
                                        .asMap()
                                        .keys
                                        .map(
                                          (index) => InkWell(
                                              onTap: () {
                                                state(() {
                                                  _type.choose = index;
                                                  _type.children = List.generate(
                                                      _type.choose,
                                                      (index) =>
                                                          ExamAddtionChildrenType());
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    right: 20, top: 20),
                                                decoration: BoxDecoration(
                                                    color: _type.choose == index
                                                        ? themeColor
                                                        : Color(0xffF3F4F8)),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 40),
                                                child: Text(
                                                  _replace[index],
                                                  style: TextStyle(
                                                      color:
                                                          _type.choose == index
                                                              ? Colors.white
                                                              : null),
                                                ),
                                              )),
                                        )
                                        .toList(),
                                  )),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("确定"))
                                ],
                              ))).then((value) => {setState(() {})});
                },
                child: Text(
                  widget.data.value == null
                      ? "请选择" + widget.data.lable
                      : _type.choose.toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: widget.data.value == null ? placeHolder : null),
                ),
              )),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _type.children
                .asMap()
                .keys
                .map((index) => Contexts().shadowWidget(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "第${index + 1}阶段考核",
                          style: TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 26),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("制定考题:"),
                            Spacer(),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context,
                                        "/home/education/eduChooseTextBook")
                                    .then((value) => null);
                              },
                              child: Text(
                                "请配置考题",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: placeHolder),
                              ),
                            )),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        Divider(),
                        NewTimeChoose(
                          lable: "考核截至时间",
                          callback: (value) {
                            _type.children[index].endTime = value;
                          },
                        ),
                        Divider(),
                        NewTimeChoose(
                          lable: "考核截至时间",
                          callback: (value) {
                            print(value);
                          },
                        ),
                        Divider(),
                        NewMyInput(
                          title: "合格分数线",
                          textStyle: TextStyle(fontSize: size.width * 26),
                          keyboardType: TextInputType.number,
                        )
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0)))
                .toList(),
          )
        ],
      ),
    );
  }
}
