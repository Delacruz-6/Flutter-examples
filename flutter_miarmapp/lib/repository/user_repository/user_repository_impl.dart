import 'dart:convert';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:flutter_miarmapp/models/user/user_response.dart';
import 'package:http/http.dart';
import '../constants.dart';
import 'user_repository.dart';

abstract class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<UserResponse> fetchUserOne(String type) async {
    final response = await _client.get(Uri.parse('${Constant.BaseUrl}/me'));
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load user');
    }
  }
}
