import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_news_article/news_article_page.dart';
import 'package:flutter_api_demo/api_placeholder/controllers/services.dart';
import 'package:flutter_api_demo/api_placeholder/screens/users_page.dart';

import 'api_placeholder/models/comments.dart';
import 'api_placeholder/screens/comments_page.dart';

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
      // home: CommentPage(),
      home: UserPage(),
      // home: NewArticlePage(),
    );
  }
}

