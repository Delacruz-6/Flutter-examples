import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_miarmapp/models/auth/login_dto.dart';
import 'package:flutter_miarmapp/models/auth/login_response.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepositoryImpl.dart';
import 'package:flutter_miarmapp/screens/home_screen.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:flutter_miarmapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    emailController.text = 'pepes@sales.com';
    passwordController.text = 'Pepe.344';
    authRepository = AuthRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
          return state is LoginSuccessState || state is LoginErrorState;
        }, listener: (context, state) async {
          if (state is LoginSuccessState) {
            _login(context, state.loginResponse);
          } else if (state is LoginErrorState) {
            _showSnackbar(context, state.message);
          }
        }, buildWhen: (context, state) {
          return state is LoginInitialState || state is LoginLoadingState;
        }, builder: (ctx, state) {
          if (state is LoginInitialState) {
            return buildForm(ctx);
          } else if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return buildForm(ctx);
          }
        })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Future<void> _login(BuildContext context, login) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('token', login.token);
      print(prefs.getString('token'));
      navigatorToSignin();
    });
  }

  Widget buildForm(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 60),
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
                    controller: emailController,
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
                    obscureText: true,
                    controller: passwordController,
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
                SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final loginDto = LoginDto(
                              email: emailController.text,
                              password: passwordController.text);
                          BlocProvider.of<LoginBloc>(context)
                              .add(DoLoginEvent(loginDto));
                        }
                      },
                      child: const Text('Iniciar sesión'),
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
