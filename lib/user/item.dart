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

  Item.fromJson(dynamic json){
    itemId = json['Itemid'];
    itemName = json['Itemname'];
    itemNameTamil = json['itemnametamil'];
    rate = json['Rate'];
    mrp = json['MRP'];
    vendorname = json['VendorName'];
    vendorId = json['vendorid'];
    stock = json['stock'];
  }


@override
  String toString() {
    return '$itemName';
  }

}