import 'package:fudo_challenge/data/source/network/user_api.dart';
import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/repository/post_repository.dart';

class SearchPostsUseCase {
  final PostRepository _postRepository;
  final UserApi _userApi;

  SearchPostsUseCase(this._postRepository, this._userApi);

  Future<List<Post>> call({required String name}) async {
    final user = await _userApi.getUser(name: name);
    return _postRepository.searchPosts(userId: user.id);
  }
}