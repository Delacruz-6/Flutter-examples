import 'package:flutter/material.dart';

import 'movie_page.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/img/foto1.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Guillermo De la cruz'),
                    )
                  ],
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.grey,
                  textColor: Colors.white,
                  child:
                      Icon(Icons.cast, size: 20, color: Colors.grey.shade300),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(right: 150, bottom: 15, top: 15),
            child: const Text(
              'Movie, Series,\nTV Shows...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 270, bottom: 15, top: 15),
            child: const Text(
              'Newest',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const MoviesPage(),
          Padding(
            padding: const EdgeInsets.only(right: 270, bottom: 15, top: 15),
            child: const Text(
              'Popular',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const MoviesPage(),
        ],
      ),
    );
  }
}
