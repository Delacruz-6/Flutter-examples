import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/image_pick_bloc/image_pick_bloc_bloc.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_state.dart';
//import 'package:flutter_miarmapp/bloc/register_bloc/register_event.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepositoryImpl.dart';

import 'package:flutter_miarmapp/screens/login_screen.dart';
import 'package:flutter_miarmapp/widgets/checkbox.dart';
import 'package:flutter_miarmapp/widgets/formRegister.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _pass2controller = TextEditingController();
  final TextEditingController _fechacontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();
  final TextEditingController _telefonocontroller = TextEditingController();
  late TextEditingController _tipocontroller = TextEditingController();
  late String tipoPerfil = '';
  late String tipo = '';
  late String photo = '';
  String _dropdownValue = 'PUBLICO';
  DateTime fecha = DateTime.now();

  bool _isloading = false;

  File? avatar = null;

  final _formKey = GlobalKey<FormState>();

  List<XFile>? _imageFileList;
  final format = DateFormat("yyyy-MM-dd");
  late AuthRepository authRepository;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _emailcontroller.text = 'pepes@sales.com';
    _passcontroller.text = 'Pepe.344';
    _pass2controller.text = 'Pepe.344';
    _usercontroller.text = "pepelu";
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return RegisterBloc(authRepository);
        },
        child: _createBody(context));
  }

  Widget buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            body: BlocProvider(
                create: (context) {
                  return ImagePickBlocBloc();
                },
                child: BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                    listenWhen: (context, state) {
                      return state is ImageSelectedSuccessState;
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return state is ImagePickBlocInitial ||
                          state is ImageSelectedSuccessState;
                    },
                    builder: (context, state) {
                      if (state is ImageSelectedSuccessState) {
                        print('PATH ${state.pickedFile.path}');
                        photo = state.pickedFile.path;

                        return SingleChildScrollView(
                            child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 55, bottom: 20),
                              child: Text(
                                'Miarmapp',
                                style: TextStyle(
                                  fontFamily: 'Billabong',
                                  color: Colors.black,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  new FileImage(File(state.pickedFile.path)),
                              radius: 50.0,
                            ),
                            Text('Indique su fecha de nacimiento',
                                style: TextStyle(color: Colors.grey)),
                            DateTimeField(
                              controller: _fechacontroller,
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime(2003),
                                    lastDate: DateTime(2100));
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              child: TextFormField(
                                controller: _emailcontroller,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              child: TextFormField(
                                controller: _usercontroller,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              child: TextFormField(
                                controller: _passcontroller,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              child: TextFormField(
                                controller: _pass2controller,
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
                            TextField(
                              controller: _telefonocontroller,
                              decoration: new InputDecoration(
                                  labelText: "Introduce tu teléfono"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                            DropdownButton(
                              dropdownColor: Colors.blue.shade200,
                              value: _dropdownValue,
                              items: [
                                DropdownMenuItem(
                                    child: Text("Publico"), value: "PUBLICO"),
                                DropdownMenuItem(
                                  child: Text("Privado"),
                                  value: "PRIVADO",
                                )
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _dropdownValue = newValue!;
                                });
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ImagePickBlocBloc>(context).add(
                                    const SelectImageEvent(
                                        ImageSource.gallery));
                              },
                              child: Text('Subir foto perfil',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            SizedBox(
                                height: 50, //height of button
                                width: 300, //width of button
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      final registerDto = RegisterDto(
                                        email: _emailcontroller.text,
                                        password: _passcontroller.text,
                                        password2: _pass2controller.text,
                                        fechaNacimiento: _fechacontroller.text,
                                        telefono:
                                            int.parse(_telefonocontroller.text),
                                        tipo: _tipocontroller.text,
                                        username: _usercontroller.text,
                                      );
                                      BlocProvider.of<RegisterBloc>(context)
                                          .add(DoRegisterEvent(
                                              registerDto, photo));
                                    }
                                  },
                                  child: Text('Registrarse'),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ));
                      }
                    }))));
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: BlocConsumer<RegisterBloc, RegisterState>(
                listenWhen: (context, state) {
          return state is RegisterSuccessState || state is RegisterErrorState;
        }, listener: (context, state) async {
          if (state is RegisterSuccessState) {
            navigatorToSignIn();
          } else if (state is RegisterErrorState) {
            _showSnackbar(context, state.message);
          }
        }, buildWhen: (context, state) {
          return state is RegisterInitialState || state is RegisterLoadingState;
        }, builder: (ctx, state) {
          if (state is RegisterInitialState) {
            return buildForm(ctx);
          } else if (state is RegisterLoadingState) {
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
}
