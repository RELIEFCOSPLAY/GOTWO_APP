import 'package:flutter/material.dart';

class GotwoLogin extends StatefulWidget {
  @override
  State<GotwoLogin> createState() => _GotwoLoginState();
}

class _GotwoLoginState extends State<GotwoLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
             _loginText(),
            const SizedBox(height: 20),
            _inputField("Username", usernameController),
            const SizedBox(height: 20),
            _inputField("Password", passwordController, isPassword: true),
            const SizedBox(height: 20),
            _loginBtn(),
            const SizedBox(height: 20),
            _extraText(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Image.asset('asset/images/pngegg.png');
  }

  Widget _loginText() {
    return const Text(
      "LOGIN",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 46, color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return TextField(
      style: const TextStyle(color: Color(0xff1a1c43)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xff1a1c43)),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Username : " + usernameController.text);
        debugPrint("Password : " + passwordController.text);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(120, 34),
        foregroundColor: Colors.blue,
        backgroundColor: Color(0xff1a1c43),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "LOG IN ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }

  Widget _extraText() {
    return const Text(
      "Can't access to your account?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Color(0xff1a1c43)),
    );
  }
}
