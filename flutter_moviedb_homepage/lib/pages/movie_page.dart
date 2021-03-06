import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moviedb_homepage/models/movies.dart';

import 'package:http/http.dart' as http;

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Movie>> itemsMovies;

  @override
  // ignore: override_on_non_overriding_member
  void initState() {
    super.initState();
    itemsMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: itemsMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _MoviesList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=531a3f7a778e7bae353f18eb81f1e379&language=en-US&page=1'));
  if (response.statusCode == 200) {
    return MoviesResponse.fromJson(jsonDecode(response.body)).results;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _MoviesList(List<Movie> MoviesList) {
  return SizedBox(
    height: 350,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: MoviesList.length,
      itemBuilder: (context, index) {
        return _MoviesItem(MoviesList.elementAt(index));
      },
    ),
  );
}

Widget _MoviesItem(Movie Movie) {
  /*
    List<String> urlFotoPeople = people.url.split('/');
    String fotoPeople = urlFotoPeople[5];
    */
  return Column(
    children: [
      Container(
          //margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 300.0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.all(10),
            elevation: 10,
            child: Container(
              width: 150.0,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Column(children: <Widget>[
                      Container(
                        child: Image(
                          image: NetworkImage(
                              'https://www.themoviedb.org/t/p/original/${Movie.posterPath}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(Movie.title,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.star_rate, color: Colors.yellow),
                            Text(Movie.voteAverage.toString())
                          ])
                    ])),
              ),
            ),
          )),
    ],
  );
}
