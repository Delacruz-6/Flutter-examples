part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserWithType extends UserEvent {
  final String type;

  const FetchUserWithType(this.type);

  @override
  List<Object> get props => [type];
}
