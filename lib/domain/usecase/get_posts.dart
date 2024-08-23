import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/repository/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  Future<List<Post>> call() async {
    return _postRepository.getPosts();
  }
}