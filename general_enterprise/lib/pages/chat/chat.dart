import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/chat/chatDataBase.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/eventBus.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatTemplate {
  final String identity, message, time;
  ChatTemplate(this.identity, {this.message = '', this.time = ''});
}

class MyChat extends StatefulWidget {
  MyChat({@required this.data});
  final PeopleStructure data;

  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  MethodChannel _channel = MethodChannel('messagePushChannel');
  BasicMessageChannel messageChannel =
      BasicMessageChannel('chat', StandardMessageCodec());
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _controller = ScrollController();

  List<ChatTemplate> data = [];
  // Counter _counter = Provider.of(myContext);
  @override
  void initState() {
    super.initState();
    EventBusUtils.getInstance().on<ChatEvent>().listen((event) {
      judgeData(event.message);
    });
    findHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  findHistory() {
    ChatData()
        .chatRecord(widget.data.account + '+' + myprefs.getString('account'))
        .then((value) {
      for (var i = value.length - 1; i > -1; i--) {
        if (value[i]['userID'] == widget.data.account) {
          data.add(ChatTemplate('other',
              message: value[i]['message'],
              time: value[i]['time'].toString().split(' ')[1].split('.')[0]));
        } else {
          data.add(ChatTemplate('own',
              message: value[i]['message'],
              time: value[i]['time'].toString().split(' ')[1].split('.')[0]));
        }
      }
      setState(() {});
    });
  }

  // 黄熙
  _send() {
    String value = _textEditingController.text;
    if (value == '') return;
    myDio.request(
        type: 'get',
        url: Interface.getChatStatus,
        queryParameters: {"userId": widget.data.id}).then((values) {
      if (values is Map) {
        if (values['onlineStatus'] == 0) {
          myDio.request(type: 'post', url: Interface.postActivePush, data: {
            "account": ['${widget.data.account}'],
            "title": '待办项:聊天:${myprefs.getString('username')}' ?? '标题',
            "content": value
          }).then((value) {});
        } else {}
      }
    });
    data.insert(
        0,
        ChatTemplate('own',
            message: value,
            time: DateTime.now()
                .toLocal()
                .toString()
                .split(' ')[1]
                .split('.')[0]));

    ChatData().assginData(AssChat(
      groups: widget.data.account + '+' + myprefs.getString('account'),
      message: value,
      userID: myprefs.getString('account'),
    ));
    _textEditingController.text = '';
    setState(() {});
    List<String> _list = [value, widget.data.account];
    _channel.invokeMethod('send', _list).then((value) {
      if (value is Map) {
        Fluttertoast.showToast(msg: value.toString());
      }
    });
  }

  judgeData(Map event) {
    if (event['userID'] == widget.data.account) {
      data.insert(
          0,
          ChatTemplate("other",
              message: event['message'],
              time: DateTime.now()
                  .toLocal()
                  .toString()
                  .split(' ')[1]
                  .split('.')[0]));
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        actions: [
          Container(
            margin: EdgeInsets.all(size.width * 15),
            child: Image.asset(
              'assets/images/videoCallICON@2x.png',
              width: size.width * 50,
              height: size.width * 43,
            ),
          )
        ],
        title: Text(widget.data.name.toString()),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ReveMsgItem(
                        data[index],
                        headImg: widget.data.photoUrl,
                      );
                    }),
              ),
            ),
            Row(
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 10, vertical: size.width * 22),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            right: BorderSide(
                          color: underColor.withOpacity(.4),
                        ))),
                    child: Icon(
                      Icons.add,
                      color: themeColor,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: _textEditingController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.width * 20),
                      hintText: '你可能想说点什么...',
                    ),
                  ),
                )),
                InkWell(
                  onTap: _send,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 30, vertical: size.width * 22),
                    decoration: BoxDecoration(color: themeColor),
                    child: Image.asset(
                      'assets/images/chatSendicon@2x.png',
                      width: 23.5,
                      height: 23.5,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class ReveMsgItem extends StatelessWidget {
  ReveMsgItem(this.data, {this.headImg});
  final ChatTemplate data;
  final String headImg;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          this.data.time,
          style: TextStyle(color: placeHolder),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            data.identity == 'other'
                ? Container(
                    margin: EdgeInsets.only(left: size.width * 16.5),
                    child: ClipOval(
                      child: Image.network(headImg,
                          fit: BoxFit.fill,
                          width: size.width * 80,
                          height: size.width * 80,
                          loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null)
                          return child;
                        else
                          return RefreshProgressIndicator();
                      }),
                    ),
                  )
                : Spacer(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: data.identity == 'other' ? Colors.white : themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: data.identity == 'other'
                        ? Radius.circular(2)
                        : Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomRight: data.identity == 'other'
                        ? Radius.circular(8)
                        : Radius.circular(2),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38.withOpacity(0.2),
                        offset: Offset(1, 5),
                        blurRadius: 10)
                  ]),
              margin: EdgeInsets.all(size.width * 10),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 20, vertical: size.width * 20),
              child: Text(
                data.message,
                style: TextStyle(
                    color:
                        data.identity == 'other' ? Colors.black : Colors.white),
              ),
            )),
            data.identity == 'other'
                ? Spacer()
                : Container(
                    child: ClipOval(
                      child: Image.network(myprefs.getString('photoUrl'),
                          fit: BoxFit.fill,
                          width: size.width * 80,
                          height: size.width * 80,
                          loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null)
                          return child;
                        else
                          return RefreshProgressIndicator();
                      }),
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
