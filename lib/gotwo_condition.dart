import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class GotwoCondition extends StatefulWidget {
  @override
  State<GotwoCondition> createState() => _GotwoConditionState();
}

class _GotwoConditionState extends State<GotwoCondition> {
  bool isChecked = false;

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
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _aText(),
              const SizedBox(height: 20),
              _condition(),
              const SizedBox(height: 20),
              _checkbox(),
              const SizedBox(height: 20),
              _confirmBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aText() {
    return const Text(
      "Term and Condition",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 26, color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
    );
  }

  Widget _condition() {
    return Column(
      children: [
        SizedBox(
          height: 350,
          width: 250,
          child: Text(loremIpsum(
              words: 60, paragraphs: 3, initWithLorem: true)), // Text test
        ),
      ],
    );
  }

  Widget _checkbox() {
    return CheckboxListTile(
      title: const Text(
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Color(0xff1a1c43),
          ),
          "I accept and agree to the Terms of Use."),
      checkColor: Colors.white,
      activeColor: Color(0xff1a1c43),
      value: isChecked,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(
          () {
            isChecked = value!;
          },
        );
      },
    );
  }

  Widget _confirmBtn() {
    return ElevatedButton(
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
            "Confirm",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }
}
