import 'package:shared_preferences/shared_preferences.dart';

class IsUserAuthenticatedUseCase { 
  const IsUserAuthenticatedUseCase();

  Future<bool> call() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('authenticated') ?? false;
  }
}