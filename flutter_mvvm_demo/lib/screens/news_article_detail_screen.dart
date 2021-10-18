import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/viewmodels/news_article_view_model.dart';
import 'package:flutter_mvvm_demo/widgets/circle_image.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  const NewsArticleDetailScreen({Key? key, this.article}) : super(key: key);
  final NewsArticleViewModel? article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/no-image-found-360x250.png'),
            ),
            SizedBox(width: 5,),
            Container(
              constraints: BoxConstraints(
                maxWidth: 150,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Author',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  Text(
                    this.article!.author ?? 'Undefined',
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Divider(
                  color: Color(0xffff8a30),
                  height: 80,
                  thickness: 20,
                ),
                Text(
                  'Headline',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white
                  ),
                )
              ],
            ),
            Text(
              this.article!.title!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                wordSpacing: 3,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              this.article!.publishedAt!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 200,
                child: CircleImage(
                  imageUrl: this.article!.imageUrl!,
                ),
            ),
            SizedBox(height: 30,),
            Text(
              this.article!.description!,
              style: TextStyle(
                fontSize: 16,
                wordSpacing: 3
              ),
            ),
          ],
        ),
      ),
    );
  }
}
