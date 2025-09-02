import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/models/user.dart';
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
                        return ListTile(
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
                          trailing: IconButton(
                            onPressed: () async =>
                                await hiveProvider.deleteUser(index),
                            icon: Icon(Icons.delete),
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
