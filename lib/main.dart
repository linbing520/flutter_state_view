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
      this.setState(() {
        state=LoadState.State_Error;
      });

    });
  }

  void onRetry(bool iserror) {
    this.setState(() {
      state=LoadState.State_Loading;
    });
    this.changeLoadingState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body:StateView(
          state: state,
          loadingLabel:'加载中...',
          emptyLabel: '空空如也',
          errorLabel: '我错了',
          onRetry: this.onRetry,
          child: Text('成功页面！'),
        ),
      );

}
