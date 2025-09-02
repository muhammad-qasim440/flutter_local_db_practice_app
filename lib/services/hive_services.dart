import 'package:hive/hive.dart';

import '../models/user.dart';

class HiveService {
  static const _boxname = "users";

  Future<void> addUser(User user) async {
    final box = await Hive.openBox<User>(_boxname);
    await box.add(user);
  }

  Future<List<User>> getUsers() async{
    final box=await Hive.openBox<User>(_boxname);
    return box.values.toList();

  }


  Future<void> updateUser(int index, User user) async{
    final box=await Hive.openBox<User>(_boxname);
    await box.putAt(index, user);
  }

  Future<void> deleteUser(int index) async{
    final box=await Hive.openBox<User>(_boxname);
    await box.deleteAt(index);
  }
}