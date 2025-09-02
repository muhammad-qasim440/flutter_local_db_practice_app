import 'package:flutter/cupertino.dart';
import 'package:flutter_local_db_practice_app/services/shared_pref_services.dart';

class SharedPreferencesProvider with ChangeNotifier{
  final _service=SharedPreferencesServices();
  String? username;

  Future<void> setUsername(String userName) async {
    await _service.saveUsername(userName);
    username=userName;
    notifyListeners();
  }

  Future<void> loadUsername() async{
    username=await _service.getUsername();
    notifyListeners();
  }

  Future<void> clearUsername()async{
    await _service.clearUser();
    username=null;
    notifyListeners();
  }

}