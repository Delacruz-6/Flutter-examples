import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(5),
                elevation: 10,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: 580.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Image(
                              image: AssetImage('assets/img/logo.png'),
                              width: 540),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            '¡Bienvenido a esta App!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Text(
                            'Acceda de cualquiera de los dos metodos proporcionados',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 100, horizontal: 45),
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: OutlinedButton(
                                    // Within the `FirstScreen` widget
                                    onPressed: () {
                                      // Navigate to the second screen using a named route.
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: const Text('Login'),
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: OutlinedButton(
                                    // Within the `FirstScreen` widget
                                    onPressed: () {
                                      // Navigate to the second screen using a named route.
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: const Text('Register'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
