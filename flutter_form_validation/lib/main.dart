import 'package:flutter/material.dart';
import 'package:flutter_form_validation/pages.dart/home.dart';
import 'package:flutter_form_validation/pages.dart/login.dart';
import 'package:flutter_form_validation/pages.dart/register.dart';

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
          primarySwatch: Colors.red, backgroundColor: Colors.grey.shade300),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
