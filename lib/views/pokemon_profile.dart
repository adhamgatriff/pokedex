import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strings/strings.dart' as strings;
import '../models/pokemon_list_model.dart';
import '../models/pokemon_model.dart';
import '../tools/custom_forms.dart';
import '../tools/general_functions.dart';
import '../resources/loader.dart';

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
  bool loadingPokemon = true;

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

    if(pokemon != null) {
      changeStatusBar(setBackgroundColor(pokemon.pokemonSpecies.color));      
    }

    return SafeArea(
      child: Material(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          color: pokemon?.pokemonSpecies?.color == null ?  Colors.grey: setBackgroundColor(pokemon.pokemonSpecies.color),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 22.0,
                    color: Colors.black87,
                  ),
                  label: Text(
                    'Back', 
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              basicInfo(pokemonNumber),
              pokemonSpecies(),
              pokemonAbilities(),
            ],
          ),
        )
      )
    );
  }

  Container basicInfo(String pokemonNumber) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
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
                          left: 10.0,
                          top: 10.0,
                          bottom: 0.0,
                          right: 5.0,
                        ),
                        child: Text(
                          strings.capitalize(widget.pokemonSelected.name),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 10.0,
                        top: 10.0,
                        bottom: 5.0,
                      ),
                      child: Text(
                        "#"+pokemonNumber,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w300,
                          fontSize: 22.0,
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
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0,
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

  Widget pokemonSpecies() {
    if(pokemon == null) {
      return Expanded(
        child: Center(
          child: LoaderAnimation(),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Species',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Container(
            // height: 210,
            margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, top: 15, bottom: 5, right: 10),
                  child: Text(
                    pokemon.pokemonSpecies.flavorText,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, right: 35),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[400],
                        width: 0.4,
                      )
                    )
                  ),
                  child: Text(
                    'Flavor Text',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: pokemon.pokemonSpecies.color == 'black' ?  Colors.grey : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      pokemonInfo( 'Weight', pokemon.pokemon.weight.toStringAsFixed(2)+' Kg'),
                      pokemonInfo( 'Height', pokemon.pokemon.height.toStringAsFixed(2)+' M'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded pokemonInfo(String title, String value) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container( 
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35, right: 35),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[400],
                    width: 0.4,
                  )
                )
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: pokemon.pokemonSpecies.color == 'black' ?  Colors.grey : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pokemonAbilities() {
    if(pokemon == null) {
      return Container();
    }

  List <dynamic> abilities = pokemon.pokemon.abilities;
  abilities.sort((a, b) => a['slot'].compareTo(b['slot']));
  
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Abilities',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Container(
            // height: 100,
            margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: abilities.map((ability) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: setBackgroundColor(pokemon.pokemonSpecies.color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    ability['is_hidden'] ? strings.capitalize(ability['ability']['name'])+' (Hidden)' : strings.capitalize(ability['ability']['name']),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: pokemon.pokemonSpecies.color == 'black' ?  Colors.grey : Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}