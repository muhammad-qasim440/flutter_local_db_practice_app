import 'package:flutter/material.dart';
import 'package:flutter_local_db_practice_app/models/user.dart';
import 'package:flutter_local_db_practice_app/providers/hive_provider.dart';
import 'package:flutter_local_db_practice_app/providers/isar_provider.dart';
import 'package:flutter_local_db_practice_app/providers/shared_prefs_provider.dart';
import 'package:flutter_local_db_practice_app/screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SharedPreferencesProvider()..loadUsername(),
        ),
        ChangeNotifierProvider(create: (_) => HiveProvider()..loadUsers()),
        ChangeNotifierProvider(create: (_)=>IsarProvider()..loadUsers()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local DB Practices',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      themeMode: ThemeMode.dark,


    );
  }
}
