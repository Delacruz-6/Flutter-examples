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
          //primarySwatch: Colors.orange,
          ),
      home: const MyHomePage(
        title: 'Login',
        subtitle: 'Beautiful, private sharing',
        content1: 'Already have a Path account?',
        content2: 'By using Path, you agree to Paths\n ',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content1,
    required this.content2,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String content1;
  final String content2;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE62F16),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
                image: AssetImage('assets/images/logo.png'), width: 240),
            Text(
              widget.subtitle,
              style:
                  TextStyle(color: Colors.white.withOpacity(.4), fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 120)),
            OutlinedButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                  primary: const Color(0xFFE62F16),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  backgroundColor: Colors.white),
              onPressed: () {
                // Respond to button press
              },
              child: Text("Sign Up"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                widget.content1,
                style: TextStyle(
                    color: Colors.white.withOpacity(.4), fontSize: 15),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            OutlinedButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(82, 15, 82, 15),
                  primary: Colors.white30,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  side: BorderSide(color: Colors.white30, width: 1)),
              onPressed: () {
                // Respond to button press
              },
              child: Text("Log In"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: widget.content2,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.4), fontSize: 15),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white)),
                    TextSpan(text: ' and '),
                    TextSpan(
                        text: 'privacy policy.',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
