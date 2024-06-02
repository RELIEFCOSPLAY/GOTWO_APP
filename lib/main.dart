import 'package:flutter/material.dart';
import 'package:gotwo_app/gotwo_Information.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_Register.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_login.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GotwoInformation(),
    );
  }
}