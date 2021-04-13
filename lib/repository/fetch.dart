import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/model/users.dart';
import 'package:http/http.dart' as http;

Future<List<Users>> fetchUsers(http.Client client) async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  return compute(parseUsers, response.body);
  /*if (response.statusCode == 200) {
    return Users.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load users');
  }*/
}

List<Users> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Users>((json) => Users.fromJson(json)).toList();
}

class Fetch extends StatelessWidget {
  final String name;

  Fetch({
    Key key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Users>>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? UsersList(users: snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }
}

class UsersList extends StatelessWidget {
  final List<Users> users;

  UsersList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(users[index].id.toString()),
              Text(users[index].name),
              Text(users[index].username),
              Text(users[index].email),
              Text(users[index].address.street),
              Text(users[index].address.suite),
              Text(users[index].address.city),
              Text(users[index].address.zipcode),
              Text(users[index].address.geo.lat),
              Text(users[index].address.geo.lng),
              Text(users[index].phone),
              Text(users[index].website),
              Text(users[index].company.name),
              Text(users[index].company.catchPhrase),
              Text(users[index].company.bs),
            ],
          );
        });
  }
}

/*class Fetch extends StatefulWidget {
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
}*/
