import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/models/city.dart';
import 'dart:ffi';

import 'package:flutter_meteoro_app/pages/principal_city_page.dart';

//import 'movie_page.dart';
//import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ciudadValor = 'Sevilla';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff828CAE),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, bottom: 30),
                child: Text(
                  'Bienvenido',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Image(image: AssetImage('assets/images/fondo.jpg')),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Añadir ubicación \n predeterminada',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
