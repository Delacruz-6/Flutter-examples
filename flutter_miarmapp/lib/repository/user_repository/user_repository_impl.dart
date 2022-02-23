import 'dart:convert';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:flutter_miarmapp/models/user/user_response.dart';
import 'package:http/http.dart';
import '../constants.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<UserResponse> fetchUserOne(String type) async {
    final response =
        await _client.get(Uri.parse('${Constant.BaseUrl}/me'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNjQ1NzQwOTEwLCJ1c2VybmFtZSI6IkFydHVyaXRvIiwicm9sIjoiUFVCTElDTyJ9.0zR2lkkwqbp9IXVk6jxoEAkliFUinFDCoiC4dAmn7Oo'
    });
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load user');
    }
  }
}
