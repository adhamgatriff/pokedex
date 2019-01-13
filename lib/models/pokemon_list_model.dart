
class PokeList {

  final String name;
  final String url;
  final int number;

  PokeList({this.name, this.url, this.number});

  factory PokeList.fromJson(Map<String, dynamic> json) {
    return PokeList (
      name: json['name'],
      number: int.parse(json['url'].split('pokemon/')[1].replaceFirst('/','')),
      url: json['url'],
    );
  }
}