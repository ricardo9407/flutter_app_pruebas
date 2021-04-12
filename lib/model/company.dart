import 'package:flutter/material.dart';

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({
    Key key,
    @required this.name,
    @required this.catchPhrase,
    @required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}
