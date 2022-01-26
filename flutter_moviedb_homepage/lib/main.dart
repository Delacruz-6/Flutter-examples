import 'package:flutter/material.dart';
import 'package:flutter_moviedb_homepage/pages/home_page.dart';
import 'package:flutter_moviedb_homepage/pages/movie_page.dart';

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
        '/players': (context) => const MoviesPage(),
      },
    );
  }
}
