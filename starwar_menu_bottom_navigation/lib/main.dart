import 'package:flutter/material.dart';
import 'package:starwar_menu_bottom_navigation/pages/home_page.dart';
import 'package:starwar_menu_bottom_navigation/pages/players_page.dart';
import 'package:starwar_menu_bottom_navigation/models/players.dart';

//import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/players': (context) => const PlayersPage(),
      },
    );
  }
}
