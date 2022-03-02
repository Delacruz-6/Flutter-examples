part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class ImagePickBlocInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final XFile pickedFile;
  final RegisterResponse registerResponse;

  const RegisterSuccess(this.pickedFile, this.registerResponse);

  @override
  List<Object> get props => [pickedFile, registerResponse];
}

class ImageSelectedErrorState extends RegisterState {
  final String message;

  const ImageSelectedErrorState(this.message);

  @override
  List<Object> get props => [message];
}
