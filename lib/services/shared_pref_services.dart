import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices{
  static const _KeyUsername='username';

  Future<void> saveUsername(String username)async{
    final prefs= await SharedPreferences.getInstance();
    await prefs.setString(_KeyUsername,username);
  }

  Future<String?> getUsername() async {
    final prefs=await SharedPreferences.getInstance();
   return prefs.getString(_KeyUsername);
  }

  Future<void> clearUser() async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.clear();
  }
}