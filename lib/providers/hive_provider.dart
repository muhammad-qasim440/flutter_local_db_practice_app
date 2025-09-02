import 'package:flutter/widgets.dart';
import 'package:flutter_local_db_practice_app/services/hive_services.dart';

import '../models/user.dart';

class HiveProvider with ChangeNotifier{
final hiveService=HiveService();
List<User> users=[];

Future<void> loadUsers()async{
  users= await hiveService.getUsers();
  notifyListeners();
}

Future<void> insertUser(User user) async{
  await hiveService.addUser(user);
  await loadUsers();
}


Future<void> updateUser(int index,User user)async{
  await hiveService.updateUser(index,user);
  await loadUsers();
}


Future<void> deleteUser(int index) async{
  await hiveService.deleteUser(index);
  await loadUsers();
}
}