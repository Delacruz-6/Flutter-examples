// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.red,
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      'Registrate en nuestra App',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                  child: Center(
                    child: Text(
                      'Ingreses sus datos',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        onPressed: () {},
                        child: TextFormField(
                            keyboardType: TextInputType
                                .emailAddress, // Use email input type for emails.
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: 'Su_miguelito_69@hotmail.com',
                                labelText: 'Correo electrónico')),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 10)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colors.white)))))),
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        onPressed: () {},
                        child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: 'Michael',
                                labelText: 'Nombre usuario')),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 10)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colors.white)))))),
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        onPressed: () {},
                        child: TextFormField(
                            obscureText: true, // Use secure text for passwords.
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                hintText: 'Contraseña.Segura100',
                                labelText: 'Contraseña:')),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 10)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colors.white)))))),
                Container(
                  width: screenSize.width,
                  child: TextButton(
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.red),
                      ),
                      // ignore: avoid_returning_null_for_void
                      onPressed: () => null,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade100),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 10)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )))),
                  margin: const EdgeInsets.only(top: 20.0),
                ),
                Container(
                    child: Center(
                        child: const Text(
                  '¿Ya dispone de cuenta?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic, // italic
                  ),
                ))),
                TextButton(
                  // Within the `FirstScreen` widget
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ],
            ),
          )),
    );
  }
}
