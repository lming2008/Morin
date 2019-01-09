import 'package:flutter/material.dart';
import 'package:morin/Demos/ReduxDemo.dart';
import 'package:morin/Launch/LaunchPage.dart';
import 'package:morin/Constants/Constants.dart' show AppColors;
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:morin/Demos/Text.dart';
import 'package:morin/Demos/StateManagement.dart';
import 'package:morin/Demos/StreamDemo.dart';
import 'package:morin/Demos/BlocDemo.dart';
import 'package:morin/Demos/RxDartDemo.dart';
import 'package:morin/Demos/HttpDemo.dart';
import 'package:morin/Demos/ScopedmodelDemo.dart';
import 'package:morin/Account/LoginPage.dart';


void main() {
  runApp(MorinApp());
}

class MorinApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        FlutterI18nDelegate(false, 'zh', 'assets/i18n'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      title: "title",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: Color(AppColors.AppBarColor),
          cardColor: Color(AppColors.AppBarColor)),

      initialRoute: 'scopedmodel',
      //路由
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => LaunchPage(title: "Morin"),
        '/one': (BuildContext context) => Page(title: 'page one'),
        '/two': (BuildContext context) => Page(title: 'page two'),
        '/three': (BuildContext context) => Page(title: 'page three'),
        '/state': (BuildContext context) => StateManagementDemo(),
        'scopedmodel':(BuildContext context) => ScopedmodelDemo(),
        '/stream': (BuildContext context) => StreamDemoHome(),
        '/bloc': (BuildContext context) => BlocDemo(),
        '/rxdart': (BuildContext context) => RxdartDemo(),
        '/http': (BuildContext context) => HttpDemo(),
        '/redux':(BuildContext context) => ReduxDemo(title: 'Redux Demo',),
        '/login':(BuildContext context) => LoginFormTestRoute(title:'登录'),
      },
      
    );
  }
}
