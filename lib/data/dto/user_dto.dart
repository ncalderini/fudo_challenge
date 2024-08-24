import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
final class UserDto extends Equatable {
  const UserDto({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  final int id;
  final String name;
  final String username;
  final String email;

  @override
  List<Object> get props => [id, name, username, email];

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
