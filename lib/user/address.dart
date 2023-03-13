import 'package:flutter_class/user/geo.dart';

class Address{
  String? street;
  String? suite;
  String? city;
  String? zipCode;
  Geo? geo;

  Address.fromJson(dynamic json){
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipCode = json['zipcode'];
    geo = Geo.fromJson(json['geo']);
  }
}