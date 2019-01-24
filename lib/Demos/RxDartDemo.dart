import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

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

    Observable<String> _observable =
        Observable(Stream.fromIterable(['hello', '你好']));
    _observable.listen(print);

    var _timerObservable = Observable.periodic(Duration(seconds: 1), (x) => x.toString() );
    _timerObservable.listen(print);
    
    PublishSubject<String> _subject = PublishSubject<String>();
    _subject.listen((data) => print('listen 1: $data'));
    _subject.add('hello');

    _subject.listen((data) => print('listen 2: ${data.toUpperCase()}'));
    _subject.add('hola');
  
  }

  @override
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Rxdart'),
    );
  }
}

class User {
  final String name;
  final String adress;
  final String phoneNumber;
  final int age;

  // In real projects I would recommend some 
  // serializer and not doing that manually
  factory User.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return User(
      jsonMap['name'],
      jsonMap['adress'],
      jsonMap['phoneNumber'],
      jsonMap['age'],
    );
  }

  User(this.name, this.adress, this.phoneNumber, this.age);

  @override
  String toString() {
    return '$name - $adress - $phoneNumber - $age';
  }
}