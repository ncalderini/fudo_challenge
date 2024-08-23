import 'package:equatable/equatable.dart';
import 'package:fudo_challenge/domain/entity/post.dart';

enum PostStatus { initial, success, failure }

final class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
  });

  final PostStatus status;
  final List<Post> posts;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts];
}