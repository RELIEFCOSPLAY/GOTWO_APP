import 'package:flutter/material.dart';

class Rider_Register extends StatefulWidget {
  @override
  State<Rider_Register> createState() => _Rider_RegisterState();
}

class _Rider_RegisterState extends State<Rider_Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emaiController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  static const List<String> list = <String>[
    'Gender',
    'Male',
    'Female',
  ];
  String dropdownValue = list.first;

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 5),
              _icon(),
              const SizedBox(height: 10),
              _inputField("Username", usernameController),
              const SizedBox(height: 5),
              _inputField("Email", emaiController),
              const SizedBox(height: 5),
              _inputField("Phone number", phoneController),
              const SizedBox(height: 5),
              _dropdown(),
              const SizedBox(height: 5),
              _inputField("Create Password", createPasswordController,
                  isPassword: true),
              const SizedBox(height: 5),
              _inputField("Confirm Password", confirmPasswordController,
                  isPassword: true),
              const SizedBox(height: 5),
              _registerBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 46, color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff1a1c43), width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Color(0xff1a1c43), size: 50),
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

  Widget _dropdown() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return DropdownButtonFormField<String>(
      hint: const Text('Gender'),
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
      ),
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(
          color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
      borderRadius: BorderRadius.circular(18),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Username : " + usernameController.text);
        debugPrint("Emai : " + emaiController.text);
        debugPrint("Phone : " + phoneController.text);
        debugPrint("Create Password : " + createPasswordController.text);
        debugPrint("Confirm Password : " + confirmPasswordController.text);
        debugPrint("Gender: " + dropdownValue);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(120, 34),
        foregroundColor: Colors.blue,
        backgroundColor: Color(0xff1a1c43),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 6),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Next",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }
}
