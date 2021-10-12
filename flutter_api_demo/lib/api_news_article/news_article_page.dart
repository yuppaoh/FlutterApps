import 'package:flutter/material.dart';

import 'news_article_services.dart';

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({Key? key}) : super(key: key);

  @override
  _NewArticlePageState createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  List<NewArticleServices> newsArticles = [];

  @override
  void initState() {
    super.initState();
    NewArticleServices.fetchComments().then((value) {
      setState(() {
        newsArticles = value.cast<NewArticleServices>();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Users API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: newsArticles.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlue.shade200,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${newsArticles.length}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
