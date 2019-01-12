import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon_list_model.dart';


class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {

  final String url = 'https://pokeapi.co/api/v2/pokemon/';
  Future<List<PokeList>> pokeList;

  @override
  void initState() {
    super.initState();
    pokeList = this.apiCall();
  }

  Future<List<PokeList>> apiCall() async {
    final response = await http.get(url); 

    if (response.statusCode == 200) {

      return (json.decode(response.body)['results'] as List)
        .map((data) => PokeList.fromJson(data))
        .toList();

    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('data')),
        body: FutureBuilder<List<PokeList>>(
          future: pokeList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return createListView(context, snapshot);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator(); 
          },
        )
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<PokeList> values = snapshot.data;
    return new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(values[index].name),
              ),
              new Divider(height: 2.0,),
            ],
          );
        },
    );
  }
}


