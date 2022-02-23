part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFeched extends UserState {
  final UserResponse user;
  final String type;

  const UserFeched(this.user, this.type);

  @override
  List<Object> get props => [user];
}

class UserFechedError extends UserState {
  final String message;
  const UserFechedError(this.message);

  @override
  List<Object> get props => [message];
}
