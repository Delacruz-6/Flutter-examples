import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';

import 'package:flutter_miarmapp/repository/auth_repository/AuthRepository.dart';

import 'register_state.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitialState()) {
    on<DoRegisterEvent>(_doRegisterEvent);
  }

  void _doRegisterEvent(
      DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final RegisterResponse =
          await authRepository.register(event.registerDto, event.image);
      emit(RegisterSuccessState(RegisterResponse, event.image));
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
