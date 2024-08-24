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

  Future<List<PostDto>> searchPosts({required int userId}) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts?userId=$userId');
      return (response.data as List).map((post) => PostDto.fromJson(post)).toList();
    } catch (e) {
      rethrow;
    }
  }
}