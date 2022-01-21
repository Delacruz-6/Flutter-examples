import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starwar_menu_bottom_navigation/models/players.dart';

import 'package:http/http.dart' as http;

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  late Future<List<Player>> itemsPlayers;

  @override
  // ignore: override_on_non_overriding_member
  void initState() {
    super.initState();
    itemsPlayers = fetchplayers();
    //
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
      future: itemsPlayers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _playersList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<List<Player>> fetchplayers() async {
  final response =
      await http.get(Uri.parse('https://www.balldontlie.io/api/v1/players'));
  if (response.statusCode == 200) {
    return PlayersResponse.fromJson(jsonDecode(response.body)).data;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _playersList(List<Player> playersList) {
  return SizedBox(
    height: 330,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: playersList.length,
      itemBuilder: (context, index) {
        return _playersItem(playersList.elementAt(index));
      },
    ),
  );
}

Widget _playersItem(Player player) {
  /*
    List<String> urlFotoPeople = people.url.split('/');
    String fotoPeople = urlFotoPeople[5];
    */
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
                /*
                  Image(
                    image: NetworkImage(
                        'https://starwars-visualguide.com/assets/img/characters/${fotoPeople}.jpg'),
                  ),
                  */
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Text(player.firstName),
                    Text(player.lastName)
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Text(player.team.fullName),
                    Text(player.position)
                  ]),
                )
              ])),
        ),
      ));
}
