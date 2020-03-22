
import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final StreamController _streamController = StreamController();

  addData() async {
    for(int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      _streamController.sink.add(i);
    }
  }
  //  It's the same thing as the above
  // Stream<int> numberStream() async* {
  //   for(int i = 1; i <= 10; i++){
  //     await Future.delayed(Duration(seconds: 1));

  //     yield i;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream')
      ),
      body: Center(
        child: StreamBuilder(
          stream: _streamController.stream.where((number) => number % 2 == 0),
          builder: (context, snapshot){
            if (snapshot.hasError){
              return Text('There is some error');
            } else if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.display1,
              );
          },
        )
      ),
    );
  }
}