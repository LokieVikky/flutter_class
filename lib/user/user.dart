import 'package:flutter_class/user/address.dart';
import 'package:flutter_class/user/company.dart';

class User{
  int? id;
  String? name;
  String? userName;
  String? email;
  String? phone;
  String? website;
  Company? company;
  Address? address;

  User.fromJson(dynamic json){
    id = json['id'];
    name = json['name'];
    userName = json['username'];
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
    address = Address.fromJson(json['address']);
    company = Company.fromJson(json['company']);
  }


@override
  String toString() {
    return '$name \n $userName \n $email \n $phone \n $website ';
  }

}