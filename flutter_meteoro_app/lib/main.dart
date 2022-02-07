import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/pages/menu_page.dart';
// ignore: unused_import
import 'dart:ffi';

import 'dart:async';

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
        backgroundColor: Color(0xff828CAE),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPage(),
        //'/movies': (context) => const MoviesPage(),
      },
    );
  }
}
