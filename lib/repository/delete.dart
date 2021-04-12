import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/model/posts.dart';
import 'package:http/http.dart' as http;

Future<Posts> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
  );

  if (response.statusCode == 200) {
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Posts');
  }
}

Future<Posts> deletePosts(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete Posts.');
  }
}

class Delete extends StatefulWidget {
  String id;
  Delete({Key key, this.id}) : super(key: key);

  @override
  _Delete createState() {
    return _Delete();
  }
}

class _Delete extends State<Delete> {
  Future<Posts> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Posts>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${snapshot.data?.title ?? 'Deleted'}'),
                  ElevatedButton(
                    child: Text('Delete Data'),
                    onPressed: () {
                      setState(() {
                        _futurePosts = deletePosts(snapshot.data.id.toString());
                      });
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
