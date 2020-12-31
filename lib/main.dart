import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_state_view/state_view.dart';

import 'state_view.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'EasyListView Demo',
        theme: ThemeData(accentColor: Colors.pinkAccent),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  GlobalKey _key = GlobalKey();
  var state = LoadState.State_Loading;

  @override
  void initState() {
    super.initState();

    this.changeLoadingState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  void changeLoadingState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      _key.currentState.setState((){
        state=LoadState.State_Success;
      });
    });
  }

  void onRetry(bool iserror) {
    this.changeLoadingState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Text('成功页面！').pageStateLoading(_key)
    );
  }

}
