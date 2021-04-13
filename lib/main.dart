import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/repository/created.dart';
import 'package:flutter_app_pruebas/repository/delete.dart';
import 'package:flutter_app_pruebas/repository/fetch.dart';
import 'package:flutter_app_pruebas/repository/update.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manipulation Data Example',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manipulation Data Example'),
        ),
        body: Container(
          child:
              Fetch(), /*Column(
            children: [
              
              /*Created(),
              Delete(),
              Update(),*/
            ],*/
        ),
      ),
      //),
    );
  }
}
