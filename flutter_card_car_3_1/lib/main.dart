// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

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
          scaffoldBackgroundColor: const Color(0xFF999999)),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Card(
              child: SizedBox(
            width: 400,
            height: 260,
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const <Widget>[
                            Text(
                              'El más barato, buena puntuación',
                              textAlign: TextAlign.start,
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            SizedBox(width: 80),
                            Text(
                              '45 ofertas',
                              textAlign: TextAlign.end,
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        Container(
                          child: const Image(
                              image: AssetImage('assets/images/car1.png')),
                          width: 200,
                        ),
                        Container(
                            padding: EdgeInsets.only(right: 310),
                            child: const Text(
                              'Tesla',
                              style: TextStyle(color: Colors.black),
                            )),
                        Container(
                            padding:
                                EdgeInsets.only(right: 182, bottom: 5, top: 5),
                            child: const Text(
                              'Tesla - model S - eléctrico',
                              style: TextStyle(color: Colors.grey),
                            )),
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 5),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/marchas.png'),
                                  width: 15),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9),
                              child: Text(
                                'Man.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.ac_unit,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9, right: 4),
                              child: Text(
                                'A/A',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9, right: 18),
                              child: Text(
                                '4',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Icon(
                              Icons.home_repair_service,
                              color: Colors.grey,
                              size: 15,
                            ),
                            SizedBox(width: 8),
                            Padding(
                              padding: EdgeInsets.only(left: 4, right: 4),
                              child: Text(
                                '1',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(width: 130),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SizedBox(
                            height: 1,
                            width: 350,
                            child: new Center(
                              child: new Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 1.0, end: 1.0),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 100),
                              child: TextButton(
                                child: const Text('35€'),
                                onPressed: () {/* ... */},
                              ),
                            ),
                            //const SizedBox(width: 200),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 80, right: 15),
                              child: TextButton(
                                child: const Text('SELECCIONAR'),
                                onPressed: () {/* ... */},
                              ),
                            ),
                            //const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          )),
        ));
  }
}
