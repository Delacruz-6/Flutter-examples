import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/user/user_response.dart';
import 'package:flutter_miarmapp/repository/user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUserWithType>(_userFetched);
  }

  void _userFetched(FetchUserWithType event, Emitter<UserState> emit) async {
    try {
      final user = await userRepository.fetchUserOne(event.type);
      emit(UserFeched(user, event.type));
      return;
    } on Exception catch (e) {
      emit(UserFechedError(e.toString()));
    }
  }
}
