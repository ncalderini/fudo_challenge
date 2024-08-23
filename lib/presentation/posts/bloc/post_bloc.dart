import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fudo_challenge/domain/exceptions/internet_exception.dart';
import 'package:fudo_challenge/domain/usecase/get_posts.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_event.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_state.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;

  PostBloc({required this.getPostsUseCase}) : super(const PostState()) {
    on<FetchPosts>(_onPostFetched);
  }

  Future<void> _onPostFetched(FetchPosts event, Emitter<PostState> emit) async {
    try {
      if (state.status == PostStatus.initial) {
        final posts = await getPostsUseCase();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
          ),
        );
      }
    } catch (exception) {
      if (exception is InternetException) {
        return emit(
          state.copyWith(
            status: PostStatus.failure,
            posts: exception.cachedData,
          ),
        );
      }
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}