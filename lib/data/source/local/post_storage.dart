import 'dart:convert';

import 'package:fudo_challenge/data/dto/post_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostStorage {
  Future<void> savePosts(List<PostDto> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = json.encode(posts);
    await prefs.setString('posts', postsJson);
  }

  Future<List<PostDto>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = prefs.getString('posts');
      if (response != null) {
        return (json.decode(response) as List)
            .map((post) => PostDto.fromJson(post))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
