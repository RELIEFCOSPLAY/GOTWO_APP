import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pinput/pinput.dart';

class GotwoVerification extends StatefulWidget {
  const GotwoVerification({super.key});

  @override
  State<GotwoVerification> createState() => _GotwoVerificationState();
}

class _GotwoVerificationState extends State<GotwoVerification> {
  String? pin1, pin2, pin3, pin4;
  String? pinAll;

// ------------------------------
  bool invalidOtp = false;
  int resendTime = 30;
  late Timer countdownTimer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String strFormatting(n) => n.toString().padLeft(2, '0');
// ------------------------------

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _backButton(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Verification",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff1a1c43),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              _verificationText(),
              const SizedBox(height: 20),
              _numberText(),
              const SizedBox(height: 20),
              _verifyField(),
              const SizedBox(height: 20),
              _timer(),
              const SizedBox(height: 40),
              _verifyBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("back");
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: Color(0xff1a1c43),
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

  // Widget _verifyBox() {
  //   final defaultPinTheme = PinTheme(
  //     width: 56,
  //     height: 56,
  //     textStyle: const TextStyle(
  //         fontSize: 20,
  //         color: Color.fromRGBO(30, 60, 87, 1),
  //         fontWeight: FontWeight.w600),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //   );

  //   final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  //     border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  //     borderRadius: BorderRadius.circular(8),
  //   );

  //   final submittedPinTheme = defaultPinTheme.copyWith(
  //     decoration: defaultPinTheme.decoration?.copyWith(
  //       color: const Color.fromRGBO(234, 239, 243, 1),
  //     ),
  //   );
  //   return Pinput(
  //     defaultPinTheme: defaultPinTheme,
  //     focusedPinTheme: focusedPinTheme,
  //     submittedPinTheme: submittedPinTheme,
  //     validator: (s) {
  //       return s == '2222' ? null : 'Pin is incorrect';
  //     },
  //     pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
  //     showCursor: true,
  //     onCompleted: (pin) => print(pin),
  //   );
  // }

  Widget _verifyField() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: TextFormField(
              onChanged: (value) {
                pin1 = value;
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xff1a1c43)),
                enabledBorder: border,
                focusedBorder: border,
                hintText: "0",
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: TextFormField(
              onChanged: (value) {
                pin2 = value;
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xff1a1c43)),
                enabledBorder: border,
                focusedBorder: border,
                hintText: "0",
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: TextFormField(
              onChanged: (value) {
                pin3 = value;
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xff1a1c43)),
                enabledBorder: border,
                focusedBorder: border,
                hintText: "0",
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: TextFormField(
              onChanged: (value) {
                pin4 = value;
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xff1a1c43)),
                enabledBorder: border,
                focusedBorder: border,
                hintText: "0",
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Haven't received OTP yet?",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1a1c43),
              ),
            ),
            const SizedBox(width: 10),
            resendTime == 0
                ? InkWell(
                    onTap: () {
                      // Resend OTP Code
                      invalidOtp = false;
                      resendTime = 30;
                      startTimer();
                      //
                    },
                    child: const Text(
                      'Resend',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        const SizedBox(height: 10),
        resendTime != 0
            ? Text(
                'You can resend OTP after ${strFormatting(resendTime)} s',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff1a1c43),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 5),
        Text(
          invalidOtp ? 'Invalid otp!' : '',
          style: const TextStyle(fontSize: 20, color: Colors.red),
        ),
      ],
    );
  }

  Widget _verifyBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: _snackBarnotification(),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
          pinAll = "$pin1$pin2$pin3$pin4";
          debugPrint("OTP : $pinAll");
        },
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
          ),
        ),
      ),
    );
  }

  Widget _snackBarnotification() {
    if (pinAll == null) {
      return Container(
        padding: const EdgeInsets.all(8),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.redAccent)),
        child: const Row(
          children: [
            SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oh snap!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1a1c43),
                    ),
                  ),
                  Text(
                    "Username or Password is Wrong",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff1a1c43),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
