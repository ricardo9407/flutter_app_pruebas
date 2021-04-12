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
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Posts> updatePosts(String title) async {
  final http.Response response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

class Update extends StatefulWidget {
  Update({Key key}) : super(key: key);

  @override
  _UpdateState createState() {
    return _UpdateState();
  }
}

class _UpdateState extends State<Update> {
  final TextEditingController _controller = TextEditingController();
  Future<Posts> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Posts>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data.title),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter Title'),
                  ),
                  ElevatedButton(
                    child: Text('Update Data'),
                    onPressed: () {
                      setState(() {
                        _futurePosts = updatePosts(_controller.text);
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
