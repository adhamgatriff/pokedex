import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String addZeroes(int number) {
  String num = number.toString();
  if (num.length == 1) {
    return '00' + num;
  } else if (num.length == 2) {
    return '0' + num;
  }

  return num;
}

changeStatusBar(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: color,
    statusBarColor: color,
  ));
}

Color setBackgroundColor(String pokemonColor) {
  if (pokemonColor == 'black') {
    return Color(0xFF292929);
  } else if (pokemonColor == 'blue') {
    return Colors.blue[300];
  } else if (pokemonColor == 'brown') {
    return Colors.brown[300];
  } else if (pokemonColor == 'gray') {
    return Colors.grey[300];
  } else if (pokemonColor == 'green') {
    return Colors.green[300];
  } else if (pokemonColor == 'pink') {
    return Colors.green[300];
  } else if (pokemonColor == 'purple') {
    return Colors.green[300];
  } else if (pokemonColor == 'red') {
    return Colors.red[400];
  } else if (pokemonColor == 'white') {
    return Colors.grey[100];
  } else if (pokemonColor == 'yellow') {
    return Colors.yellow[300];
  }

  return Colors.green[400];
}

Color setTypeColor(String type) {
  if (type == 'normal') {
    return Color.fromARGB(255, 186, 186, 170);
  } else if (type == 'fighting') {
    return Color.fromARGB(255, 185, 89, 69);
  } else if (type == 'flying') {
    return Color.fromARGB(255, 123, 157, 225);
  } else if (type == 'poison') {
    return Color.fromARGB(255, 157, 94, 147);
  } else if (type == 'ground') {
    return Color.fromARGB(255, 211, 184, 84);
  } else if (type == 'rock') {
    return Color.fromARGB(255, 190, 170, 99);
  } else if (type == 'bug') {
    return Color.fromARGB(255, 166, 181, 62);
  } else if (type == 'ghost') {
    return Color.fromARGB(255, 102, 101, 161);
  } else if (type == 'steel') {
    return Color.fromARGB(255, 170, 168, 178);
  } else if (type == 'fire') {
    return Color.fromARGB(255, 223, 81, 59);
  } else if (type == 'water') {
    return Color.fromARGB(255, 50, 150, 249);
  } else if (type == 'grass') {
    return Color.fromARGB(255, 119, 198, 89);
  } else if (type == 'electric') {
    return Color.fromARGB(255, 255, 221, 140);
  } else if (type == 'psychic') {
    return Color.fromARGB(255, 191, 85, 121);
  } else if (type == 'ice') {
    return Color.fromARGB(255, 128, 222, 255);
  } else if (type == 'dragon') {
    return Color.fromARGB(255, 125, 106, 210);
  } else if (type == 'dark') {
    return Color.fromARGB(255, 85, 68, 62);
  } else if (type == 'fairy') {
    return Color.fromARGB(255, 253, 169, 252);
  }

  return Colors.grey;
}

getChain(chain, list, firstIterator) {
  final singleChain = chain['evolves_to'][0];

  if (firstIterator) {
    list.add({
      'name': chain['species']['name'],
      'number': int.parse(chain['species']['url']
          .split('pokemon-species/')[1]
          .replaceFirst('/', '')),
      'url': chain['species']['url'],
    });
  }

  list.add({
    'name': singleChain['species']['name'],
    'number': int.parse(singleChain['species']['url']
        .split('pokemon-species/')[1]
        .replaceFirst('/', '')),
    'url': singleChain['species']['url'],
    'evolution_details': {
      "gender": singleChain['evolution_details'][0]['gender'],
      "held_item": singleChain['evolution_details'][0]['held_item'],
      "item": singleChain['evolution_details'][0]['item'],
      "known_move": singleChain['evolution_details'][0]['known_move'],
      "known_move_type": singleChain['evolution_details'][0]['known_move_type'],
      "location": singleChain['evolution_details'][0]['location'],
      "min_affection": singleChain['evolution_details'][0]['min_affection'],
      "min_beauty": singleChain['evolution_details'][0]['min_beauty'],
      "min_happiness": singleChain['evolution_details'][0]['min_happiness'],
      "min_level": singleChain['evolution_details'][0]['min_level'],
      "needs_overworld_rain": singleChain['evolution_details'][0]
          ['needs_overworld_rain'],
      "party_species": singleChain['evolution_details'][0]['party_species'],
      "party_type": singleChain['evolution_details'][0]['party_type'],
      "relative_physical_stats": singleChain['evolution_details'][0]
          ['relative_physical_stats'],
      "time_of_day": singleChain['evolution_details'][0]['time_of_day'],
      "trade_species": singleChain['evolution_details'][0]['trade_species'],
    },
    'trigger': {
      'name': singleChain['evolution_details'][0]['trigger']['name'],
    }
  });

  if (chain['evolves_to'][0]['evolves_to'].length > 0) {
    return getChain(chain['evolves_to'][0], list, false);
  }

  return list;
}
