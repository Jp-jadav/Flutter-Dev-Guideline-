import 'package:flutter/material.dart';
import 'package:zodiac/DBHelper/db_handler.dart';
import 'package:zodiac/Models/registration.dart';
import 'package:zodiac/Pages/registration_screen.dart';
import 'package:zodiac/Pages/zodiac_group_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ZodiacGroupScreen(),
    );
  }
}
