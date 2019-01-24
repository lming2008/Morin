import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:morin/Sidebar/SidebarPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new IndexPageState();
  }
}

class IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return layout(context);
  }

  Widget layout(BuildContext context) {
    Widget headLayout = new Container(
      margin: EdgeInsets.only(left: 15, top: 10),
      child: new Row(
        children: <Widget>[
          new Image.asset(
            "assets/images/home_avatar.png",
            width: 28,
            height: 28,
            fit: BoxFit.fill,
          ),
          new Container(
              margin: EdgeInsets.only(left: 77),
              child: new Image.asset("assets/images/home_logo.png",
                  width: 135, height: 20))
        ],
      ),
    );

    ///广告轮播图
    Widget bannerLayout = new Container(
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        margin: EdgeInsets.only(top: 10),
        child: Swiper(
          itemBuilder: swiperBuilder,
          itemCount: 3,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.black54,
            activeColor: Colors.white,
          )),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => print('点击了第$index个'),
          viewportFraction: 0.8,
          scale: 0.9,
        ));

    ///分割线
    Widget dividerLine = new Container(
      margin: EdgeInsets.only(top: 10, right: 10),
      child: Divider(
        height: 1,
        indent: 10,
        color: Colors.black.withOpacity(0.1),
      ),
    );

    ///分割线
    Widget dividerDecoration = new Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.black.withOpacity(0.08),
      height: 11,
    );

    ///公告
    Widget noticeLayout = new Container(
      padding: const EdgeInsets.only(left: 30, top: 10),
      child: new Row(
        children: [
          new Image.asset(
            'assets/images/icon_notice.png',
            width: 21.0,
            height: 17.0,
            fit: BoxFit.fill,
          ),
          new Container(
              margin: EdgeInsets.only(left: 10),
              height: 20,
              width: 200,
              child: new Swiper(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                autoplay: true,
                itemBuilder: noticeBuilder,
              ))
        ],
      ),
    );

    var symbolList = List.generate(
      5,
      (int index) => getConfigItem(index),
    );

    ///配置交易对
    Widget configLayout = new ListView(
      scrollDirection: Axis.horizontal,
      children: symbolList,
    );

    ///功能区数据
    List<FunctionBean> imgList = [
      FunctionBean()
        ..img = "assets/images/img_trade.png"
        ..title = "Exchange",
      FunctionBean(img: "assets/images/img_margin.png", title: "Margin"),
      FunctionBean(img: "assets/images/img_fiat.png", title: "Fiat"),
      FunctionBean(img: "assets/images/img_helper.png", title: "Helper"),
    ];

    ///获取功能中心的数据
    List<Widget> getFunctionListData() {
      print("---->" + ScreenUtil().scaleWidth.toString());
      return imgList.map((bean) {
        return new Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(187),
          child: new Column(
            children: <Widget>[
              new Image.asset(bean.img,
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setWidth(80),
                  fit: BoxFit.fill),
              new Text(
                bean.title,
                style:
                    new TextStyle(fontSize: 14, color: const Color(0xFF8C9FAD)),
              )
            ],
          ),
        );
      }).toList();
    }

    ///功能区布局
    Widget functionLayout = new GridView.extent(
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      maxCrossAxisExtent: ScreenUtil().setWidth(300),
      scrollDirection: Axis.horizontal,
      children: getFunctionListData(),
    );

    List<CurrencyBean> currencyList = [
      CurrencyBean(
          baseCurrency: "BTC",
          quoteCurrency: "USDT",
          desc1: "比特币",
          desc2: "加密的数字货币，总量2千万",
          percent: "+12.34%",
          price: "10230.34"),
      CurrencyBean(
          baseCurrency: "ETH",
          quoteCurrency: "USDT",
          desc1: "以太坊数字货币",
          desc2: "智能合约,数字货币钱包",
          percent: "+13.34%",
          price: "830.34"),
      CurrencyBean(
          baseCurrency: "LTC",
          quoteCurrency: "USDT",
          desc1: "莱特币",
          desc2: "数字货币经典",
          percent: "+15.34%",
          price: "10.34"),
      CurrencyBean(
          baseCurrency: "DASH",
          quoteCurrency: "USDT",
          desc1: "达世币",
          desc2: "数字货币经典",
          percent: "+15.34%",
          price: "10.34"),
    ];

    ///获得新币种介绍数据
    List<Widget> getNewCurrencyList() {
      return currencyList.map((currency) {
        return new Container(
          width: 150,
          margin: EdgeInsets.only(left: 15, top: 8),
          child: Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(currency.baseCurrency,
                      style: new TextStyle(
                          fontSize: 16, color: const Color(0xff1F3F59))),
                  new Text("/" + currency.quoteCurrency,
                      style: new TextStyle(
                          fontSize: 10, color: const Color(0xffC5CFD5)))
                ],
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10),
                child: new Text("·" + currency.desc1,
                    style: new TextStyle(
                        fontSize: 10, color: const Color(0xff8C9FAD))),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 3),
                child: new Text("·" + currency.desc2,
                    style: new TextStyle(
                        fontSize: 10, color: const Color(0xff8C9FAD))),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 13),
                child: new Text(currency.percent,
                    style: new TextStyle(
                        fontSize: 16, color: const Color(0xff03C087))),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 7),
                child: new Text(currency.price,
                    style: new TextStyle(
                        fontSize: 14, color: const Color(0xff1F3F59))),
              ),
            ],
          ),
        );
      }).toList();
    }

    ///新币种介绍布局
    Widget newCurrencyLayout = Column(
      children: <Widget>[
        new Container(
          height: 25,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 15, top: 16, bottom: 6),
          child: new Text(
            "新币介绍",
            style: new TextStyle(
                fontSize: 18,
                color: const Color(0xff1F3F59),
                fontWeight: FontWeight.w700),
          ),
        ),
        new Divider(),
        new Container(
          height: 130,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: getNewCurrencyList(),
          ),
        )
      ],
    );

    ///涨幅榜布局
    final List<Tab> myTabs = <Tab>[
      new Tab(text: "涨幅榜"),
      new Tab(text: "换手率榜"),
    ];

    Widget tabBar = new TabBar(
        isScrollable: true,
        labelColor: const Color(0xff1F3F59),
        indicatorColor: const Color(0x00ffffff),
        labelStyle: new TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        unselectedLabelStyle: new TextStyle(fontSize: 14),
        unselectedLabelColor: const Color(0xff8C9FAD),
        controller: controller,
        tabs: [new Tab(text: "涨幅榜"), new Tab(text: "换手率榜")]);

    ///涨幅榜的item布局
    Widget buildRankListItem(BuildContext context, int index) {
      print("---->" + index.toString());
      return new Container(
          margin: EdgeInsets.all(15),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  flex: 1,
                  child: Text(
                    currencyList[index].baseCurrency,
                    style: new TextStyle(
                        fontSize: 16, color: const Color(0xff1F3F59)),
                  )),
              new Expanded(
                flex: 1,
                child: new Container(
                    alignment: Alignment.center,
                    child: Text(
                      currencyList[index].price,
                      style: new TextStyle(
                          fontSize: 16, color: const Color(0xff1F3F59)),
                    )),
              ),
              new Expanded(
                flex: 1,
                child: new Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    currencyList[index].percent,
                    style: new TextStyle(
                        fontSize: 16, color: const Color(0xff1F3F59)),
                  ),
                ),
              ),
            ],
          ));
    }

    //涨幅榜布局
    Widget rankListLayout = TabBarView(
        controller: controller,
        children: myTabs.map((Tab tab) {
          return new Container(
            child: ListView.separated(
              shrinkWrap: false,
              itemCount: 4,
              itemBuilder: buildRankListItem,
              separatorBuilder: (BuildContext context, int index) =>
                  new Divider(),
            ),
          );
        }).toList());

    return new Scaffold(
      drawer: _drawer(context),
      body: new ListView(
        children: <Widget>[
          headLayout,
          bannerLayout,
          noticeLayout,
          dividerLine,
          Container(
            height: 110,
            child: configLayout,
          ),
          dividerDecoration,
          new Container(
            height: ScreenUtil().setHeight(170),
            child: functionLayout,
          ),
          dividerDecoration,
          newCurrencyLayout,
          new Divider(),
          tabBar,
          new Container(
            height: 260,
            child: rankListLayout,
          ),
        ],
      ),
    );
  }

  /// 获取配置的交易对Item
  Widget getConfigItem(index) {
    return new Container(
      width: 140,
      margin: EdgeInsets.only(top: 10),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: 5),
            child: new Text(
              "BTC/USDT" + index.toString(),
              style: new TextStyle(
                color: const Color(0xFF1F3F59),
                fontSize: 12,
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 5),
            child: new Text("10097.23",
                style: new TextStyle(
                  color: const Color(0xFF03C087),
                  fontSize: 18,
                )),
          ),
          new Container(
              margin: new EdgeInsets.only(top: 5),
              child: new Text("+121.45",
                  style: new TextStyle(
                    color: const Color(0xFF03C087),
                    fontSize: 12,
                  ))),
          new Container(
              margin: new EdgeInsets.only(top: 5, bottom: 10),
              child: new Text("≈108589.43 CNY",
                  style: new TextStyle(
                    color: const Color(0xFF8C9FAD),
                    fontSize: 12,
                  ))),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('发现'));
  }

  Widget swiperBuilder(BuildContext context, int index) {
    List<String> img = [
      "http://www.baidu.com",
      "http://www.baidu.com",
      "http://www.baidu.com"
    ];
    return (ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(
          img[index],
          fit: BoxFit.fill,
        )));
  }

  Widget noticeBuilder(BuildContext context, int index) {
    return (Container(
        margin: EdgeInsets.only(
          top: 1,
        ),
        child: Text("这是一个公告，明天放假" + index.toString(),
            style:
                new TextStyle(fontSize: 13, color: const Color(0xff1F3F59)))));
  }
}

class FunctionBean {
  String img;
  String title;

  FunctionBean({this.img, this.title});
}

class CurrencyBean {
  String baseCurrency;
  String quoteCurrency;
  String desc1;
  String desc2;
  String percent;
  String price;
  String mount;

  CurrencyBean(
      {this.baseCurrency,
      this.quoteCurrency,
      this.desc1,
      this.desc2,
      this.percent,
      this.price,
      this.mount});
}

Widget _drawer(BuildContext context) {
  return new Drawer(
    //侧边栏按钮Drawer
    child: new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          //Material内置控件
          accountName: new Text('CYC'),
          //用户名
          accountEmail: new Text('example@126.com'),
          //用户邮箱
          currentAccountPicture: new GestureDetector(
            //用户头像
            onTap: () => print('current user'),
            child: new CircleAvatar(
              //圆形图标控件
              backgroundImage: new NetworkImage(
                  'https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'), //图片调取自网络
            ),
          ),
          otherAccountsPictures: <Widget>[
            //粉丝头像
            new GestureDetector(
              //手势探测器，可以识别各种手势，这里只用到了onTap
              onTap: () => print('other user'), //暂且先打印一下信息吧，以后再添加跳转页面的逻辑
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
              ),
            ),
            new GestureDetector(
              onTap: () => print('other user'),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
              ),
            ),
          ],
          decoration: new BoxDecoration(
            //用一个BoxDecoration装饰器提供背景图片
            image: new DecorationImage(
              fit: BoxFit.fill,
              // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
              //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
              image: new ExactAssetImage('assets/images/ic_settings.png'),
            ),
          ),
        ),
        new ListTile(
            //第一个功能项
            title: new Text('First Page'),
            trailing: new Icon(Icons.arrow_upward),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new SidebarPage()));
            }),
        new ListTile(
            //第二个功能项
            title: new Text('Second Page'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new SidebarPage()));
            }),
        new ListTile(
            //第二个功能项
            title: new Text('Second Page'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/a');
            }),
        new Divider(), //分割线控件
        new ListTile(
          //退出按钮
          title: new Text('Close'),
          trailing: new Icon(Icons.cancel),
          onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
        ),
      ],
    ),
  );
}
