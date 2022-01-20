import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starwar_http/models/people.dart';
import 'package:flutter_starwar_http/models/planet.dart';

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
  late Future<List<Planet>> itemsPlanet;

  @override
  void initState() {
    itemsPeople = fetchpeople();
    itemsPlanet = fetchplanets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.public)),
                ],
              ),
              title: const Text('Tabs Demo'),
            ),
            body: const TabBarView(children: [

              /**
               *       FutureBuilder<List<People>>(
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
      FutureBuilder<List<Planet>>(
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
               * 
               * 
               * 
               * /
            ])));
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
      height: 350,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
}
