import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

Map<String, IOWebSocketChannel> ws = {};

class MarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarketPageState();
  }
}

class MarketPageState extends State<MarketPage> {
  MarketPageState({Key key, this.title}) : super();
  final String title;
//  List<CoinSymbol> symbols = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text(
              '行情',
              textAlign: TextAlign.left,
            ),
            bottom: new TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
//                  icon: new Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(0.0),
                child: new ChoicePage(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '自选', icon: Icons.directions_car),
  const Choice(title: 'USDT', icon: Icons.directions_bike),
  const Choice(title: 'BTC', icon: Icons.directions_boat),
  const Choice(title: 'ETH', icon: Icons.directions_bus),
  const Choice(title: 'HT', icon: Icons.directions_railway),
];

class ChoicePage extends StatefulWidget {
  final Choice choice;
  ChoicePage({Key key, this.choice}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChoicePageItem();
  }
}

class ChoicePageItem extends State<ChoicePage> {
//  final String title;
//  List<CoinSymbol> symbols = [];
  List coins = [];
  @override
  void initState() {
    super.initState();
    initSocketData();
  }

//}
//class ChoicePageItem extends StatelessWidget {
//  const ChoicePageItem({Key key, this.choice}) : super(key: key);

  getItem(int position) {
    if (position == 0) {
      return TopWidget();
    } else {
      return getListViewItem(position);
    }
  }

  getListViewItem(int position) {
    double percent = ((coins[position]['close'] - coins[position]['open']) *
        100 /
        coins[position]['open']);
    var percentString = percent.toStringAsFixed(2);
    String coinName = coins[position]['symbol'];
    String vol = coins[position]['amount'].toStringAsFixed(0);
    String price = coins[position]['close'].toString();
    return new GestureDetector(
      child: new Container(
        height: 60,
        child: new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //纵向对齐方式：起始边对齐
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          (coinName.toUpperCase()),
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        alignment: FractionalOffset.topCenter,
                      ),
                      new Container(
                        child: new Text(
                          '24h $vol',
                          style: new TextStyle(
                              fontSize: 12.0, color: Colors.black38),
                        ),
                        alignment: FractionalOffset.bottomCenter,
                      )
                    ],
                  ),
                ),
                flex: 3,
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //纵向对齐方式：起始边对齐
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        ('$price'),
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      alignment: FractionalOffset.topCenter,
                    ),
                    new Container(
                      child: new Text(
                        '￥4122.00',
                        style: new TextStyle(
                            fontSize: 12.0, color: Colors.black38),
                      ),
                      alignment: FractionalOffset.bottomCenter,
                    )
                  ],
                ),
                flex: 3,
              ),
              new Expanded(
                child: new Container(
                  color: Colors.red,
                  child: new Text(
                    ('$percentString%'),
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  alignment: FractionalOffset.center,
                  padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                ),
                flex: 2,
              )
            ],
          ),
        ),
      ),
      onTap: () {
//      onItimeClick('11');
      },
    );
  }

  getListView() {
    return ListView.builder(
      itemCount: coins.length + 1,
      itemBuilder: (BuildContext context, int position) {
        return getItem(position);
      },
      physics: new AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  getBody() {
    return new Container(
      child: getListView(),
    );
  }

  TopWidget() {
    return new Container(
      height: 30.0,
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Text(
                  "名称",
                  style: new TextStyle(fontSize: 14.0, color: Colors.black26),
                ),
                alignment: FractionalOffset.center,
              ),
              flex: 8,
            ),
            new Expanded(
              child: new Container(
                child: new Text(
                  "最新价",
                  style: new TextStyle(fontSize: 14.0, color: Colors.black26),
                ),
                alignment: FractionalOffset.center,
              ),
              flex: 13,
            ),
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: new Text(
                  "涨跌幅",
                  style: new TextStyle(fontSize: 14.0, color: Colors.black26),
                ),
                alignment: FractionalOffset.center,
              ),
              flex: 9,
            ),
          ],
        ),
      ),
    );
  }

  void initSocketData() async {
    /*
    final channel = await IOWebSocketChannel.connect("wss://api-cloud.huobi.co.kr/ws");
    channel.stream
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
    ws['hq'] = channel;
    sendMsg('{"sub":"market.overview"}');
    */
  }

  void onData(message) {
    /*
    String msg = String.fromCharCodes(GZipDecoder().decodeBytes(message));
    Map<String, dynamic> j = json.decode(msg);
    if (j != null && j.containsKey("ping")) {
      sendMsg(json.encode({"pong": j['ping']}));
    } else {
      onReceiveMsg(j);
    }
    */
  }

  void onError(error, StackTrace stackTrace) {}

  void onDone() {}

  void closeWs() {
    ws['hq'].sink.close(status.goingAway);
  }

  void onReceiveMsg(Map<String, dynamic> msg) {
    //TODO
//    List coinList = msg['data'];
    coins = msg['data'];
    print(coins);
//    for (int i = 0; i< (coinList.length -1);i++) {
//      CoinSymbol coin = CoinSymbol.fromJson(coinList[i]);
//      symbols.add(coin);
//    }
    setState(() {
//    print(symbols);
    });
  }

  void sendMsg(msg) {
    //ws['hq'].sink.add(msg);
  }

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Container(color: Colors.white, child: getBody());
  }
}
