import 'package:flutter/material.dart';

class Geo {
  String lat;
  String lng;

  Geo({
    Key key,
    @required this.lat,
    @required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
