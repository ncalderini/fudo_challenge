import 'package:shared_preferences/shared_preferences.dart';

class IsUserAuthenticatedUseCase {
  
  IsUserAuthenticatedUseCase({
    required SharedPreferences sharedPreferences,
  }) : _prefs = sharedPreferences;

  final SharedPreferences _prefs;

  Future<bool> call() async {
    return _prefs.getBool('authenticated') ?? false;
  }
}