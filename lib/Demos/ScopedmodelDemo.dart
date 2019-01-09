import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedmodelDemo extends StatelessWidget {
  ScopedmodelDemo();

  final CounterModel model = CounterModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: new MaterialApp(
        home: ScopedmodelDemoFirstPage(),
      ),
    );
  }
}

class ScopedmodelDemoFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('First Page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  model.count.toString(),
                  style: TextStyle(fontSize: 48.0),
                ),
                RaisedButton(
                  child: Text('+'),
                  onPressed: () {
                    model.increaseCount();
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ScopedmodelDemoSecondPage(
                  title: "Second Page",
                );
              }));
            },
            child: Icon(Icons.forward),
          ),
        );
      },
    );
  }
}

class ScopedmodelDemoSecondPage extends StatelessWidget {
  final String title;
  ScopedmodelDemoSecondPage({Key key, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScopedModelDescendant<CounterModel>(
                builder: (context, child, model) {
              return Row(
                children: <Widget>[
                  Text(
                    model.count.toString(),
                    style: TextStyle(fontSize: 48.0),
                  ),
                  RaisedButton(
                    child: Text('+'),
                    onPressed: () {
                      model.increaseCount();
                    },
                  ),
                ],
              );
            }),
            Row(
              children: <Widget>[
                Text('hello'),
              ],
            )
          ],
        ),
      ),
    );

    /*
    return ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                model.count.toString(),
                style: TextStyle(fontSize: 48.0),
              ),
              RaisedButton(
                child: Text('+'),
                onPressed: () {
                  model.increaseCount();
                },
              ),
            ],
          ),
        ),
      );
    });
    */
  }
}

class CounterModel extends Model {
  int _count = 0;
  int get count => _count;

  void increaseCount() {
    _count += 1;
    notifyListeners();
  }
}
