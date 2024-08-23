import 'package:fudo_challenge/data/source/local/post_storage.dart';
import 'package:fudo_challenge/data/source/network/post_api.dart';
import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/exceptions/internet_exception.dart';
import 'package:fudo_challenge/domain/mappers/post_mapper.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class PostRepositoryImpl implements PostRepository {
  final PostApi _api;
  final PostStorage _storage;

  PostRepositoryImpl({
    required PostApi api,
    required PostStorage storage,
  })  : _api = api,
        _storage = storage;

  @override
  Future<List<Post>> getPosts() async {
    try {
      //Simulate slow network
      await Future.delayed(const Duration(seconds: 5));
      
      final fetchedList = await _api.getPosts();
      if (fetchedList.isNotEmpty) {
        await _storage.savePosts(fetchedList);
      }
      return fetchedList.map((post) => PostMapper.fromPostDto(post)).toList();
    } catch (_) {
      final cachedPosts = (await _storage.getPosts())
        .map((post) => PostMapper.fromPostDto(post))
        .toList();
      throw InternetException(cachedData: cachedPosts);
    } 
  }
}
