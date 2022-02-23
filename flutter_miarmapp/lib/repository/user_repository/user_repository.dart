import 'package:flutter_miarmapp/models/user/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> fetchUserOne(String type);
}
