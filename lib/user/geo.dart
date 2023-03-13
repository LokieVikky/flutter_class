class Geo{
  String? lat;
  String? lng;

  Geo.fromJson(dynamic json){
    lat = json['lat'];
    lng = json['lng'];
  }
}