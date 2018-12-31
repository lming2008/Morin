import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final String title;

  Page({
    Key key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child: Text(title),
          color: Colors.yellow,
        ));
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Container(
        child: Text(
          "Hello world",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              height: 1.2,
              fontFamily: "Courier",
              background: new Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
      ),
    );
  }
}

class TextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              "Hello world",
              textAlign: TextAlign.center,
            ),
            Text(
              "Hello world! I'm Jack. " * 6,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Hello world",
              textScaleFactor: 5,
            ),
            RaisedButton(
              child: Text("RaisedButton"),
              onPressed: () => {},
            ),
            FlatButton(
              child: Text("FlatButton"),
              onPressed: () => {},
            ),
            OutlineButton(
              child: Text("OutlineButton"),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => {},
            ),
            FlatButton(
              color: Colors.lightBlue,
              highlightColor: Colors.blue,
              colorBrightness: Brightness.dark,
              splashColor: Colors.yellow,
              child: Text("确定"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () => {},
            ),
            Image.network(
              "https://www.baidu.com/img/qxinshouye_a5df87f73cde439ec5d07aeb94e7db72.png",
              width: 300.0,
              height: 50.0,
              repeat: ImageRepeat.repeatX,
            ),
            Text(
              'text',
              style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}