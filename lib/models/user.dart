import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

part 'user.g.dart';

@HiveType(typeId:0)
@collection
class User{
  /// first field of User data
  @HiveField(0)
  Id id=Isar.autoIncrement;

  /// second filed of User data
  @HiveField(1)
  String name;

  /// third field of User data
 @HiveField(2)
  int age;

 User({required this.name,required this.age});
}
