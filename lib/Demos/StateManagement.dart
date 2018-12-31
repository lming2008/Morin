
import 'package:flutter/material.dart';


class StateManagemnet extends StatefulWidget {
  _StateManagemnetState createState() => _StateManagemnetState();
}

class _StateManagemnetState extends State<StateManagemnet> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: CounterWrapper(_count),
    );
  }
}

class CounterWrapper extends StatelessWidget {
  final int count;
  
  CounterWrapper(this.count);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Counter(count),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  final int count;
  Counter(this.count);
  
  Widget build(BuildContext context) {
    return Text('' + count);
  }
}

class CounterProvider extends InheritedWidget {
  final int count;
  final VoidCallback increaseCount;
  final Widget child;

  CounterProvider({
    this.count,
    this.increaseCount,
    this.child,
  }) : super(child: child);

  static CounterProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CounterProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class CounterModel extends Model {
  int _count = 0;
  int get count => _count;

  void increaseCount() {
    _count += 1;
    
  }
}
