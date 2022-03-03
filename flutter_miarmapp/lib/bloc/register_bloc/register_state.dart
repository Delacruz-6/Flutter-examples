import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterResponse registerResponse;
  final String image;

  const RegisterSuccessState(this.registerResponse, this.image);

  @override
  List<Object> get props => [RegisterResponse];
}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState(this.message);

  @override
  List<Object> get props => [message];
}
