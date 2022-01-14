import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Viaje a Londres';
  static const String _subtitle = '\n11-14 marzo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: RichText(
            text: const TextSpan(
              text: _title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: _subtitle, style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {/* Write listener code here */},
            child: const Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.share,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )),
          ],
        ),
        body: const MyStatelessWidget(),
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 300.0, left: 5, right: 5),
        height: 480,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //margin: EdgeInsets.all(15),

            child: Padding(
              padding: EdgeInsets.only(top: 30.0, left: 15),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.v,
                children: <Widget>[
                  Column(children: [
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          text: '20:35',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38),
                          children: <TextSpan>[
                            TextSpan(
                                text: '\nSALIDA',
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          text: '23:00',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38),
                          children: <TextSpan>[
                            TextSpan(
                                text: '\nENTRADA',
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    )
                  ]),
                  // const SizedBox(width: 50),

                  Padding(padding: EdgeInsets.only(left: 80)),
                  Center(
                    child: Column(
                      children: [
                        Column(children: <Widget>[
                          Center(
                            child: RichText(
                                text: const TextSpan(
                              text: 'Madrid',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "\nIberia 10294",
                                    style: TextStyle(fontSize: 14)),
                                TextSpan(
                                    text: '\nDuración 2h 10m',
                                    style: TextStyle(fontSize: 14))
                              ],
                            )),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20, left: 5)),
                          Center(
                            child: RichText(
                                text: const TextSpan(
                              text: 'Londres',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                            )),
                          ),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
