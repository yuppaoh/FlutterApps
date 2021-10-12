import 'package:flutter/material.dart';
import 'package:flutter_api_demo/api_placeholder/controllers/services.dart';

import '../models/users.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Users> userData = [];

  @override
  void initState() {
    super.initState();
    Services.fetchUsers().then((value) {
      setState(() {
        userData = value;
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
                itemCount: userData.length,
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
                            '${userData[index].id}. ${userData[index].name}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${userData[index].email}',
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
