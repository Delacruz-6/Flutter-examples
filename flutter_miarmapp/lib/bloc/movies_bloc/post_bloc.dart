import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPostWithType>(_postsFetched);
  }

  void _postsFetched(FetchPostWithType event, Emitter<PostsState> emit) async {
    try {
      final posts = await postRepository.fetchpostPublic(event.type);
      emit(PostsFeched(posts, event.type));
      return;
    } on Exception catch (e) {
      emit(PostsFechedError(e.toString()));
    }
  }
}
