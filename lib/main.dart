import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './tools/theme.dart';
import './tools/routes.dart';

import './views/closed_pokedex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFdc0a2d),
      statusBarColor: Color(0xFFdc0a2d),
    ));

    return MaterialApp(
      title: 'Pokedex',
      theme: buildThemeData(),
      home: SafeArea(
        child: ClosedPokedex(),
      ),
      routes: routes(),
    );
  }
}

