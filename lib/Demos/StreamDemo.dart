import 'dart:async';

import 'package:flutter/material.dart';

class StreamDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamDemoHome(),
    );
  }
}

class StreamDemoHome extends StatefulWidget {
  _StreamDemoHomeState createState() => _StreamDemoHomeState();
}

class _StreamDemoHomeState extends State<StreamDemoHome> {
  StreamSubscription _streamDemoSubscriptionA;
  StreamSubscription _streamDemoSubscriptionB;
  StreamController<String> _streamDemoController;
  StreamSink _sinkDemo;
  String _data = '...';

  @override
  void dispose() {
    super.dispose();

    _streamDemoController.close();
  }

  @override
  void initState() {
    super.initState();

    //Stream<String> _streamDemo = Stream.fromFuture(fetchData());

    // _streamDemoController = StreamController<String>();
    // _streamDemoSubscription =  _streamDemoController.stream.listen(onData, onError: onError,onDone: onDone);

    //创建可以多个订阅的 broadcast
    _streamDemoController = StreamController.broadcast();
    //第一次订阅
    _streamDemoController.stream
        .listen(onDataA, onError: onErrorA, onDone: onDoneA);

    //第二次订阅
    _streamDemoController.stream
        .listen(onDataB, onError: onErrorB, onDone: onDoneB);

    _streamDemoSubscriptionB = _streamDemoController.stream
                          .where((value) => (value == 'hello1'))
                          .listen((value) => print('subscription B $value'));

    _sinkDemo = _streamDemoController.sink;
  }

  Future<String> fetchData() async {
    //延迟3秒钟
    await Future.delayed(Duration(seconds: 2));

    return 'hello';
    //throw 'something error ';
  }

  //第一次订阅处理
  void onDataA(String data) {
    print('A:$data');

    //这里用来修改_data状态值
    setState(() {
          _data = data;
        });
  }

  void onErrorA(error) {
    print('A Error: $error');
  }

  void onDoneA() {
    print('A done');
  }

  //第二次订阅处理
  void onDataB(String data) {
    print('B:$data');
  }

  void onErrorB(error) {
    print('B Error: $error');
  }

  void onDoneB() {
    print('B done');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('$_data'),
            StreamBuilder(
              stream: _streamDemoController.stream,
              //设置初始值
              initialData: '...',
              builder: (context,snapshot){
                return Text('${snapshot.data}');
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Add'),
                  onPressed: () async {
                    String data = await fetchData();
                    // _streamDemoController.add(data);
                    //这里使用sink添加数据
                    _sinkDemo.add(data);
                  },
                ),
                FlatButton(
                  child: Text('Pause'),
                  onPressed: () {
                    _streamDemoSubscriptionA.pause();
                    print('pause');
                  },
                ),
                FlatButton(
                  child: Text('Resume'),
                  onPressed: () {
                    _streamDemoSubscriptionA.resume();
                    print('resume');
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    _streamDemoSubscriptionA.cancel();
                    print('cancel');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
