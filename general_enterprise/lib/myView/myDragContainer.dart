import 'package:drag_container/drag/custom_recognizer.dart';
import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

///lib/code15/drag/drag_container.dart
///抽屉内容Widget
///
class DragContainer extends StatefulWidget {
  ///抽屉主体内容
  final Widget dragWidget;

  ///默认显示的高度与屏幕的比率
  final double initChildRate;

  ///可显示的最大高度 与屏幕的比率
  final double maxChildRate;

  ///抽屉控制器
  final DragController controller;

  ///抽屉中滑动视图的控制器
  /// 0.0.2 版本已弃用 改为[NotificationListener]
  final ScrollController scrollController;

  ///抽屉滑动状态回调
  final Function(bool isOpen) dragCallBack;

  ///是否显示标题
  final bool isShowHeader;

  ///背景颜色
  final Color backGroundColor;

  ///背景圆角
  final double cornerRadius;

  ///滑动结束时 自动滑动到底部或者顶部的时间
  final Duration duration;

  ///滑动位置超过这个位置，会滚到顶部；
  ///小于，会滚动底部。
  ///向上或者向下滑动的临界值
  final double maxOffsetDistance;
  final bool useAtEdge;

  DragContainer(
      {Key key,
      @required this.dragWidget,
      this.initChildRate = 0.1,
      this.maxChildRate = 0.4,
      this.cornerRadius = 12,
      this.backGroundColor = Colors.white,
      this.isShowHeader = true,
      this.useAtEdge = true,
      this.duration = const Duration(milliseconds: 250),
      this.maxOffsetDistance,
      this.scrollController,
      this.controller,
      this.dragCallBack});

  @override
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer>
    with TickerProviderStateMixin {
  ///动画控制器
  AnimationController animalController;

  ///可显示的最大高度 具体的像素
  double maxChildSize;

  ///默认显示的高度 具体的像素
  double initialChildSize;
  double maxOffsetDistance;

  ///抽屉的偏移量
  double offsetDistance;

  ///动画
  Animation<double> animation;

  ///快速轻扫标识
  ///就是指手指在抽屉上快速的轻扫一下
  bool isFiling = false;

  ///为true时为打开状态
  ///初始化显示时为闭合状态
  bool isOpen = true;

  ///开始时的位置
  double startOffset = 0;

  ///开始滑动时会更新此标识
  ///是否在顶部或底部
  bool atEdge = true;

  @override
  void initState() {
    super.initState();
    animalController =
        AnimationController(vsync: this, duration: widget.duration);

    ///添加控制器监听
    if (widget.controller != null) {
      widget.controller.setOpenDragListener((value) {
        if (value == 1) {
          ///向上
          offsetDistanceOpen(isCallBack: false);
          // print("向上");
        } else {
          ///向下
          offsetDistanceClose(isCallBack: false);
          // print("向下");
        }
      });
    }
  }

  ///lib/code15/drag/drag_container.dart
  ///初始化时，在initState()之后立刻调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///State 有一个属性是mounted 用来标识State当前是否正确绑定在View树中。
    ///当创建 State 对象，并在调用 State.initState 之前，
    ///framework 会根据 BuildContext 来标记 mounted，
    ///然后在 State的生命周期里面，这个 mounted 属性不会改变，
    ///直至 framework 调用 State.dispose
    if (mounted) {
      if (maxChildSize == null) {
        ///计算抽屉可展开的最大值
        maxChildSize = MediaQuery.of(context).size.height * widget.maxChildRate;

        ///计算抽屉关闭时的高度
        initialChildSize =
            MediaQuery.of(context).size.height * widget.initChildRate;
      }

      ///计算临界值
      if (widget.maxOffsetDistance == null) {
        ///计算滑动结束向上或者向下滑动的临界值
        maxOffsetDistance = (maxChildSize - initialChildSize) / 3 * 2;
      } else {
        maxOffsetDistance =
            (maxChildSize - initialChildSize) / widget.maxOffsetDistance;
      }

      ///初始化偏移量 为抽屉的关闭状态
      offsetDistance = 0;
    }
  }

  @override
  void dispose() {
    animalController.dispose();
    super.dispose();
  }

  ///lib/code15/drag/drag_container.dart
  @override
  Widget build(BuildContext context) {
    ///抽屉视图可偏移的距离限制在
    ///widget.initialChildSize/4 与 widget.maxChildSize 之间
    offsetDistance = offsetDistance.clamp(initialChildSize / 4, maxChildSize);

    ///平移变换
    return Row(
      children: [
        SizedBox(
          width: size.width * 20,
        ),
        Expanded(
            child: Transform.translate(
          ///在y轴方向移动
          offset: Offset(0.0, offsetDistance),

          ///手势识别
          child: RawGestureDetector(
            ///自定义手势
            // gestures: {CustomVerticalDragGestureRecognizer: getRecognizer()},
            child: Stack(
              children: <Widget>[
                ///限定抽屉的显示的最大高度
                Container(
                  ///构建抽屉的内容视图
                  child: buildChild(),
                  height: maxChildSize,
                ),
                Positioned(
                  child: buildHeader(),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }

  ///lib/code15/drag/drag_container.dart
  Widget buildChild() {
    return Container(
      decoration: BoxDecoration(

          ///背景颜色设置
          color: widget.backGroundColor,

          ///只上部分的圆角
          // borderRadius: BorderRadius.only(
          //   ///左上角
          //   topLeft: Radius.circular(widget.cornerRadius),

          //   ///右上角
          //   topRight: Radius.circular(widget.cornerRadius),
          // ),
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(size.width * 80))),

      ///可滑动的Widget 这里构建的是一个
      child: Column(
        children: [
          ///默认显示的标题横线
          ///Column中使用滑动视图需要结合
          ///Expanded填充页面视图
          Expanded(
            ///通知（Notification）是Flutter中一个重要的机制，在widget树中，
            ///每一个节点都可以分发通知，通知会沿着当前节点向上传递，
            ///所有父节点都可以通过NotificationListener来监听通知
            child: NotificationListener(
              ///子Widget中的滚动组件滑动时就会分发滚动通知
              child: widget.dragWidget,

              ///每当有滑动通知时就会回调此方法
              onNotification: (Notification notification) {
                ///滚动处理 用来处理抽屉中的子列表项中的滑动
                ///与抽屉的联动效果
                // scrollNotificationFunction(notification);
                return false;
              },
            ),
          )
        ],
      ),
    );
  }

  ///lib/code15/drag/drag_container.dart
  ///滚动处理 用来处理抽屉中的子列表项中的滑动
  void scrollNotificationFunction(Notification notification) {
    ///通知类型
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        // print("开始滚动");
        ScrollStartNotification scrollNotification = notification;
        ScrollMetrics metrics = scrollNotification.metrics;

        ///当前位置
        startOffset = metrics.pixels;

        ///是否在顶部或底部
        atEdge = metrics.atEdge;
        break;
      case ScrollUpdateNotification:
        // print("正在滚动");
        ScrollUpdateNotification scrollNotification = notification;

        ///获取滑动位置信息
        ScrollMetrics metrics = scrollNotification.metrics;

        ///当前位置
        double pixels = metrics.pixels;

        ///当前滑动的位置 - 开始滑动的位置
        /// 值大于0表示向上滑动
        /// 向上滑动时当抽屉没有打开时
        /// 根据配置 widget.useAtEdge 来决定是否
        /// 自动向上滑动打开抽屉
        double flag = pixels - startOffset;
        if (flag > 0 && !isOpen && widget.useAtEdge) {
          ///打开抽屉
          offsetDistanceOpen();
        }
        break;
      case ScrollEndNotification:
        // print("滚动停止");
        break;
      case OverscrollNotification:
        // print("滚动到边界");

        ///startOffset记录的是开始滚动时的位置信息
        ///atEdge 为true时为边界
        ///widget.useAtEdge 是在使用组件时的配置是否启用
        ///当 startOffset==0.0 & atEdge 为true 证明是在顶部向下滑动
        ///在顶部向下滑动时 抽屉打开时就关闭
        if (startOffset == 0.0 && atEdge && isOpen && widget.useAtEdge) {
          offsetDistanceClose();
        }
        break;
    }
  }

  ///lib/code15/drag/drag_container.dart
  ///开启抽屉
  void offsetDistanceOpen({bool isCallBack = true}) {
    ///性能优化 当抽屉为关闭状态时再开启
    if (!isOpen) {
      ///不设置抽屉的偏移
      double end = 0;

      ///从当前的位置开始
      double start = offsetDistance;

      ///执行动画 从当前抽屉的偏移位置 过渡到0
      ///偏移量为0时，抽屉完全显示出来，呈打开状态
      offsetDistanceFunction(start, end, isCallBack);
    }
  }

  ///关闭抽屉
  void offsetDistanceClose({bool isCallBack = true}) {
    ///性能优化 当抽屉为打开状态时再关闭
    if (isOpen) {
      ///将抽屉移动到底部
      double end = maxChildSize - initialChildSize;

      ///从当前的位置开始
      double start = offsetDistance;

      ///执行动画过渡操作
      offsetDistanceFunction(start, end, isCallBack);
    }
  }

  ///lib/code15/drag/drag_container.dart
  ///动画滚动操作
  ///[start]开始滚动的位置
  ///[end]滚动结束的位置
  ///[isCallBack]是否触发状态回调
  void offsetDistanceFunction(double start, double end, bool isCallBack) {
    ///判断抽屉是否打开
    if (end == 0.0) {
      ///当无偏移量时 抽屉是打开状态
      isOpen = true;
    } else {
      ///当有偏移量时 抽屉是关闭状态
      isOpen = false;
    }

    ///抽屉状态回调
    ///当调用 dragController 的open与close方法
    ///来触发时不使用回调
    if (widget.dragCallBack != null && isCallBack) {
      widget.dragCallBack(isOpen);
    }
    // print(" start $start  end $end");

    ///动画插值器
    ///easeOut 先快后慢
    CurvedAnimation curve =
        new CurvedAnimation(parent: animalController, curve: Curves.easeOut);

    ///动画变化满园
    animation = Tween(begin: start, end: end).animate(curve)
      ..addListener(() {
        offsetDistance = animation.value;
        if (mounted) {
          setState(() {});
        }
      });

    ///开启动画
    animalController.reset();
    animalController.forward();
  }

  ///lib/code15/drag/drag_container.dart
  ///构建小标题横线
  Widget buildHeader() {
    ///根据配置来决定是否构建标题
    if (widget.isShowHeader) {
      return Row(
        ///居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (isOpen) {
                offsetDistanceClose();
              } else {
                offsetDistanceOpen();
              }
              if (mounted) {
                setState(() {});
              }
            },
            child: Container(
              width: size.width * 200,
              height: size.width * 40,
              //设置背景图片
              decoration: BoxDecoration(
                  color: Color(0xffFF943D),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(size.width * 20))),
              child: Image.asset(
                isOpen
                    ? 'assets/images/doubleRiskProjeck/keyboard_arrow_down.png'
                    : 'assets/images/doubleRiskProjeck/keyboard_arrow_up.png',
                width: size.width * 40,
                height: size.width * 40,
              ),
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  ///lib/code15/drag/drag_container.dart
  ///手势识别
  GestureRecognizerFactoryWithHandlers<CustomVerticalDragGestureRecognizer>
      getRecognizer() {
    ///手势识别器工厂
    return GestureRecognizerFactoryWithHandlers<
            CustomVerticalDragGestureRecognizer>(

        ///参数一 自定义手势识别
        buildCustomGecognizer,

        ///参数二 手势识别回调
        buildCustomGecognizer2);
  }

  ///创建自定义手势识别
  CustomVerticalDragGestureRecognizer buildCustomGecognizer() {
    return CustomVerticalDragGestureRecognizer(filingListener: (bool isFiling) {
      ///滑动结束的回调
      ///为true 表示是轻扫手势
      this.isFiling = isFiling;
      // print("isFling $isFiling");
    });
  }

  ///手势识别回调
  buildCustomGecognizer2(
      CustomVerticalDragGestureRecognizer gestureRecognizer) {
    ///手势回调监听
    gestureRecognizer

      ///开始拖动回调
      ..onStart = _handleDragStart

      ///拖动中的回调
      ..onUpdate = _handleDragUpdate

      ///拖动结束的回调
      ..onEnd = _handleDragEnd;
  }

  ///手指开始拖动时
  void _handleDragStart(DragStartDetails details) {
    ///更新标识为普通滑动
    isFiling = false;
  }

  ///手势拖动抽屉时移动抽屉的位置
  void _handleDragUpdate(DragUpdateDetails details) {
    ///偏移量累加
    offsetDistance = offsetDistance + details.delta.dy;
    if (mounted) {
      setState(() {});
    }
  }

  ///当拖拽结束时调用
  void _handleDragEnd(DragEndDetails details) {
    ///当快速滑动时[isFiling]为true
    if (isFiling) {
      ///当前抽屉是关闭状态时打开
      if (!isOpen) {
        ///向上
        offsetDistanceOpen();
      } else {
        ///当前抽屉是打开状态时关闭
        ///向下
        offsetDistanceClose();
      }
    } else {
      ///可滚动范围中再开启动画
      if (offsetDistance > 0) {
        ///这个判断通过，说明已经child位置超过警戒线了，需要滚动到顶部了
        if (offsetDistance < widget.maxOffsetDistance) {
          ///向上
          offsetDistanceOpen();
        } else {
          ///向下
          offsetDistanceClose();
        }
        // print(
        //     "${MediaQuery.of(context).size.height} widget.maxOffsetDistance ${widget.maxOffsetDistance} widget.maxChildSize $maxChildSize  widget.initialChildSize $initialChildSize");
      }
    }
  }
}
