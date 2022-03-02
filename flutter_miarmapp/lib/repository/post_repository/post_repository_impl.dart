import 'dart:convert';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<PostPublic>> fetchpostPublic(String type) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('prueba token:${token}');
    //prefs.clear();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    final response = await _client
        .get(Uri.parse('${Constant.BaseUrl}/post/public'), headers: headers);
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load posts');
    }
  }
}
