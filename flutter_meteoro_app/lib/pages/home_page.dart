import 'package:flutter/material.dart';

//import 'movie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
              child: Text(
            'que tal',
          )),
          //MoviesPage(),
        ],
      ),
    );
  }
}
