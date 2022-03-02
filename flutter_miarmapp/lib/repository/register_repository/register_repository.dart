import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';

abstract class RegisterRepository {
  Future<RegisterResponse> register(RegisterDto registerDto, filePath);
}
