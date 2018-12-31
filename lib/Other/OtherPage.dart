import 'package:flutter/material.dart';
import 'package:morin/Candles/CandlesPage.dart';
import 'package:morin/Account/LoginPage.dart';
import 'package:morin/Index/IndexPage.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:morin/Constants/Constants.dart';

enum ActionItems {
  GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP
}

class OtherPage extends StatefulWidget {
  OtherPage({Key key, this.title}) : super(key: key);

  final String title;

  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
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

  void _index() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new IndexPage(title: "INDEX")));
  }

  void _i18n() {
    setState(() {
      currentLang = currentLang == 'en' ? 'zh' : 'en';
    });
  }

   _buildPopupMunuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(IconData(
          iconName,
          fontFamily: Constants.IconFontFamily,
        ), size: 22.0, color: const Color(AppColors.AppBarPopupMenuColor)),
        Container(width: 12.0),
        Text(title, style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor))),
      ],
    );
  }

  Widget _appBar(BuildContext context){
    return AppBar(
        title: Text('Morin'),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(IconData(
              0xe65e,
              fontFamily: Constants.IconFontFamily,
            ), size: 22.0),
            onPressed: () { print('点击了搜索按钮'); },
          ),
          Container(width: 16.0),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe69e, "发起群聊"),
                  value: ActionItems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe638, "添加朋友"),
                  value: ActionItems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe61b, "扫一扫"),
                  value: ActionItems.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe62a, "收付款"),
                  value: ActionItems.PAYMENT,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe63d, "帮助与反馈"),
                  value: ActionItems.HELP,
                ),
              ];
            },
            icon: Icon(IconData(
              0xe658,
              fontFamily: Constants.IconFontFamily,
            ), size: 22.0),
            onSelected: (ActionItems selected) { print('点击的是$selected'); },
          ),
          Container(width: 16.0),
        ],
      );
  }

  Widget _body(BuildContext context) {
return new Padding(
      padding: const EdgeInsets.all(5.0),
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
                new RaisedButton(
                  child: Text("INDEX"),
                  onPressed: _index,
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar(context),
      body: _body(context),
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
