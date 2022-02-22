import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:flutter_miarmapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void navigatorToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  void navigatorToSignin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MenuScreen(),
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
                  padding: const EdgeInsets.only(top: 40, bottom: 60),
                  child: Text(
                    'Miarmapp',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      color: Colors.black,
                      fontSize: 80,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                        labelText: 'Correo electrónico'),
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
                GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          Navigator.pushNamed(context, "/menu");
                        });
                      }
                    },
                    child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, "/menu");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Cargando datos')),
                              );
                            }
                          },
                          child: const Text('Iniciar sesión'),
                        ))),
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
                      child: const Text("¿No estas registrado?"),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    GestureDetector(
                      onTap: navigatorToSignUp,
                      child: Container(
                        child: const Text(
                          " Registrate",
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
