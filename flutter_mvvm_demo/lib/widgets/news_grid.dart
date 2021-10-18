import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/screens/news_article_detail_screen.dart';
import 'package:flutter_mvvm_demo/viewmodels/news_article_view_model.dart';
import 'package:flutter_mvvm_demo/widgets/circle_image.dart';

class NewsGrid extends StatelessWidget {
  const NewsGrid({Key? key, required this.articles}) : super(key: key);

  final List<NewsArticleViewModel> articles;
  
  void _showNewsArticleDetails(context, article) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return NewsArticleDetailScreen(article: article,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    var defaultImg = "https://mma.prnewswire.com/media/74966/kelley_blue_book_logo.jpg?p=facebook";

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        var article = articles[index];
        return GestureDetector(
          onTap: () {
            _showNewsArticleDetails(context, article);
          },
          child: GridTile(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: CircleImage(imageUrl: article.imageUrl ?? defaultImg,)
              ),
            footer: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                article.title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),
            ),
          ),
        );
      },
      itemCount: this.articles.length,
    );
  }
}
