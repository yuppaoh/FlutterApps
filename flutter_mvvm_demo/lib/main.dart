import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/screens/news_screen.dart';
import 'package:flutter_mvvm_demo/viewmodels/new_article_list_view_model.dart';
import 'package:provider/provider.dart';
// Part 1: https://www.youtube.com/watch?v=7n2QprcdHMA
// Part 2: https://www.youtube.com/watch?v=cY9VMlxfV9Y
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfffefdfd),
        appBarTheme: AppBarTheme(
          color: Color(0xfffefdfd),
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black,
              fontWeight: FontWeight.bold
            )
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black
          )
        )
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => NewsArticleListViewModel())
      ],
        child: NewsScreen(),
      )
    );
  }
}

