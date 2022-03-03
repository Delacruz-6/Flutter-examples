import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';
import 'package:flutter_miarmapp/repository/auth_repository/AuthRepository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doLoginEvent);
  }

  void _doLoginEvent(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final loginResponse =
          await authRepository.register(event.registerDto, event.imagePath);
      emit(RegisterSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
