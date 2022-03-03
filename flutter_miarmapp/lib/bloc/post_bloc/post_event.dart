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

class DoRegisterEvent extends PostsEvent {
  final PostDto registerDto;

  final String image;

  const DoRegisterEvent(this.registerDto, this.image);
}
