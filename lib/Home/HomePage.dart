import 'package:flutter/material.dart';
import 'package:morin/Candles/CandlesPage.dart';
import 'package:morin/Account/LoginPage.dart';
import 'package:morin/Index/IndexPage.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);

  final String title;


  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  bool _switchSelected = true;
  bool _checkboxSelected = false;

  String currentLang = 'zh';
  int clicked = 0;

  incrementCounter() {
    setState(() {
      clicked++;
    });
  }

  void _toggleFavorite() {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        // Otherwise, favorite it.
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  void _openCandles() {
    //跳转
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CandlesPage(title: "title")));
  }

  void _login() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new LoginFormTestRoute(title: "title")));
  }

  void _i18n() {
    setState(() {
      currentLang = currentLang == 'en' ? 'zh' : 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 50,left: 5.0,right: 5.0),
      child: new Column(
        //测试Row对齐方式，排除Column默认居中对齐的干扰
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            alignment: new Alignment(0, 0),
            padding: new EdgeInsets.all(10.0),
            color: Colors.green,
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Container(
                  color: Colors.red,
                  padding: new EdgeInsets.all(0.0),
                  child: new IconButton(
                    icon: (_isFavorited
                        ? new Icon(Icons.star)
                        : new Icon(Icons.star_border)),
                    color: Colors.red[500],
                    onPressed: _toggleFavorite,
                  ),
                ),
                new SizedBox(
                  width: 18.0,
                  child: new Container(
                    child: new Text('$_favoriteCount'),
                    color: Colors.blue,
                  ),
                ),
                new FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("K线"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: _openCandles,
                ),
                new OutlineButton(
                  child: Text("登录"),
                  onPressed: _login,
                ),
              ],
            ),
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image(
                  image: AssetImage("assets/images/ic_file_transfer.png"),
                  width: 50.0),
              new Image.network(
                "https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/image-20180829163427556.png",
                width: 50.0,
              ),
              new Checkbox(
                value: _checkboxSelected,
                activeColor: Colors.red, //选中时的颜色
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value;
                  });
                },
              ),
              new IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () => {},
              ),
              new Switch(
                value: _switchSelected, //当前状态
                onChanged: (value) {
                  //重新构建页面
                  setState(() {
                    _switchSelected = value;
                  });
                },
              ),
              new FlatButton(
                  onPressed: () async {
                    _i18n();
                    await FlutterI18n.refresh(context, currentLang);
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text(
                          FlutterI18n.translate(context, "toastMessage")),
                    ));
                  },
                  child: new Text(
                      FlutterI18n.translate(context, "button.clickMe")))
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> list = <Widget>[
  new ListTile(
    title: new Text('CineArts at the Empire',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('85 W Portal Ave'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  new ListTile(
    title: new Text('The Castro Theater',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('429 Castro St'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  // ...
  // See the rest of the column defined on GitHub:
  // https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/listview/main.dart
];
