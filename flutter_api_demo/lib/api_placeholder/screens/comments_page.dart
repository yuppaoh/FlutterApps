import 'package:flutter/material.dart';

import '../models/comments.dart';
import '../controllers/services.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comments> commentData = [];

  @override
  void initState() {
    super.initState();
    Services.fetchComments().then((value) {
      setState(() {
        commentData = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Comments API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: commentData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightGreenAccent.shade100,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${commentData[index].id}. ${commentData[index].name}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${commentData[index].name}',
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

