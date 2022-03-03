import 'package:flutter_miarmapp/models/auth/login_dto.dart';
import 'package:flutter_miarmapp/models/auth/login_response.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);

  Future<RegisterResponse> register(RegisterDto registerDto, String image);
}
