import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/model/users.dart';
import 'package:http/http.dart' as http;

Future<Users> fetchUsers() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'users/2'));

  if (response.statusCode == 200) {
    return Users.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load users');
  }
}

class Fetch extends StatefulWidget {
  @override
  _Fetch createState() => _Fetch();
}

class _Fetch extends State<Fetch> {
  Future<Users> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Users>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.address.geo.lat);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
