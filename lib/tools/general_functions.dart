import 'package:flutter/material.dart';

String addZeroes(int number) {
	String num = number.toString();
  if (num.length == 1) {
    return '00'+num;
  } else if (num.length == 2) {
    return '0'+num;
  }

  return num;
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
    return Colors.red[300];

  } else if (pokemonColor == 'white') {
    return Colors.grey[100];

  } else if (pokemonColor == 'yellow') {
    return Colors.yellow[300];

  }

  return Colors.green[400];
}

Color setTypeColor(String type) {
  if(type == 'normal') {
    return Color.fromARGB(255, 186, 186, 170);
    
  } else if(type == 'fighting') {
    return Color.fromARGB(255, 185, 89, 69);
    
  } else if(type == 'flying') {
    return Color.fromARGB(255, 123, 157, 225);

  } else if(type == 'poison') {
    return Color.fromARGB(255, 157, 94, 147);

  } else if(type == 'ground') {
    return Color.fromARGB(255, 211, 184, 84);
    
  } else if(type == 'rock') {
    return Color.fromARGB(255, 190, 170, 99);
    
  } else if(type == 'bug') {
    return Color.fromARGB(255, 166, 181, 62);
    
  } else if(type == 'ghost') {
    return Color.fromARGB(255, 102, 101, 161);
    
  } else if(type == 'steel') {
    return Color.fromARGB(255, 170, 168, 178);
    
  } else if(type == 'fire') {
    return Color.fromARGB(255, 223, 81, 59);
    
  } else if(type == 'water') {
    return Color.fromARGB(255, 50, 150, 249);
    
  } else if(type == 'grass') {
    return Color.fromARGB(255, 119, 198, 89);
    
  } else if(type == 'electric') {
    return Color.fromARGB(255, 255, 221, 140);
    
  } else if(type == 'psychic') {
    return Color.fromARGB(255, 191, 85, 121);
    
  } else if(type == 'ice') {
    return Color.fromARGB(255, 128, 222, 255);
    
  } else if(type == 'dragon') {
    return Color.fromARGB(255, 125, 106, 210);
    
  } else if(type == 'dark') {
    return Color.fromARGB(255, 85, 68, 62);
    
  } else if(type == 'fairy') {
    return Color.fromARGB(255, 253, 169, 252);
    
  }

  return Colors.grey;
}