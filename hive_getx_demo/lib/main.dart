import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_getx_demo/controllers/todo_controller.dart';
import 'package:path_provider/path_provider.dart';

import 'home_screen.dart';
import 'models/todo.dart';

// https://www.youtube.com/watch?v=7M6gjCL8f3g&list=PL3C5jP0W0eMJtBJWHpFFNvoC5T_UmAOMs&index=28

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter<Todo>(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoController =  Get.put<TodoController>(TodoController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive GetX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

