import 'package:fudo_challenge/data/dto/post_dto.dart';
import 'package:fudo_challenge/domain/entity/post.dart';

class PostMapper {
  static Post fromPostDto(PostDto postDto) {
    return Post(
      id: postDto.id,
      title: postDto.title,
      body: postDto.body,
    );
  }

  static PostDto toPostDto(Post post) {
    return PostDto(
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }
}
