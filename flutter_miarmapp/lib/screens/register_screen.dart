import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  bool _isloading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
  }

  void navigatorToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            body: SingleChildScrollView(
                child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: Text(
                    'Miarmapp',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      color: Colors.black,
                      fontSize: 50,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Correo electronico',
                        labelText: 'Correo electronico'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email incorrecto';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nombre de usuario',
                        labelText: 'Nombre de usuario'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username incorrecto';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contraseña',
                        labelText: 'Contraseña'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contraseña incorrecta';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Repetir ontraseña',
                        labelText: 'Repetir contraseña'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contraseña incorrecta';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                    height: 50, //height of button
                    width: 300, //width of button
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, "/login");

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Registrarse'),
                    )),
                const Divider(
                  height: 40,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("¿Estas registrado?"),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    GestureDetector(
                      onTap: navigatorToSignIn,
                      child: Container(
                        child: const Text(
                          " Inicia sesión",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ))));
  }
}
