import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/screens/edit_profile_screen.dart';
import 'package:flutter_miarmapp/screens/login_screen.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:flutter_miarmapp/screens/prueba_image.dart';
import 'package:flutter_miarmapp/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiarmApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/menu': (context) => const MenuScreen(),
        '/register': (context) => const RegisterScreen(),
        '/editProfile': (context) => const EditProfileScreen(),
      },
    );
  }
}
