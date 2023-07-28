import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_login/screens/add_student.dart';
import 'package:student_login/screens/home.dart';

import 'models/data_model.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lime),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => Add(),
      },
      initialRoute: '/',
    );
  }
}
