import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starwars_menu_drawer/models/people.dart';
import 'package:flutter_starwars_menu_drawer/models/planet.dart';

import 'package:http/http.dart' as http;

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
          primaryIconTheme: IconThemeData(color: Colors.yellow),
          scaffoldBackgroundColor: const Color(0xFF808080)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<People>> itemsPeople;

  @override
  void initState() {
    itemsPeople = fetchpeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Star-wars API',
              style: TextStyle(color: Colors.yellow)),
          iconTheme: IconThemeData(color: Colors.yellow),
          backgroundColor: Colors.black),
      drawer: Drawer(
        backgroundColor: Color(0xFFD3D3D3),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 126,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text('Menu', style: TextStyle(color: Colors.yellow)),
              ),
            ),
            ListTile(
              title: const Text('Personajes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Planetas'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage2(title: "Planetas")));
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: 350,
        child: FutureBuilder<List<People>>(
          future: itemsPeople,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _peopleList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<List<People>> fetchpeople() async {
  final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
  if (response.statusCode == 200) {
    return PeopleResponse.fromJson(jsonDecode(response.body)).results;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _peopleList(List<People> peopleList) {
  return SizedBox(
    height: 330,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: peopleList.length,
      itemBuilder: (context, index) {
        return _peopleItem(peopleList.elementAt(index));
      },
    ),
  );
}

Widget _peopleItem(People people) {
  List<String> urlFotoPeople = people.url.split('/');
  String fotoPeople = urlFotoPeople[5];
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 270.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.all(15),
        elevation: 10,
        child: Container(
          width: 170.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(children: <Widget>[
                Image(
                  image: NetworkImage(
                      'https://starwars-visualguide.com/assets/img/characters/${fotoPeople}.jpg'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(people.name),
                ),
              ])),
        ),
      ));
}

Future<List<Planet>> fetchplanets() async {
  final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
  if (response.statusCode == 200) {
    return PlanetResponse.fromJson(jsonDecode(response.body)).results;
  } else {
    throw Exception('Failed to load planet');
  }
}

Widget _planetList(List<Planet> planetList) {
  return SizedBox(
    height: 300,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planetList.length,
      itemBuilder: (context, index) {
        return _planetItem(planetList.elementAt(index));
      },
    ),
  );
}

Widget _planetItem(Planet planet) {
  List<String> urlFotoPlanet = planet.url.split('/');
  String fotoPlanet = urlFotoPlanet[5];
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 270.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.all(15),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 170.0,
            child: Column(children: <Widget>[
              Image(
                image: NetworkImage(
                    'https://starwars-visualguide.com/assets/img/planets/${fotoPlanet}.jpg'),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(planet.name),
              ),
            ]),
          ),
        ),
      ));
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  late Future<List<Planet>> itemsPlanet;

  @override
  void initState() {
    itemsPlanet = fetchplanets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Star-wars API',
              style: TextStyle(color: Colors.yellow)),
          iconTheme: IconThemeData(color: Colors.yellow),
          backgroundColor: Colors.black),
      drawer: Drawer(
        backgroundColor: Color(0xFFD3D3D3),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 126,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text('Menu', style: TextStyle(color: Colors.yellow)),
              ),
            ),
            ListTile(
              title: const Text('Personajes'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: "Personajes")));
              },
            ),
            ListTile(
              title: const Text('Planetas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: 300,
        child: FutureBuilder<List<Planet>>(
          future: itemsPlanet,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _planetList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
