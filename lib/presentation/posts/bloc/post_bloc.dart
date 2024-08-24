import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fudo_challenge/domain/exceptions/internet_exception.dart';
import 'package:fudo_challenge/domain/usecase/get_posts.dart';
import 'package:fudo_challenge/domain/usecase/search_posts.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_event.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  final SearchPostsUseCase searchPostsUseCase;

  PostBloc({required this.getPostsUseCase, required this.searchPostsUseCase})
      : super(const PostState()) {
    on<FetchPosts>(_onPostFetched);
    on<SearchPosts>(_onPostSearched);
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

  Future<void> _onPostSearched(
      SearchPosts event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.initial));
      final posts = event.query.isEmpty 
        ? await getPostsUseCase() 
        : await searchPostsUseCase(name: event.query);
      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: posts,
        ),
      );
    } catch (exception) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
