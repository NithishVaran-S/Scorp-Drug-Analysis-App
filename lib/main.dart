import 'package:flutter/material.dart';
import 'package:scorp/pages/home_pg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 215, 23, 23)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black
      ),
      home:ScorpHomePage(),
    );
  }
}
