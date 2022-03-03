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
import 'package:http_parser/http_parser.dart';

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

  @override
  Future<RegisterResponse> register(
      RegisterDto registerDto, String image) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var uri = Uri.parse('${Constant.BaseUrl}/auth/register/user');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', image,
          contentType: MediaType('multipart', 'form-data')))
      ..files.add(await http.MultipartFile.fromString(
          'user', jsonEncode(registerDto.toJson()),
          contentType: MediaType('application', 'json')));

    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(await jsonDecode(respStr));
    } else {
      print(response.statusCode);
      throw Exception('Fail to register');
    }
  }
}
