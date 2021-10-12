import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/comments.dart';
import '../models/users.dart';
class Services {
  static const String comment_url = 'https://jsonplaceholder.typicode.com/comments';
  static const String user_url = 'https://jsonplaceholder.typicode.com/users';

  static List<Comments> parseComments(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Comments> comments = list.map((e) => Comments.fromJson(e)).toList();
    return comments;
  }

  static Future<List<Comments>> fetchComments({int page = 490}) async {
    // meaning of int page = 1 ?
    final response = await http.get(Uri.parse(comment_url));
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

  // cach# chua dung den
  Future<List<Comments>> getCommentsFromApi(int start, int limit) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/comments?_start=$start&_limit=$limit");
    final http.Client httpClient = http.Client();
    try{
      final response = await httpClient.get(url);
      if(response.statusCode == 200) {
        final responseData = json.decode(response.body) as List;

        //convert responseData to List of comment ?
        final List<Comments> comments = responseData.map((comment) {
          return Comments(
            postId: comment['postId'],
              id: comment['id'],
              name: comment['name'],
              email: comment['email'],
              body: comment['body']
          );
        }).toList();
        print('start = $start, limit = $limit');
        return comments;
      } else {
        return <Comments>[];
      }
    } catch(exception) {
      print('Exception sending api : '+exception.toString());
      return <Comments>[];
    }
  }

  // UserData
  static List<Users> parseUsers(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Users> users = list.map((e) => Users.fromJson(e)).toList();
    return users;
  }

  static Future<List<Users>> fetchUsers({int page = 490}) async {
    // meaning of int page = 1 ?
    final response = await http.get(Uri.parse(user_url));
    if(response.statusCode == 200) {
      print('response.statusCode == 200');
      print(response.body);
      return compute(parseUsers, response.body);
    }else if(response.statusCode == 400){
      throw Exception('Not found');
    }else{
      throw Exception('Can\'t get comment');
    }
  }
}