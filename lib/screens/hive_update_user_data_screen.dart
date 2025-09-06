import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/models/user.dart';
import 'package:flutter_local_db_practice_app/providers/hive_provider.dart';
import 'package:provider/provider.dart';

class HiveUpdateUserDataScreen extends StatefulWidget {
  final User user;
  final int index;
  const HiveUpdateUserDataScreen({
    super.key,
    required this.user,
    required this.index,
  });

  @override
  State<HiveUpdateUserDataScreen> createState() =>
      _HiveUpdateUserDataScreenState();
}

class _HiveUpdateUserDataScreenState extends State<HiveUpdateUserDataScreen> {
  late final _nameController = TextEditingController();
  late final _ageController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.user.name;
    _ageController.text = widget.user.age.toString();
    super.initState();
  }

  Future<void> updateData() async {
    final hiveProvider = Provider.of<HiveProvider>(context, listen: false);
    final user = User(
      name: _nameController.text,
      age: int.parse(_ageController.text),
    );
    if (user.name == widget.user.name && user.age == widget.user.age) {
      return;
    }
    await hiveProvider.updateUser(widget.index, user);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('User Updated Successfully',textAlign: TextAlign.center,),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Update User Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () async => await updateData(),
              child: Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
