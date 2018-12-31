import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

///返回一个居中带图标和文本的Item
  _getBottomItem(IconData icon, String text) {
    ///充满 Row 横向的布局
    return new Expanded(
      flex: 1,
      ///居中显示
      child: new Center(
        ///横向布局
        child: new Row(
          ///主轴居中,即是横向居中
          mainAxisAlignment: MainAxisAlignment.center,
          ///大小按照最大充满
          mainAxisSize : MainAxisSize.max,
          ///竖向也居中
          crossAxisAlignment : CrossAxisAlignment.center,
          children: <Widget>[
            ///一个图标，大小16.0，灰色
            new Icon(
              icon,
              size: 16.0,
              color: Colors.grey,
            ),
            ///间隔
            new Padding(padding: new EdgeInsets.only(left:5.0)),
            ///显示文本
            new Text(
              text,
              //设置字体样式：颜色灰色，字体大小14.0
              style: new TextStyle(color: Colors.grey, fontSize: 14.0),
              //超过的省略为...显示
              overflow: TextOverflow.ellipsis,
              //最长一行
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        ///卡片包装
        child: new Card(

            ///增加点击效果
            child: new FlatButton(
                onPressed: () {
                  print("点击了哦");
                },
                child:new Column(
                    mainAxisSize: MainAxisSize.min,
                    
                    children: <Widget>[
                      ///文本描述
                      new Container(
                        color: Colors.blue,
                          child: new Text(
                            "这是标题",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 14.0,
                            ),

                            ///最长三行，超过 ... 显示
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          margin: new EdgeInsets.only(top: 0.0, bottom: 0.0),
                          alignment: Alignment.topLeft
                          ),

                      ///三个平均分配的横向图标文字
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _getBottomItem(Icons.star, "1000"),
                          _getBottomItem(Icons.link, "2000"),
                          _getBottomItem(Icons.subject, "3000"),
                          new Text(
                            "元旦假期高速公路不免费",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 14.0,
                            ),

                            ///最长三行，超过 ... 显示
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        new Container(
                          color: Colors.blue,
                        ),
                        new Container(
                          color: Colors.yellow,
                        ),
                        ],
                      ),
                      
                      new SizedBox(
                        width: 100,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:BorderRadius.circular(8.0),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                ),
      ),
    );
  }
}
