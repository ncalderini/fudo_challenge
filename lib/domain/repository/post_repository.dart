import 'package:fudo_challenge/data/source/network/post_api.dart';
import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/mappers/post_mapper.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class PostRepositoryImpl implements PostRepository {
  final PostApi _api;

  PostRepositoryImpl({
    required PostApi api,
  })  : _api = api;

  @override
  Future<List<Post>> getPosts() async {
    final fetchedList = await _api.getPosts();
    return fetchedList.map((post) => PostMapper.fromPostDto(post)).toList();
  }
}