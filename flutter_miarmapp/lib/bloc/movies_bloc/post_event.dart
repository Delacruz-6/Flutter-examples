part of 'post_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPostWithType extends PostsEvent {
  final String type;

  const FetchPostWithType(this.type);

  @override
  List<Object> get props => [type];
}
