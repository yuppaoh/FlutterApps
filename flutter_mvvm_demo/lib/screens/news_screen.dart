import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/utils/constants.dart';
import 'package:flutter_mvvm_demo/viewmodels/new_article_list_view_model.dart';
import 'package:flutter_mvvm_demo/widgets/news_grid.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  // const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false).topHeadlinesByHttp();
  }
  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<NewsArticleListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Icon(Icons.more_vert)
          PopupMenuButton(
            onSelected: (country) {
              listViewModel.topHeadlinesCountryByHttp(Constants.Countries[country] ?? "us");
              // listViewModel.topHeadlinesCountry(Constants.Countries[country] ?? "us");
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) {
              return Constants.Countries.keys.map((e) => PopupMenuItem(
                value: e,
                child: Text(e),
              )).toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text('News', style: TextStyle(fontSize: 50),),
            ),
            Divider(
              color: Color(0xffff8a30),
              height: 40,
              thickness: 8,
              indent: 30,
              endIndent: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
              child: Text(
                'Headline',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: NewsGrid(articles: listViewModel.articles,)
            ),
          ],
        ),
      )
    );
  }
}
