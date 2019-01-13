import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strings/strings.dart' as strings;
import '../tools/general_functions.dart';
import '../models/pokemon_list_model.dart';

class CustomRect extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(-size.width, -20.0, size.width, size.height+20);
    return rect;
  }
  
  @override
  bool shouldReclip(CustomRect oldClipper) {
    return true;
  }
}

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {

  final String url = 'http://pokeapi.co/api/v2/pokemon/?limit=811';
  final String imageurl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail';
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
        appBar: AppBar(title: Text('List of Pokemons')),
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
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        String pokemonNumber = addZeroes(values[index].number);

        return Container(
          
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              )
            )
          ),
          child: Row(
            children: <Widget>[
              ClipOval(
                clipper: CustomRect(),
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  ),
                  width: 100,
                  height: 100,
                  // color: Colors.grey,
                  child: Image.network(
                    '$imageurl/$pokemonNumber.png',
                    width: 65,
                    height: 65,
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
                          "#"+pokemonNumber,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          strings.capitalize(values[index].name),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        );
      },
    );
  }
}

 



