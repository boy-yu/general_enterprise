import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/myView/myDragContainer.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_affirmHidden.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_reformAccept.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_reformFinish.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_troubleshoot.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class TaskHandle extends StatefulWidget {
  TaskHandle({this.dangerState});
  final String dangerState;
  @override
  State<TaskHandle> createState() => _TaskHandleState();
}

class _TaskHandleState extends State<TaskHandle> {
  @override
  void initState() {
    super.initState();
  }

  String _getTitle(String dangerState){
    // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
    switch (dangerState) {
      case '-1':
        return '排查';
        break;
      case '0':
        return '确认隐患';
        break;
      case '1':
        return '整改完毕';
        break;
      case '9':
        return '整改审批';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Text(_getTitle(widget.dangerState), style: TextStyle(fontSize: size.width * 32),),
      child: Stack(
        children: [
          ScrollTop(),
          BuildDragWidget(
            dangerState: widget.dangerState
          ),
        ],
      ),
    );
  }
}

class ScrollTop extends StatefulWidget {
  @override
  State<ScrollTop> createState() => _ScrollTopState();
}

class _ScrollTopState extends State<ScrollTop> {
  List<Map> dropData = [
    {"name": "风险分析对象", "value": '', "bindKey": 'riskPoint'},
    // {"name": "固有危险等级", "value": '', "bindKey": 'inherentHazardLevel'},
    {"name": "责任部门", "value": '', "bindKey": 'responsibleDepartment'},
    {"name": "责任人", "value": '', "bindKey": 'personLiable'},
    {"name": "风险分析单元", "value": '', "bindKey": 'riskUnit'},
    {"name": "风险事件", "value": '', "bindKey": 'riskItem'},
    // {"name": "风险名称", "value": '', "bindKey": 'riskName'},
    {"name": "风险等级", "value": '1', "bindKey": 'riskLevel'},
    // {"name": "风险类别", "value": '', "bindKey": 'riskType'},
    {"name": "风险描述", "value": '', "bindKey": 'riskDescription'},
    {"name": "初始风险后果", "value": '', "bindKey": 'riskConsequences'},
    // {"name": "初始风险可能性", "value": '', "bindKey": 'initialRiskPossibility'},
    {"name": "初始风险度", "value": '', "bindKey": 'initialRiskDegree'},
    {"name": "初始风险等级", "value": '3', "bindKey": 'initialRiskLevel'},
    // {"name": "分类", "value": '', "bindKey": 'classification'},
    // {"name": "隐患类型", "value": '', "bindKey": 'hiddenDangereType'},
    // {"name": "管控部位", "value": '', "bindKey": 'responsibleDepartment'},
    {"name": "管控措施", "value": '', "bindKey": 'controlMeasures'},
    // {"name": "检查方式", "value": '', "bindKey": 'checkWay'},
    // {"name": "对应标准", "value": '', "bindKey": 'title'},
  ];

  String _getText(String name, String value) {
    // 风险等级：1_重大2_较大3_一般4_低
    if (name == '风险等级' || name == '初始风险等级') {
      switch (value) {
        case '1':
          return '重大风险';
          break;
        case '2':
          return '较大风险';
          break;
        case '3':
          return '一般风险';
          break;
        case '4':
          return '低风险';
          break;
        default:
          return value.toString();
      }
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return Container(
        width: widghtSize.width,
        height: widghtSize.height,
        padding: EdgeInsets.only(bottom: size.width * 200),
        color: Color(0xff3074FF),
        child: ListView.builder(
          itemCount: dropData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 32, vertical: size.width * 10),
              child: Text(
                '${dropData[index]['name']}：${_getText(dropData[index]['name'].toString(), dropData[index]['value'].toString())}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 28,
                  fontWeight: FontWeight.w500
                ),
              )
            );
          },
        ));
  }
}

class BuildDragWidget extends StatefulWidget {
  BuildDragWidget({this.dangerState});
  final String dangerState;
  @override
  State<BuildDragWidget> createState() => _BuildDragWidgetState();
}

class _BuildDragWidgetState extends State<BuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();

  Widget _judgeWidget(){
    // 隐患状态（排查：-1；确认隐患：0；整改完毕：1；整改审批：9）
    switch (widget.dangerState) {
      case '-1':
        return Troubleshoot();
        break;
      case '0':
        return AffirmHidden();
        break;
      case '1':
        return ReformFinish();
        break;
      case '9':
        return ReformAccept();
        break;
      default:
        return Container();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    //层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        //抽屉的子Widget
        dragWidget: Column(
          children: [
            Expanded(child: _judgeWidget())
          ],
        ),
        //抽屉关闭时的高度 默认0.4
        // initChildRate: 0.1,
        maxChildRate: .8,
        //是否显示默认的标题
        isShowHeader: true,
        //背景颜色
        backGroundColor: Colors.white,
        //背景圆角大小
        cornerRadius: 0,
        //自动上滑动或者是下滑的分界值
        maxOffsetDistance: 0,
        //抽屉控制器
        controller: dragController,
        //滑动控制器
        scrollController: scrollController,
        //自动滑动的时间
        duration: Duration(milliseconds: 800),
      ),
    );
  }
}