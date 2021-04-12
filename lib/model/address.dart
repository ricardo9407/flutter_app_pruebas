import 'package:flutter/material.dart';
import 'package:flutter_app_pruebas/model/geo.dart';

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({
    Key key,
    @required this.street,
    @required this.suite,
    @required this.city,
    @required this.zipcode,
    @required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: Geo.fromJson(json['geo']),
    );
  }
}
