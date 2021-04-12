import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/model/posts.dart';
import 'package:http/http.dart' as http;

Future<Posts> createPosts(Posts posts) async {
  print(posts.title + ' ' + posts.body);
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': posts.title,
      'body': posts.body,
    }),
  );

  if (response.statusCode == 201) {
    print(response.body);
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Posts.');
  }
}

class Created extends StatefulWidget {
  Created({Key key}) : super(key: key);

  @override
  _Created createState() => _Created();
}

class _Created extends State<Created> {
  // ignore: non_constant_identifier_names
  final TextEditingController _controller_title = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controller_body = TextEditingController();
  Future<Posts> futurePosts;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: (futurePosts == null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _controller_title,
                  decoration: InputDecoration(hintText: 'Enter Title'),
                ),
                TextField(
                  controller: _controller_body,
                  decoration: InputDecoration(hintText: 'Enter body'),
                ),
                ElevatedButton(
                  child: Text('Create Data'),
                  onPressed: () {
                    Posts posts = new Posts(
                      userId: null,
                      id: null,
                      title: _controller_title.text,
                      body: _controller_body.text,
                    );
                    setState(() {
                      futurePosts = createPosts(posts);
                    });
                  },
                ),
              ],
            )
          : FutureBuilder<Posts>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.title + '\n' + snapshot.data.body);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
    );
  }
}
