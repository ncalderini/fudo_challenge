import 'package:shared_preferences/shared_preferences.dart';

class IsUserAuthenticatedUseCase {
  
  const IsUserAuthenticatedUseCase();

  Future<bool> call() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('authenticated') ?? false;
  }
}