import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class GotwoVerification extends StatefulWidget {
  @override
  State<GotwoVerification> createState() => _GotwoVerificationState();
}

class _GotwoVerificationState extends State<GotwoVerification> {
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final isRunning = timer == null ? false : timer!.isActive;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.white,
          Colors.white,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _aText(),
            const SizedBox(height: 20),
            _verificationText(),
            const SizedBox(height: 20),
            _numberText(),
            const SizedBox(height: 20),
            _verifyBox(),
            const SizedBox(height: 20),
            _timerText(),
            const SizedBox(height: 20),
            _bText(),
            const SizedBox(height: 20),
            _verifyBtn(),
          ],
        ),
      ),
    );
  }

  Widget _aText() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 100),
      child: Text(
        "Verification",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 50,
            color: Color(0xff1a1c43),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _verificationText() {
    return const Text(
      "Verification Code sent to",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xff1a1c43),
      ),
    );
  }

  Widget _numberText() {
    return const Text(
      "092xxxxxxx",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xff1a1c43),
      ),
    );
  }

  Widget _verifyBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 130),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(120, 24),
          foregroundColor: Colors.blue,
          backgroundColor: const Color(0xff1a1c43),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 2),
        ),
        child: const SizedBox(
            width: double.infinity,
            child: Text(
              "Verify",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
      ),
    );
  }

  Widget _verifyBox() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: (s) {
        return s == '2222' ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }

  Widget _timerText() {
    // timer = Timer.periodic(Duration(seconds: 1), (_) {
    //   setState(() => seconds--);
    // });
    return Text(
      '00 : $seconds',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        color: Color(0xff1a1c43),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _bText() {
    return const Text(
      'Resend OTP',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xff1a1c43),
      ),
    );
  }
}
