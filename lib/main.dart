import 'package:flutter/material.dart';

import 'package:gotwo_app/gotwo_Information.dart';

import 'package:gotwo_app/gotwo_Register.dart';

import 'package:gotwo_app/gotwo_Verification.dart';

import 'package:gotwo_app/gotwo_condition.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1a1c43)),
        useMaterial3: true,
      ),
      home: GotwoCondition(),
    );
  }
}
