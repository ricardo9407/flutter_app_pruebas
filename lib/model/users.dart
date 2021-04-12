import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/model/address.dart';
import 'package:flutter_app_pruebas/model/company.dart';

class Users {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;
  Address address;
  Company company;

  Users({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.phone,
    @required this.website,
    @required this.address,
    @required this.company,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }
}
