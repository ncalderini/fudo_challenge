import 'package:shared_preferences/shared_preferences.dart';

class LoginUserUseCase {
  const LoginUserUseCase();

  Future<bool> call() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool('authenticated', true);
  }
}