import 'package:flutter_miarmapp/models/post/post_dto.dart';
import 'package:flutter_miarmapp/models/post/post_one_response.dart';
import 'package:flutter_miarmapp/models/post/post_response.dart';

abstract class PostRepository {
  Future<List<PostPublic>> fetchpostPublic(String type);

  Future<PostOneResponse> createPost(PostDto registerDto, String image);
}
