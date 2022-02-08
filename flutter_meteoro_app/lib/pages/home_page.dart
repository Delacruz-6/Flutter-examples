import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/models/city.dart';
import 'dart:ffi';

import 'package:flutter_meteoro_app/pages/principal_city_page.dart';
import 'package:flutter_meteoro_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 60, bottom: 30),
                child: Text(
                  'Bienvenido',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
              const Image(image: AssetImage('assets/images/fondo.jpg')),
              //MoviesPage(),
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
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.blue.shade900,
                ),
                child: DropdownButton<String>(
                  value: ciudadValor,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  underline: Container(
                    height: 2,
                    color: Colors.blue.shade900,
                  ),
                  onChanged: (String? newValue) {
                    setState(() async {
                      ciudadValor = newValue!;
                      /*
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('nombreCiudad', ciudadValor);
                      PreferenceUtils.setString('nombreCiudad', ciudadValor);
                      */
                    });
                  },
                  items: <String>[
                    'Sevilla',
                    'Cadiz',
                    'Malaga',
                    'Madrid',
                    'Barcelona'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ) /*
          TextButton(
            child: Text('Enviar datos a la segunda página.'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EarthWeatherPage(
                          ciudad: "",
                          data: Ciudad(),
                        )),
              );
            },
          ),
          */
            ],
          ),
        ));
  }
}
