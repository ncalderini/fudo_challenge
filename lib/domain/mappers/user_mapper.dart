import 'package:fudo_challenge/data/dto/user_dto.dart';
import 'package:fudo_challenge/domain/entity/user.dart';

class PostMapper {
  static User fromUserDto(UserDto userDto) {
    return User(
      id: userDto.id,
      name: userDto.name,
      username: userDto.username,
      email: userDto.email,
    );
  }

  static UserDto toUserDto(User user) {
    return UserDto(
      id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
    );
  }
}