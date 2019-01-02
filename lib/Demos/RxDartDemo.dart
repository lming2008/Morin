import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RxdartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rxdart Demo'),
        elevation: 0.0,
      ),
      body: RxdartDemoHome(),
    );
  }
}

class RxdartDemoHome extends StatefulWidget {
  _RxdartDemoHomeHomeState createState() => _RxdartDemoHomeHomeState();
}

class _RxdartDemoHomeHomeState extends State<RxdartDemoHome> {

  @override
    void initState() {
      super.initState();

      /*
      Observable<String> _observable = Observable(Stream.fromIterable(['hello','你好']));
      _observable.listen(print);
      */

      PublishSubject<String> _subject = PublishSubject<String>();
      _subject.listen((data)=>print('listen 1: $data'));
      _subject.add('hello');
      
      _subject.listen((data)=>print('listen 2: ${data.toUpperCase()}'));
      _subject.add('hola');
    }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Rxdart'),
    );
  }
}
