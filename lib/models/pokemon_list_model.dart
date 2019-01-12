
class PokeList {

  final String name;
  final String url;
  final String number;

  PokeList({this.name, this.url, this.number});

  factory PokeList.fromJson(Map<String, dynamic> json) {
    return PokeList (
      name: json['name'],
      number: json['name'],
      url: json['url'],
    );
  }
}