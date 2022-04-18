library web_controller;

import 'package:flutter/material.dart';

class WebControllerInterface {
  exit() {
    callback('exit');
  }

  back() {
    callback('back');
  }

  determine() {
    callback('determine');
  }

  focuUp() {
    callback('focuUp');
  }

  focuDown() {
    callback('focuDown');
  }

  focuLeft() {
    callback('focuLeft');
  }

  focuRight() {
    callback('focuRight');
  }

  home() {
    callback('home');
  }

  fullScreen() {
    callback('fullScreen');
  }

  menu() {
    callback('menu');
  }

  // ++
  addVoice() {
    callback('addVoice');
  }

  // --
  subtractionVoice() {
    callback('subtractionVoice');
  }

  videoLeft() {
    callback('videoLeft');
  }

  videoRight() {
    callback('videoRight');
  }

  videoPause() {
    callback('videoPause');
  }

  getFocus() {
    callback('getFocus');
  }

  sendKey(String str) {
    callback('sendKey', value: str);
  }

  faceRegister() {
    callback('faceRegister');
  }

  toogleFace(){
    callback('toogleFace');
  }

  Function(String type, {String value}) callback;
  WebControllerInterface({this.callback});
}

class WebControllerBase extends StatefulWidget {
  final Color background;
  final WebControllerInterface controllerInterface;
  const WebControllerBase(
      {Key key,
      this.background = const Color(0xff364547),
      @required this.controllerInterface})
      : super(key: key);
  @override
  _WebControllerBaseState createState() => _WebControllerBaseState();
}

class _WebControllerBaseState extends State<WebControllerBase> {
  String str = "";
  TextEditingController _textEditingController = TextEditingController();

  List<CommonButton> top1 = [];
  List<CommonButton> top2 = [];

  List<CommonButton> top4 = [];

  CommonButton top5;
  CommonButton top6, top7;
  @override
  void initState() {
    super.initState();
    top1 = [
      CommonButton(
        child: CommonButtonType(
          callback: [
            () {
              widget.controllerInterface.home();
            }
          ],
          bg: Image.asset(
            'image/squareBg.png',
            package: 'web_controller',
            width: 83,
            height: 83,
          ),
          embed: [
            Icon(
              Icons.home,
              size: 40,
              color: Colors.white54,
            )
          ],
          embedToggle: [
            Icon(
              Icons.home,
              size: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
      CommonButton(
        child: CommonButtonType(
          callback: [
            () {
              widget.controllerInterface.fullScreen();
            }
          ],
          bg: Image.asset(
            'image/squareBg.png',
            package: 'web_controller',
            width: 83,
            height: 83,
          ),
          embed: [
            Icon(
              Icons.tv,
              size: 40,
              color: Colors.white54,
            )
          ],
          embedToggle: [
            Icon(
              Icons.tv,
              size: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
      CommonButton(
        child: CommonButtonType(
          callback: [
            () {
              widget.controllerInterface.menu();
            }
          ],
          bg: Image.asset(
            'image/squareBg.png',
            package: 'web_controller',
            width: 83,
            height: 83,
          ),
          embed: [
            Icon(
              Icons.menu,
              size: 40,
              color: Colors.white54,
            )
          ],
          embedToggle: [
            Icon(
              Icons.menu,
              size: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
    ];
    top2 = [
      CommonButton(
          child: CommonButtonType(
        callback: [
          () {
            // print('asd');
            widget.controllerInterface.exit();
          }
        ],
        bg: Image.asset(
          'image/radioBg.png',
          package: 'web_controller',
          width: 40,
          height: 40,
        ),
        embed: [
          Icon(
            Icons.adjust,
            size: 20,
            color: Colors.white54,
          )
        ],
        embedToggle: [
          Icon(
            Icons.adjust,
            size: 20,
            color: Colors.white,
          )
        ],
      )),
      CommonButton(
          child: CommonButtonType(
        callback: [
          () {
            widget.controllerInterface.back();
          }
        ],
        bg: Image.asset(
          'image/radioBg.png',
          package: 'web_controller',
          width: 40,
          height: 40,
        ),
        embed: [
          Icon(
            Icons.reply,
            size: 20,
            color: Colors.white54,
          )
        ],
        embedToggle: [
          Icon(
            Icons.reply,
            size: 20,
            color: Colors.white,
          )
        ],
      )),
    ];

    top4 = [
      CommonButton(
          child: CommonButtonType(
        callback: [
          () {
            widget.controllerInterface.videoLeft();
          },
          () {
            widget.controllerInterface.videoPause();
          },
          () {
            widget.controllerInterface.videoRight();
          }
        ],
        bg: Image.asset(
          'image/floatBg.png',
          package: 'web_controller',
          width: 150,
          height: 40,
        ),
        embed: [
          Icon(
            Icons.fast_rewind,
            size: 20,
            color: Colors.white54,
          ),
          Icon(
            Icons.play_arrow,
            size: 20,
            color: Colors.white54,
          ),
          Icon(
            Icons.fast_forward,
            size: 20,
            color: Colors.white54,
          ),
        ],
        embedToggle: [
          Icon(
            Icons.fast_rewind,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.play_arrow,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.fast_forward,
            size: 20,
            color: Colors.white,
          ),
        ],
      )),
      CommonButton(
          child: CommonButtonType(
        callback: [
          () {
            widget.controllerInterface.addVoice();
          },
          () {
            widget.controllerInterface.subtractionVoice();
          }
        ],
        bg: Image.asset(
          'image/floatBg.png',
          package: 'web_controller',
          width: 150,
          height: 40,
        ),
        embed: [
          Row(
            children: [
              Text('音量', style: TextStyle(color: Colors.white54)),
              Icon(
                Icons.add,
                size: 20,
                color: Colors.white54,
              )
            ],
          ),
          Row(
            children: [
              Text('音量', style: TextStyle(color: Colors.white54)),
              Icon(
                Icons.horizontal_rule,
                size: 20,
                color: Colors.white54,
              )
            ],
          )
        ],
        embedToggle: [
          Row(
            children: [
              Text('音量', style: TextStyle(color: Colors.white)),
              Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              )
            ],
          ),
          Row(
            children: [
              Text('音量', style: TextStyle(color: Colors.white)),
              Icon(
                Icons.horizontal_rule,
                size: 20,
                color: Colors.white,
              )
            ],
          )
        ],
      ))
    ];
    top5 = CommonButton(
        child: CommonButtonType(
      callback: [
        () {
          widget.controllerInterface.sendKey(_textEditingController.text);
          _textEditingController.text = '';
        }
      ],
      bg: Image.asset(
        'image/radioBg.png',
        package: 'web_controller',
        width: 40,
        height: 40,
      ),
      embed: [
        Icon(
          Icons.search,
          size: 20,
          color: Colors.white54,
        )
      ],
      embedToggle: [
        Icon(
          Icons.search,
          size: 20,
          color: Colors.white,
        )
      ],
    ));
    top6 = CommonButton(
        child: CommonButtonType(
      callback: [
        () {
          widget.controllerInterface.faceRegister();
        }
      ],
      bg: Image.asset(
        'image/radioBg.png',
        package: 'web_controller',
        width: 40,
        height: 40,
      ),
      embed: [
        Icon(
          Icons.face,
          size: 20,
          color: Colors.white54,
        )
      ],
      embedToggle: [
        Icon(
          Icons.face,
          size: 20,
          color: Colors.white,
        )
      ],
    ));
    top7 = CommonButton(
        child: CommonButtonType(
      callback: [
        () {
          widget.controllerInterface.toogleFace();
        }
      ],
      bg: Image.asset(
        'image/radioBg.png',
        package: 'web_controller',
        width: 40,
        height: 40,
      ),
      embed: [
        Icon(
          Icons.toggle_on,
          size: 20,
          color: Colors.white54,
        )
      ],
      embedToggle: [
        Icon(
          Icons.toggle_on,
          size: 20,
          color: Colors.white,
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    AssetImage('image/bj@2x.png', package: 'web_controller'))),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text('清单制信息化投屏系统',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: top1.map((e) => e).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: top2.map((e) => e).toList(),
              ),
              Stack(
                children: [
                  Image.asset(
                    'image/determine@2x.png',
                    package: 'web_controller',
                    width: 280,
                    height: 280,
                  ),
                  Positioned(
                    left: 115,
                    top: 12,
                    child: InkWell(
                      onTap: () {
                        widget.controllerInterface.focuUp();
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white54,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                      left: 11,
                      top: 115,
                      child: InkWell(
                        onTap: () {
                          widget.controllerInterface.focuLeft();
                        },
                        child: Icon(Icons.keyboard_arrow_left,
                            color: Colors.white54, size: 50),
                      )),
                  Positioned(
                    bottom: 12,
                    left: 115,
                    child: InkWell(
                      onTap: () {
                        widget.controllerInterface.focuDown();
                      },
                      child: Icon(Icons.keyboard_arrow_down,
                          color: Colors.white54, size: 50),
                    ),
                  ),
                  Positioned(
                    right: 11,
                    top: 115,
                    child: InkWell(
                      onTap: () {
                        widget.controllerInterface.focuRight();
                      },
                      child: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white54, size: 50),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 120,
                    child: InkWell(
                      onTap: () {
                        widget.controllerInterface.determine();
                      },
                      child: Center(
                        child: Text(
                          '确定',
                          style: TextStyle(color: Colors.white54, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: top4.map((e) => e).toList(),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      child: TextField(
                        controller: _textEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20)),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('image/inputBg.png',
                                  package: 'web_controller'))),
                    ),
                  ),
                  top5
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [top6, top7],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonButtonType {
  final Widget bg;
  final List<Widget> embed;
  List<Widget> embedToggle = [];
  List<Function> callback = [];
  List<bool> click = [];
  CommonButtonType({
    @required this.bg,
    @required this.embed,
    List<Widget> embedToggle,
    List<Function> callback,
  }) {
    int length = this.embed.length;

    for (var i = 0; i < length; i++) {
      if (i > embedToggle.length - 1) {
        this.embedToggle.add(Container());
      } else {
        this.embedToggle.add(embedToggle[i]);
      }
    }
    if (callback is List) {
      for (var i = 0; i < length; i++) {
        if (i > callback.length - 1) {
          this.callback.add(() {});
        } else {
          this.callback.add(callback[i]);
        }
      }
    }

    this.callback.forEach((element) {
      this.click.add(false);
    });
  }
}

class CommonButton extends StatefulWidget {
  final CommonButtonType child;
  CommonButton({@required this.child});
  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  double widthScreen = 0.0;
  double heightScreen = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widthScreen = context.size.width;
      heightScreen = context.size.height;
      setState(() {});
    });
    widget.child.callback.forEach((element) {
      lock.add(false);
    });
  }

  double _opacity = 1;
  List<bool> lock = [];
  _toogle(int i) {
    if (!lock[i]) {
      lock[i] = true;
      setState(() {
        widget.child.click[i] = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            _opacity = 0.5;
          });
          Future.delayed(Duration(milliseconds: 600), () {
            _opacity = 1;
            setState(() {
              widget.child.click[i] = false;
            });
            lock[i] = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.child.embed.length == 1) {
          widget.child.callback[0]();
          _toogle(0);
        }
      },
      child: Stack(
        children: [
          widget.child.bg,
          widthScreen > 0
              ? Positioned(
                  width: widthScreen,
                  height: heightScreen,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.child.embed
                        .asMap()
                        .keys
                        .map((i) => InkWell(
                              child: !widget.child.click[i]
                                  ? widget.child.embed[i]
                                  : AnimatedOpacity(
                                      opacity: _opacity,
                                      duration: Duration(milliseconds: 300),
                                      child: widget.child.embedToggle[i],
                                    ),
                              onTap: () {
                                widget.child.callback[i]();
                                _toogle(i);
                              },
                            ))
                        .toList(),
                  )),
                )
              : Container()
        ],
      ),
    );
  }
}
