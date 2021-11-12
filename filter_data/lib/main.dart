// import 'package:filter_data/DataTableMySqlDemo/DataTableDemo.dart';
import 'package:flutter/material.dart';

import './filter_data/filter_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilterData(),
      // home: DataTableDemo(),
    );
  }
}

