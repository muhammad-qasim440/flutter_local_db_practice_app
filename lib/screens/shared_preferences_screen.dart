import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/providers/shared_prefs_provider.dart';
import 'package:provider/provider.dart';

class SharedPreferencesScreen extends StatelessWidget {
   SharedPreferencesScreen({super.key});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sharedPrefsProvider = Provider.of<SharedPreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SharedPreferences'),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter user name"),
            ),
      
            const SizedBox(height: 20,),
            
            Row(
              children: [
                ElevatedButton(onPressed: ()=>sharedPrefsProvider.setUsername(_controller.text), child: Text('Save')),
                const SizedBox(width: 20,),
                ElevatedButton(onPressed: ()=>sharedPrefsProvider.clearUsername(), child: Text('clear')),
              ],
              
            ),
            const SizedBox(height: 20,),
            Consumer(builder: (BuildContext context, value, Widget? child) {

              return Text('Saved Username: ${sharedPrefsProvider.username??"none"}');
            },
            ),
            
          ],
        ),
      ),
    );
  }
}
