import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'news_articles.dart';

  // api_news_article chua su dung duoc

class NewArticleServices {
  static const String news_article_url = 'https://newsapi.org/v2/everything?q=tesla&from=2021-09-12&sortBy=publishedAt&apiKey=b6f198df25754973b3a535cfafaa106d';

  static List<NewsArticles> parseComments(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<NewsArticles> newsArticles = list.map((e) => NewsArticles.fromJson(e)).toList();
    return newsArticles;
  }

  static Future<List<NewsArticles>> fetchComments({int page = 490}) async {
    final response = await http.get(Uri.parse(news_article_url));
    if(response.statusCode == 200) {
      print('response.statusCode == 200');
      print(response.body);
      return compute(parseComments, response.body);
    }else if(response.statusCode == 400){
      throw Exception('Not found');
    }else{
      throw Exception('Can\'t get comment');
    }
  }
}