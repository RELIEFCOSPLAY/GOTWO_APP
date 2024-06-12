import 'package:flutter/material.dart';

class Rider_Register extends StatefulWidget {
  const Rider_Register({super.key});

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
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 46,
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
        padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 10),
              _inputField("Username", usernameController),
              const SizedBox(height: 10),
              _inputField("Email", emaiController),
              const SizedBox(height: 10),
              _inputField("Phone number", phoneController),
              const SizedBox(height: 10),
              _dropdown(),
              const SizedBox(height: 10),
              _inputField("Create Password", createPasswordController,
                  isPassword: true),
              const SizedBox(height: 10),
              _inputField("Confirm Password", confirmPasswordController,
                  isPassword: true),
              const SizedBox(height: 15),
              _registerBtn(),
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

  Widget _icon() {
    return GestureDetector(
      onTap: () {
        debugPrint("Add Photo");
      },
      child: Container(
        decoration: BoxDecoration(
          color:const Color(0xff1a1c43) ,
            border: Border.all(color: const Color(0xff1a1c43), width: 3),
            shape: BoxShape.circle),
        child: const Icon(Icons.person, color: Colors.white, size: 50),
      ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: _snackBarnotification(),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        debugPrint("Username : ${usernameController.text}");
        debugPrint("Emai : ${emaiController.text}");
        debugPrint("Phone : ${phoneController.text}");
        debugPrint("Create Password : ${createPasswordController.text}");
        debugPrint("Confirm Password : ${confirmPasswordController.text}");
        debugPrint("Gender: $dropdownValue");
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 34),
        foregroundColor: Colors.blue,
        backgroundColor: const Color(0xff1a1c43),
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

  Widget _snackBarnotification() {
    if (usernameController.text == "" &&
        emaiController.text == "" &&
        phoneController.text == "" &&
        createPasswordController.text == "" &&
        confirmPasswordController.text == "" &&
        dropdownValue == "Gender") {
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
