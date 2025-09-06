import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/models/user.dart';
import 'package:flutter_local_db_practice_app/providers/isar_provider.dart';
import 'package:provider/provider.dart';

class IsarUpdateUserDataScreen extends StatefulWidget {
  final User user;
  const IsarUpdateUserDataScreen({
    super.key,
    required this.user,
  });

  @override
  State<IsarUpdateUserDataScreen> createState() =>
      _IsarUpdateUserDataScreenState();
}

class _IsarUpdateUserDataScreenState extends State<IsarUpdateUserDataScreen> {
  late final _nameController = TextEditingController();
  late final _ageController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.user.name;
    _ageController.text = widget.user.age.toString();
    super.initState();
  }

  Future<void> updateData() async {
    final isarProvider = Provider.of<IsarProvider>(context, listen: false);
    final user = User(
      name: _nameController.text,
      age: int.parse(_ageController.text),
    );
    if (user.name == widget.user.name && user.age == widget.user.age) {
      return;
    }
    await isarProvider.updateUser(user);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('User Updated Successfully', textAlign: TextAlign.center),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isarProvider = Provider.of<IsarProvider>(context);
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
