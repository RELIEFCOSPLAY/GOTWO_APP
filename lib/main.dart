import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_cancel.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_request.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_confirmCustomer.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_confirmRider.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_success_paid.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_success_unpaid.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_totravel.dart';
// ignore: unused_import
import 'package:gotwo_app/gotwo_wallet.dart';

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
      home: const GotwoCancel(),
    );
  }
}
