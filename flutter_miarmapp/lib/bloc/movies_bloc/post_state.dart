part of 'post_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostsState {}

class PostsFeched extends PostsState {
  final List<PostPublic> posts;
  final String type;

  const PostsFeched(this.posts, this.type);

  @override
  List<Object> get props => [posts];
}

class PostsFechedError extends PostsState {
  final String message;
  const PostsFechedError(this.message);

  @override
  List<Object> get props => [message];
}
