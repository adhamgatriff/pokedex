import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strings/strings.dart' as strings;
import '../tools/general_functions.dart';
import '../tools/custom_forms.dart';
import '../models/pokemon_list_model.dart';
import '../views/pokemon_profile.dart';
import '../resources/loader.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final String url = 'http://pokeapi.co/api/v2/pokemon/?limit=811';
  final String imageurl =
      'https://assets.pokemon.com/assets/cms2/img/pokedex/detail';
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
    changeStatusBar(Color(0xFFdc0a2d));

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text('Pokemon list')),
          body: FutureBuilder<List<PokeList>>(
            future: pokeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return createListView(context, snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return LoaderAnimation();
            },
          )),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<PokeList> values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        String pokemonNumber = addZeroes(values[index].number);

        return Hero(
          tag: 'pokemon' + pokemonNumber,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PokemonProfile(pokemonSelected: values[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    clipper: CustomRect(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: 80,
                      height: 80,
                      child: Image.network(
                        '$imageurl/$pokemonNumber.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "#" + pokemonNumber,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            strings.capitalize(values[index].name),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
