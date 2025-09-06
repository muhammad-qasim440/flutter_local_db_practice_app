import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/models/user.dart';
import 'package:flutter_local_db_practice_app/screens/hive_update_user_data_screen.dart';
import 'package:provider/provider.dart';

import '../providers/hive_provider.dart';

class HiveScreen extends StatelessWidget {
  HiveScreen({super.key});
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Hive DB')),
      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Enter your age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async => {
                await hiveProvider.insertUser(
                  User(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                  ),
                ),
              },
              child: Text('Add User'),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: hiveProvider.users.isEmpty
                  ? Center(child: Text('No User Registered Yet'))
                  : ListView.builder(
                      itemCount: hiveProvider.users.length,
                      itemBuilder: (context, index) {
                        final user=hiveProvider.users[index];
                        return Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.horizontal,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          secondaryBackground:Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) async {
                            await hiveProvider.deleteUser(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${user.name} deleted successfully.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            await hiveProvider.loadUsers();

                          },
                          child: ListTile(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HiveUpdateUserDataScreen(
                                    user: User(
                                      name: hiveProvider.users[index].name,
                                      age: hiveProvider.users[index].age,
                                    ),
                                    index: index,
                                  ),
                                ),
                              ),
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(hiveProvider.users[index].name[0]),
                            ),
                            title: Text(
                              'Name : ${hiveProvider.users[index].name}',
                            ),
                            subtitle: Text(
                              'Age: ${hiveProvider.users[index].age}',
                            ),
                            // trailing: IconButton(
                            //   onPressed: () async =>
                            //       await hiveProvider.deleteUser(index),
                            //   icon: Icon(Icons.delete),
                            // ),
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
