import 'package:flutter/material.dart';
import 'package:web_controller/web_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebControllerInterface _webControllerInterface =
      WebControllerInterface(callback: (String type, {String value}) => {});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff364547),
      body: Column(
        children: [
          Expanded(
            child: WebControllerBase(
              controllerInterface: _webControllerInterface,
            ),
          ),

          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(image: AssetImage(''))
          //   ),
          // )
        ],
      ),
    );
  }
}
