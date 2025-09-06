import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/services/isar_services.dart';

import '../models/user.dart';

class IsarProvider with ChangeNotifier{
  final service=IsarServices();
  List<User> users=[];

  Future<void> loadUsers()async{
    users=await service.getAllUsers();
    notifyListeners();
  }

  Future<void> insertNewUser(User user)async{
    await service.insertUser(user);
    await loadUsers();
  }

  Future<void> deleteUser(int id) async{
    await service.deleteUser(id);
    await loadUsers();
  }

  Future<void> updateUser(User user) async{
    await service.updateUser(user);
    await loadUsers();
  }
}