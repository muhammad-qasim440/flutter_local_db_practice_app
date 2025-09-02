import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/screens/hive_screen.dart';
import 'package:flutter_local_db_practice_app/screens/shared_preferences_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SharedPreferencesScreen()),
                ),
              },
              child: Text('SharedPreferences'),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HiveScreen()),
                ),
              },
              child: Text('Hive'),
            ),
          ],
        ),
      ),
    );
  }
}
