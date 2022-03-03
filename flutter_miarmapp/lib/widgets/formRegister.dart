import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/image_pick_bloc/image_pick_bloc_bloc.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepositoryImpl.dart';

import 'package:flutter_miarmapp/screens/login_screen.dart';
import 'package:flutter_miarmapp/widgets/checkbox.dart';
import 'package:flutter_miarmapp/widgets/formRegister.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({Key? key}) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _pass2controller = TextEditingController();
  final TextEditingController _fechacontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();
  final TextEditingController _telefonocontroller = TextEditingController();
  late TextEditingController _tipocontroller = TextEditingController();
  String _dropdownValue = 'PUBLICO';
  String path = "";

  void navigatorToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return SingleChildScrollView(
        child: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
              decoration:
                  new InputDecoration(labelText: "Introduce tu teléfono"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            DropdownButton(
              dropdownColor: Colors.blue.shade200,
              value: _dropdownValue,
              items: [
                DropdownMenuItem(child: Text("Publico"), value: "PUBLICO"),
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
                BlocProvider.of<ImagePickBlocBloc>(context)
                    .add(const SelectImageEvent(ImageSource.gallery));
              },
              child: Text('Subir foto perfil',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
                height: 50, //height of button
                width: 300, //width of button
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    // Validate returns true if the form is valid, or false otherwise.

                    final registerDto = RegisterDto(
                        email: _emailcontroller.text,
                        password: _passcontroller.text,
                        password2: _pass2controller.text,
                        fechaNacimiento: _fechacontroller.text,
                        telefono: int.parse(_telefonocontroller.text),
                        tipo: _tipocontroller.text,
                        username: _usercontroller.text);
                    BlocProvider.of<RegisterBloc>(context)
                        .add(DoRegisterEvent(registerDto, path));

                    prefs.setInt(
                        'telefono', int.parse(_telefonocontroller.text));
                    prefs.setString('username', _usercontroller.text);
                    prefs.setString('email', _emailcontroller.text);
                    prefs.setString('fechaNacimiento', _fechacontroller.text);
                    prefs.setString('perfil', _tipocontroller.text);
                    prefs.setString('password', _passcontroller.text);
                    prefs.setString('password2', _pass2controller.text);

                    Navigator.pushNamed(context, '/login');
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
    ));
  }
}
