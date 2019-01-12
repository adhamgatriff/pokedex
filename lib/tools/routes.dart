import 'package:flutter/material.dart';
import '../views/pokemon_list.dart';

Map<String, WidgetBuilder> routes() {
  return {
    'list': (context) => PokemonList(),
  };
}