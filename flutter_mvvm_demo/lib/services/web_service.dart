import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter_mvvm_demo/models/news_article.dart';
import 'package:flutter_mvvm_demo/utils/constants.dart';

class WebService {
  // var dio = Dio();
  String day = DateTime.now().day.toString();
  // String url = "https://newsapi.org/v2/everything?q=tesla&from=2021-09-14&sortBy=publishedAt&apiKey=";
  // String apiKey = "b6f198df25754973b3a535cfafaa106d";

  String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=";
  String apiKey = "b6f198df25754973b3a535cfafaa106d";
 // https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b6f198df25754973b3a535cfafaa106d
  Future<List<NewsArticle>> fetchTopHeadlinesCountry(String country) async {
    final response = await Dio().get(Constants.headlinesFor(country));

    if(response.statusCode == 200) {
      final result = response.data;
      // Iterable list = result['articles'];
      // or:
      List list = result['articles'];
      return list.map((jsonData) => NewsArticle.fromJson(jsonData)).toList();
    } else {
      print("failed to get top news");
      throw Exception("failed to get top news");
    }
  }

  Future<List<NewsArticle>> fetchTopHeadlines() async {
    final response = await Dio().get('$url$apiKey');

    if(response.statusCode == 200) {
      final result = response.data;
      // Iterable list = result['articles'];
      // or:
      List list = result['articles'];
      return list.map((jsonData) => NewsArticle.fromJson(jsonData)).toList();
    } else {
      print("failed to get top news");
      throw Exception("failed to get top news");
    }
  }

  Future<List<NewsArticle>> fetchTopHeadlinesByHttp() async {
    final response = await http.get(Uri.parse('$url$apiKey'));
    try{
      if(response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List articles = jsonResponse['articles'];
        // or:
        // List<dynamic> articles = jsonResponse["articles"];
        return articles.map((data) => NewsArticle.fromJson(data)).toList();
      } else {
        print("response.statusCode != 200");
        return <NewsArticle>[];
      }
    }catch(e){
      print('Exception:' + e.toString());
      return <NewsArticle>[];
    }
  }

  Future<List<NewsArticle>> fetchTopHeadlinesCountryByHttp(String country) async {
    final response = await http.get(Uri.parse(Constants.headlinesFor(country)));
    try{
      if(response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List articles = jsonResponse['articles'];
        // or:
        // List<dynamic> articles = jsonResponse["articles"];
        return articles.map((data) => NewsArticle.fromJson(data)).toList();
      } else {
        print("response.statusCode != 200");
        return <NewsArticle>[];
      }
    }catch(e){
      print('Exception:' + e.toString());
      return <NewsArticle>[];
    }
  }
}