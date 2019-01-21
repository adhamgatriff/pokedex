import 'package:flutter/material.dart';
import '../views/pokemon_list.dart';
import '../views/pokemon_profile.dart';

Map<String, WidgetBuilder> routes() {
  return {
    'list': (context) => PokemonList(),
    'profile': (context) => PokemonProfile(),
  };
}