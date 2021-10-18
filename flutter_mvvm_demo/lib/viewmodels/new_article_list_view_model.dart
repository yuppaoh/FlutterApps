import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/models/news_article.dart';
import 'package:flutter_mvvm_demo/services/web_service.dart';

import 'news_article_view_model.dart';

enum LoadingStatus {
  completed,
  searching,
  empty
}

class NewsArticleListViewModel with ChangeNotifier{
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<NewsArticleViewModel> articles = <NewsArticleViewModel>[];

  void topHeadlinesCountry(String country) async {
    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlinesCountry(country);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.articles = newsArticles.map((article) => NewsArticleViewModel(article: article)).toList();

    if(this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    }else{
      this.loadingStatus = LoadingStatus.completed;
    }
  }

  void topHeadlines() async {
    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlines();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.articles = newsArticles.map((article) => NewsArticleViewModel(article: article)).toList();

    if(this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    }else{
      this.loadingStatus = LoadingStatus.completed;
    }
  }

  void topHeadlinesByHttp() async {
    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlinesByHttp();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.articles = newsArticles.map((article) => NewsArticleViewModel(article: article)).toList();

    if(this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    }else{
      this.loadingStatus = LoadingStatus.completed;
    }
  }

  void topHeadlinesCountryByHttp(String country) async {
    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlinesCountryByHttp(country);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.articles = newsArticles.map((article) => NewsArticleViewModel(article: article)).toList();

    if(this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    }else{
      this.loadingStatus = LoadingStatus.completed;
    }
  }
}