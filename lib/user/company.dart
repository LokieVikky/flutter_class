class Company{
  String? name;
  String? catchPhrase;
  String? bs;

  Company.fromJson(dynamic json){
    name = json['name'];
    catchPhrase = json['name'];
    bs = json['name'];
  }
}