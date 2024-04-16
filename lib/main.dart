import 'package:flutter/material.dart';
import 'package:todo/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // hive initiated //
  await Hive.initFlutter();

  //  hive box
  var box = await Hive.openBox("todo");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
