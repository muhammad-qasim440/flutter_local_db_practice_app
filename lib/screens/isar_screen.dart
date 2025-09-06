import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/models/user.dart';
import 'package:flutter_local_db_practice_app/providers/isar_provider.dart';
import 'package:provider/provider.dart';

import 'isar_update_user_data_screen.dart';

class IsarScreen extends StatelessWidget {
  IsarScreen({super.key});
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isarProvider = Provider.of<IsarProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Isar Screen')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'enter user name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'enter user age',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = User(
                  name: _nameController.text,
                  age: int.parse(_ageController.text),
                );
                await isarProvider.insertNewUser(user);
              },
              child: Text('Add User'),
            ),

            const SizedBox(height: 20),
            Expanded(
              child:isarProvider.users.isEmpty
                  ? Center(child: Text('No User Registered Yet'))
                  : ListView.builder(
                itemCount: isarProvider.users.length,
                itemBuilder: (ctx, i) {
                  final user=isarProvider.users[i];
                  return Dismissible(
                    key: Key(user.id.toString()),
                    direction: DismissDirection.horizontal,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) async {
                      await isarProvider.deleteUser(user.id);
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${user.name} deleted successfully.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      await isarProvider.loadUsers();
                    },
                    child: ListTile(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => IsarUpdateUserDataScreen(
                              user: User(
                                name: isarProvider.users[i].name,
                                age: isarProvider.users[i].age,
                              ),
                            ),
                          ),
                        ),
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(isarProvider.users[i].name[0]),
                      ),
                      title: Text(
                        'Name : ${isarProvider.users[i].name}',
                      ),
                      subtitle: Text(
                        'Age: ${isarProvider.users[i].age}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
