import 'package:flutter/material.dart';
import './tools/general_functions.dart';
import './tools/theme.dart';
import './tools/routes.dart';

import './views/closed_pokedex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    changeStatusBar(Color(0xFFdc0a2d));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: buildThemeData(),
      home: SafeArea(
        child: ClosedPokedex(),
      ),
      routes: routes(),
    );
  }
}

