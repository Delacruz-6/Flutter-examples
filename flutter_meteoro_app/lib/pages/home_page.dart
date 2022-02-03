import 'package:flutter/material.dart';

//import 'movie_page.dart';
//import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff828CAE),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.add),
              color: Colors.grey,
              highlightColor: Colors.blueGrey,
              hoverColor: Colors.blueGrey,
              focusColor: Colors.blueGrey,
              splashColor: Colors.blueGrey,
              disabledColor: Colors.blue,
              iconSize: 40,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
