import 'dart:convert';
import 'package:flutter_miarmapp/models/post/post_dto.dart';
import 'package:flutter_miarmapp/models/post/post_one_response.dart';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'post_repository.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

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

  @override
  Future<PostOneResponse> createPost(PostDto postDto, String image) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('prueba token:${token}');
    //prefs.clear();
    Map<String, String> headers = {'Authorization': 'Bearer ${token}'};
    var uri = Uri.parse('${Constant.BaseUrl}/post/');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', image,
          contentType: MediaType('multipart', 'form-data')))
      ..files.add(await http.MultipartFile.fromString(
          'newPost', jsonEncode(postDto.toJson()),
          contentType: MediaType('application', 'json')));

    request.headers.addAll(headers);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return PostOneResponse.fromJson(await jsonDecode(respStr));
    } else {
      print(response.statusCode);
      throw Exception('Fail to create post');
    }
  }
}
