// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';
import 'package:flutter_miarmapp/repository/constants.dart';
import 'package:flutter_miarmapp/repository/register_repository/register_repository.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class RegisterRepositoryImpl extends RegisterRepository {
  final Client _client = Client();

  @override
  Future<RegisterResponse> register(RegisterDto registerDto, filePath) async {
    final postUri = Uri.parse('${Constant.BaseUrl}/auth/register');

    final request = http.MultipartRequest("POST", postUri);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response2 = await request.send();

    final response = await _client.post(
        Uri.parse('${Constant.BaseUrl}/auth/register'),
        headers: headers,
        body: jsonEncode(registerDto.toJson()));

    if (response2.statusCode == 201 && response.statusCode == 201) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to register');
    }
  }
}
