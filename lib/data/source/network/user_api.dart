import 'package:dio/dio.dart';
import 'package:fudo_challenge/data/dto/user_dto.dart';

class UserApi {
  final Dio _dio = Dio();

  Future<UserDto> getUser({required String name}) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users?name=$name');
      return UserDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}