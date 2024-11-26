import 'package:flutter/material.dart';
import 'package:gotwo_app/gotwo_condition.dart';
import 'package:gotwo_app/gotwo_loginr.dart';

class GotwoHomepage extends StatefulWidget {
  const GotwoHomepage({super.key});

  @override
  State<GotwoHomepage> createState() => _GotwoHomepageState();
}

class _GotwoHomepageState extends State<GotwoHomepage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1c43),
      body: _page(),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            _logoText(),
            const SizedBox(height: 10),
            Container(
              width: 300,
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xff414465),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _loginBtn(),
                  const SizedBox(height: 20),
                  _registerBtn(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _extraText(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Image.asset(
      'asset/images/pngegg.png',
      height: 200,
      width: 200,
    );
  }

  Widget _logoText() {
    return const Column(
      children: [
        Text(
          "GOTWO",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 46, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "Ride sharing service",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("LoginBtn");
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Loginpage()),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(250, 60),
        foregroundColor: const Color(0xff14bc9c),
        backgroundColor: const Color(0xff1a1c43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Color(0xff1a1c43),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "LOG IN",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("RegisterBtn");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const  GotwoCondition()),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(250, 60),
        foregroundColor: const Color(0xff14bc9c),
        backgroundColor: const Color(0xff414465),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Color(0xff1a1c43),
            width: 3,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }

  Widget _extraText() {
    return const Text(
      "by gotwo ride sharing service",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Colors.grey),
    );
  }
}
