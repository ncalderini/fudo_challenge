import 'package:dio/dio.dart';
import 'package:fudo_challenge/data/dto/post_dto.dart';

class PostApi {
  final Dio _dio = Dio();

  Future<List<PostDto>> getPosts() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      return (response.data as List).map((post) => PostDto.fromJson(post)).toList();
    } catch (e) {
      rethrow;
    }
  }
}