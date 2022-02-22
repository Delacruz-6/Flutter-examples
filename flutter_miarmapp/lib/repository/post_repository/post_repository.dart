import 'package:flutter_miarmapp/models/post/post_response.dart';

abstract class PostRepository {
  Future<List<PostPublic>> fetchpostPublic(String type);
}
