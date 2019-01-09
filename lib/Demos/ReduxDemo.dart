import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReduxDemo extends StatefulWidget {
  ReduxDemo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ReduxDemoState createState() => new _ReduxDemoState();
}

class _ReduxDemoState extends State<ReduxDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}