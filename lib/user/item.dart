import 'package:flutter_class/user/address.dart';
import 'package:flutter_class/user/company.dart';

class Item{
  String? itemId;
  String? itemName;
  String? itemNameTamil;
  String? rate;
  String? mrp;
  String? vendorname;
  String? vendorId;
  String? stock;
  String? url;

  Item.fromJson(dynamic json){
    itemId = json['Itemid'];
    itemName = json['Itemname'];
    itemNameTamil = json['itemnametamil'];
    rate = json['Rate'];
    mrp = json['MRP'];
    vendorname = json['VendorName'];
    vendorId = json['vendorid'];
    stock = json['stock'];
    url = 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';
  }


@override
  String toString() {
    return '$itemName';
  }

}