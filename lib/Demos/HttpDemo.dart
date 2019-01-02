import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HttpDemoState();
}

class HttpDemoState extends State<HttpDemo> {
  Future _gerData() async {
    final response = await http.get(
        'http://v.juhe.cn/toutiao/index?key=8521da7cf9c429e44854c3e557a3a874');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<Toutiao> toutiaos = responseBody['result']['data']
          .map<Toutiao>((item) => Toutiao.fromJson(item))
          .toList();
      print(toutiaos);
      return toutiaos;
    } else {
      throw Exception('Failed to fetch Toutiaos.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Demo'),
      ),
      body: FutureBuilder(
        builder: _buildFuture,
        future: _gerData(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text('准备连接网络');
      case ConnectionState.active:
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return null;
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Toutiao> toutiaos = snapshot.data;
    return ListView.builder(
      itemBuilder: (context, index) => _itemBuilder(context, index, toutiaos),
      itemCount: toutiaos.length,
    );
  }

  Widget _itemBuilder(BuildContext context, int index, toutiaos) {
    if (index.isOdd) {
      return Divider();
    }
    return ListTile(
      title: Text('${toutiaos[index].title}'),
      subtitle: Text('${toutiaos[index].authorName}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage('${toutiaos[index].thumbnailPicS}'),
      ),
      onTap: () {
        print('点击:${toutiaos[index].title}');
      },
      //trailing: Text('${toutiaos[index].category}'),
    );
  }
}

/*
 * 头条新闻数据结构
 */
class Toutiao {
  final String title;
  final String thumbnailPicS;
  final String date;
  final String category;
  final String authorName;
  final String url;

  Toutiao(this.title, this.thumbnailPicS, this.date, this.category,
      this.authorName, this.url);

  //json to model
  Toutiao.fromJson(Map json)
      : title = json['title'],
        thumbnailPicS = json['thumbnail_pic_s'],
        date = json['date'],
        category = json['category'],
        authorName = json['author_name'],
        url = json['url'];

  //model to json
  Map toJson() => {
        'title': title,
        'thumbnailPicS': thumbnailPicS,
        'date': date,
        'category': category,
        'authorName': authorName,
        'url': url
      };
}
