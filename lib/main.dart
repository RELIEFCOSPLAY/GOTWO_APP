import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_DashbordRider.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_Homepage.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_Information.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_PostInfor.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_PostPage.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_PostPage_old.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_Register.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_SatusRider.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_Verification.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_condition.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_login.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_loginr.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_request.dart';

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
      home: Loginpage(),
    );
  }
}
