import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/chat/chatDataBase.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List data = [];
  @override
  void initState() {
    super.initState();
    _initList();
  }

  _initList() {
    ChatData().chatList().then((value) {
      data = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('聊天列表'),
      child: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => ScrollDelete(
                  onRemove: () async {
                    await ChatData().delete(data[index]);
                    data.removeAt(index);
                    setState(() {});
                  },
                  index: index,
                  data: data[index]))
          : Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: size.width * 300),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/empty@2x.png",
                    height: size.width * 288,
                    width: size.width * 374,
                  ),
                  Text('暂无数据'),
                ],
              )),
    );
  }
}

class ScrollDelete extends StatefulWidget {
  ScrollDelete({this.onRemove, this.data, this.index});
  final Function onRemove;
  final Map data;
  final int index;
  @override
  _ScrollDeleteState createState() => _ScrollDeleteState();
}

class _ScrollDeleteState extends State<ScrollDelete> {
  double startDrag = 0.0;
  double longWidth = 0.0;
  PeopleStructure data;
  @override
  void initState() {
    super.initState();
    _initDate();
  }

  _initDate() {
    PeopleStructure.getAccountPeople(widget.data['userID']).then((value) {
      data = value;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant ScrollDelete oldWidget) {
    super.didUpdateWidget(oldWidget);
    longWidth = 0.0;
    _initDate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (details) {
        longWidth = details.localPosition.dx - startDrag;
        setState(() {});
      },
      onHorizontalDragStart: (details) {
        startDrag = details.localPosition.dx;
        context.read<Counter>().assginChatListIndex(widget.index);
      },
      onTap: () {
        context.read<Counter>().assginChatListIndex(widget.index);
        Navigator.pushNamed(context, '/chat', arguments: {
          "data": data,
        }).then((value) {
          context
              .read<Counter>()
              .emptyNotity(name: '聊天', account: data.account);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            data != null
                ? Expanded(
                    child: Row(
                    children: [
                      Container(
                        width: size.width * 80,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/image_recent_control.jpg'),
                                image: NetworkImage(data.photoUrl),
                                width: size.width * 60,
                                height: size.width * 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            context.watch<Counter>().notity['聊天'] != null &&
                                    context.watch<Counter>().notity['聊天']
                                        [data.account] is List
                                ? Positioned(
                                    right: 8,
                                    top: -2,
                                    child: Container(
                                      margin: EdgeInsets.all(3),
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                    ))
                                : SizedBox(
                                    width: size.width * 20,
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: size.width * 120,
                        padding: EdgeInsets.only(
                            top: size.width * 20, bottom: size.width * 20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: underColor.withOpacity(.2), width: 1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name),
                            Text(
                              data.position,
                              style: TextStyle(
                                  color: placeHolder,
                                  fontSize: size.width * 20),
                            )
                          ],
                        ),
                      )),
                    ],
                  ))
                : Container(),
            context.watch<Counter>().chatListIndex == widget.index
                ? InkWell(
                    onTap: widget.onRemove,
                    child: Container(
                      height: size.width * 120,
                      constraints: BoxConstraints(maxWidth: 80),
                      width: longWidth > 0 ? 0 : longWidth.abs(),
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        '移除',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
