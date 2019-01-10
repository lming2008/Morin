import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxDemo extends StatelessWidget {
  ReduxDemo();

  final store =
      Store<CounterState>(reducer, initialState: CounterState.initState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CounterState>(
      store: store,
      child: new MaterialApp(
        title: 'Redux Demo',
        home: ReduxDemoFirstPage(),
      ),
    );
  }
}

class ReduxDemoFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //状态显示
            StoreConnector<CounterState, int>(
              converter: (store) => store.state.count,
              builder: (context, count) {
                return Text(
                  count.toString(),
                  style: TextStyle(fontSize: 48.0),
                );
              },
            ),

            //触发动作
            StoreConnector<CounterState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(ActionType.actionTypeA);
              },
              builder: (context, callback) {
                return RaisedButton(
                  child: Text('+'),
                  onPressed: callback,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ReduxDemoSecondPage(
              title: "Second Page",
            );
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}

class ReduxDemoSecondPage extends StatelessWidget {
  final String title;
  ReduxDemoSecondPage({Key key, this.title});
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
            Row(
              children: <Widget>[

                //显示状态
                StoreConnector<CounterState, int>(
                  converter: (store) => store.state.count,
                  builder: (context, count) {
                    return Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),

                //触发动作
                StoreConnector<CounterState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(ActionType.actionTypeB);
                  },
                  builder: (context, callback) {
                    return RaisedButton(
                      child: Text('+'),
                      onPressed: callback,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('hello'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

CounterState reducer(CounterState state, action) {
  //匹配Action
  if (action == ActionType.actionTypeA) {
    return CounterState(state.count + 1);
  } else if (action == ActionType.actionTypeB) {
    return CounterState(state.count - 1);
  }
  return state;
}

enum ActionType { actionTypeA, actionTypeB }

/*
 * CounterState 中的所有属性都应该是只读
 */
@immutable
class CounterState {
  final int _count;
  get count => _count;

  CounterState(this._count);

  CounterState.initState() : _count = 0;
}
