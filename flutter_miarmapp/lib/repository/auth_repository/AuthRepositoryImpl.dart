import 'dart:convert';

import 'package:flutter_miarmapp/models/auth/login_dto.dart';
import 'package:flutter_miarmapp/models/auth/login_response.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await _client.post(
        Uri.parse('${Constant.BaseUrl}/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}

@override
Future<RegisterResponse> register(
    RegisterDto registerDto, String imagePath) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var uri = Uri.parse('http://10.0.2.2:8080/auth/register');
  var request = http.MultipartRequest('POST', uri);
  request.fields['telefono'] = prefs.getInt('telefono').toString();
  request.fields['username'] = prefs.getString('username').toString();
  request.fields['email'] = prefs.getString('email').toString();
  request.fields['fechaNacimiento'] =
      prefs.getString('fechaNacimiento').toString();
  request.fields['tipoPerfil'] = prefs.getString('tipoPerfil').toString();
  request.fields['password'] = prefs.getString('password').toString();
  request.fields['password2'] = prefs.getString('password2').toString();
  request.files.add(await http.MultipartFile.fromPath(
      'file', prefs.getString('file').toString()));

  var response = await request.send();

  if (response.statusCode == 201) {
    print('Usuario ${prefs.getString('username')} Registrado');
    return RegisterResponse.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    print(response.statusCode);
    throw Exception('Fail to register');
  }
}
