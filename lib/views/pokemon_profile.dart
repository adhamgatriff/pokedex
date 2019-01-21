import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strings/strings.dart' as strings;
import '../models/pokemon_list_model.dart';
import '../models/pokemon_model.dart';
import '../tools/custom_forms.dart';
import '../tools/general_functions.dart';

class PokemonProfile extends StatefulWidget {

  final PokeList pokemonSelected;
  final String imageurl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/detail';
  final String pokemonSpeciesUrl = 'https://pokeapi.co/api/v2/pokemon-species/';

  PokemonProfile({Key key, @required this.pokemonSelected}) : super(key: key);

  @override
  _PokemonProfileState createState() => _PokemonProfileState();
}

class _PokemonProfileState extends State<PokemonProfile> {

  PokemonMerged pokemon;
  // PokemonSpecies pokemonSpecies;
  bool loadingPokemon = true;
  bool loadingPokemonSpecies = true;

  @override
  void initState() {
    super.initState();

  Future.wait([this.getPokemonBasicData(), this.getPokemonSpeciesData()])
    .then( (response) {
      setState(() {
        pokemon = PokemonMerged(pokemon: response[0], pokemonSpecies: response[1]);
        loadingPokemon = false;
      });
    });
  }

  Future<Pokemon> getPokemonBasicData() async {
    final response = await http.get(widget.pokemonSelected.url); 

    if (response.statusCode == 200) {
      return  Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load basic pokemon data');
    }
  }

  Future<PokemonSpecies> getPokemonSpeciesData() async {
    final response = await http.get(widget.pokemonSpeciesUrl+ widget.pokemonSelected.number.toString());

    if (response.statusCode == 200) {
      return  PokemonSpecies.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load species of current pokemon');
    }
  }

  @override
  Widget build(BuildContext context) {
    String pokemonNumber = addZeroes(widget.pokemonSelected.number);

    return SafeArea(
      child: Material(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          color: pokemon?.pokemonSpecies?.color == null ?  Colors.grey: setBackgroundColor(pokemon.pokemonSpecies.color),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 0,
                                    right: 5,
                                  ),
                                  child: Text(
                                    strings.capitalize(widget.pokemonSelected.name),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  right: 10,
                                  top: 10,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "#"+pokemonNumber,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w300,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                pokemon?.pokemonSpecies?.genus == null ? '' : pokemon?.pokemonSpecies?.genus,
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(3),
                              child: pokemonTypes(),
                          )
                        ],
                      ),
                    ),
                    Hero(
                      tag: 'pokemon'+pokemonNumber,
                      child: ClipOval(
                        clipper: CustomRectMirror(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: 100,
                          height: 100,
                          child: Image.network(
                            widget.imageurl+'/'+pokemonNumber+'.png',
                            width: 65,
                            height: 65,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }

   Widget pokemonTypes() {
    if(pokemon == null) {
      return null;
    }

    return Row(children: pokemon.pokemon.types.map((type) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 2),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(
              color: setTypeColor(type['type']['name']),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            type['type']['name'].toUpperCase(), 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList());
  }
}