import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/webRtc/signaling.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Callview extends StatefulWidget {
  final PeopleStructure data;
  final bool state;
  final String self;
  Callview({Key key, @required this.data, this.state = false, this.self})
      : super(key: key);
  @override
  _CallviewState createState() => _CallviewState();
}

class _CallviewState extends State<Callview> {
  @override
  void initState() {
    super.initState();
  }

  bool _inCalling = false;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff231B12),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff334d85), Color(0xff23262d)]),
        ),
        child: Stack(
          children: [
            !_inCalling
                ? Center(
                    child: HeadImg(url: widget.data.photoUrl),
                  )
                : Container(
                    child: Stack(children: <Widget>[
                      Positioned(
                          left: 0.0,
                          top: 0.0,
                          child: Container(
                              color: Colors.red,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: RTCVideoView(_remoteRenderer))),
                      Positioned(
                        left: 20.0,
                        top: 20.0,
                        child: Container(
                          width: 90.0,
                          height: 120,
                          child: RTCVideoView(_localRenderer),
                        ),
                      ),
                    ]),
                  ),
            Positioned(
                bottom: 0,
                child: StateClick(
                    widget.data.name, widget.state, widget.data.account,
                    self: widget.self,
                    remoteRenderer: _remoteRenderer,
                    localRenderer: _localRenderer,
                    inCalling: _inCalling, changeIncall: (bool call) {
                  if (!call) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _inCalling = call;
                    });
                  }
                }))
          ],
        ),
      ),
    );
  }
}

class HeadImg extends StatefulWidget {
  HeadImg({this.url});
  final String url;
  @override
  _HeadImgState createState() => _HeadImgState();
}

class _HeadImgState extends State<HeadImg> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _opacity = Tween(begin: 0.0, end: 20.0).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(_opacity.value),
          decoration: BoxDecoration(
              border: Border.all(
                color: themeColor.withOpacity(1 - _animationController.value),
                width: 1,
              ),
              shape: BoxShape.circle),
          child: Container(
            padding: EdgeInsets.all(size.width * 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3), shape: BoxShape.circle),
            child: ClipOval(
                child: Image.network(
              widget.url,
              width: size.width * 200,
              fit: BoxFit.cover,
            )),
          ),
        );
      },
    );
  }
}

class StateClick extends StatefulWidget {
  StateClick(this.name, this.state, this.account,
      {this.self,
      this.localRenderer,
      this.remoteRenderer,
      @required this.inCalling,
      this.changeIncall});
  final String name, account, self;
  final bool state, inCalling;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final Function(bool _bool) changeIncall;
  @override
  _StateClickState createState() => _StateClickState();
}

class _StateClickState extends State<StateClick> {
  String serverIP = 'lyco.18000541860.com';
  // String serverIP = 'demo.cloudwebrtc.com';
  Signaling _signaling;
  var _selfId;
  List peer = [];
  Map remotePeer = {};
  bool init = false;
  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
  }

  @override
  deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
    widget.localRenderer.dispose();
    widget.remoteRenderer.dispose();
  }

  _invitePeer(String peerId, bool useScreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', useScreen);
    }
  }

  void _connect() async {
    if (_signaling == null) {
      _signaling = Signaling(serverIP)..connect();
      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            widget.changeIncall(true);
            break;
          case SignalingState.CallStateBye:
            this.setState(() {
              widget.localRenderer.srcObject = null;
              widget.remoteRenderer.srcObject = null;
              widget.changeIncall(false);
            });
            break;
          case SignalingState.CallStateInvite:
          case SignalingState.CallStateConnected:
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
            Navigator.pop(context);
            break;
          case SignalingState.ConnectionError:
          case SignalingState.ConnectionOpen:
            break;
        }
      };

      _signaling.onPeersUpdate = ((event) {
        // this.setState(() {
        _selfId = event['self'];
        peer = event['peers'];
        // });
        if (widget.state) {
          peer.forEach((element) {
            if (element['id'] == widget.self) {
              remotePeer = element;
            }
          });
        }

        if (!init && !widget.state) {
          init = true;
          myDio.request(type: 'post', url: Interface.postActivePush, data: {
            "account": ['${widget.account}'],
            "title":
                '待办项:视频:${myprefs.getString('username')}:${myprefs.getString('account')}' ??
                    '标题',
            "content": '来自${myprefs.getString('username')}的通信:$_selfId'
          }).then((value) {});
        }
      });

      _signaling.onLocalStream = ((stream) {
        widget.localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        widget.remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        widget.remoteRenderer.srcObject = null;
      });
    }
  }

  _hangUp() {
    if (_signaling != null && widget.remoteRenderer.srcObject != null) {
      _signaling.bye();
    } else {
      Navigator.pop(context);
    }
  }

  initRenderers() async {
    await widget.localRenderer.initialize();
    await widget.remoteRenderer.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            widget.state
                ? '来自 ${widget.name ?? ''} 的来电'
                : '正在等待 ${widget.name ?? ''} 接听',
            style: TextStyle(color: Colors.white, fontSize: size.width * 28),
          ),
          SizedBox(height: size.width * 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: _hangUp,
                    child: Container(
                        padding: EdgeInsets.all(size.width * 20),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Icon(Icons.call_end,
                            size: size.width * 50, color: Colors.white)),
                  ),
                  SizedBox(height: size.width * 30),
                  Text('取消', style: TextStyle(color: Colors.white))
                ],
              ),
              !widget.inCalling && widget.state
                  ? SizedBox(width: size.width * 50)
                  : Container(),
              !widget.inCalling && widget.state
                  ? Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (remotePeer.isNotEmpty) {
                              _invitePeer(remotePeer['id'], false);
                              widget.changeIncall(true);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(size.width * 20),
                              decoration: BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                              child: Icon(Icons.call,
                                  size: size.width * 50, color: Colors.white)),
                        ),
                        SizedBox(height: size.width * 30),
                        Text('接听', style: TextStyle(color: Colors.white))
                      ],
                    )
                  : Container()
            ],
          )
        ]));
  }
}
