import 'package:flutter_local_db_practice_app/models/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarServices {
  late Future<Isar> db;

  IsarServices(){
    db=_init();
  }

  Future<Isar> _init()async{
    final dir=await getApplicationDocumentsDirectory();
    return await Isar.open([UserSchema], directory: dir.path);
  }

  Future<void> insertUser(User user)async{
    final isar=await db;
    await isar.writeTxn(()=>isar.users.put(user));
  }

  Future<List<User>> getAllUsers()async{
    final isar=await db;
    return await isar.users.where().findAll();
  }

  Future<void> updateUser(User user)async{
    final isar=await db;
    await isar.writeTxn(()=> isar.users.put(user));
  }

  Future<void> deleteUser(int id) async{
    final isar=await db;
    await isar.writeTxn(()=>isar.users.delete(id));
  }
}


// import 'package:isar/isar.dart';
//
// // Example model
// @collection
// class User {
//   Id id = Isar.autoIncrement; // auto-increment id
//   late String name;
//   late int age;
// }
//
// // Updating a record
// Future<void> updateUser(Isar isar, int userId) async {
//   await isar.writeTxn(() async {
//     // Find the existing user
//     final user = await isar.users.get(userId);
//
//     if (user != null) {
//       // Update fields
//       user.name = "Updated Name";
//       user.age = 30;
//
//       // Save (put) again
//       await isar.users.put(user);
//     }
//   });
// }
