import 'package:flutter/material.dart';
import 'package:mvp_idr_corner/presenters/presenter.dart';
import 'package:mvp_idr_corner/views/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(BasicAppPresenter()),
    );
  }
}

